/*
 * Tencent is pleased to support the open source community by making BK-CI 蓝鲸持续集成平台 available.
 *
 * Copyright (C) 2019 THL A29 Limited, a Tencent company.  All rights reserved.
 *
 * BK-CI 蓝鲸持续集成平台 is licensed under the MIT license.
 *
 * A copy of the MIT License is included in this file.
 *
 *
 * Terms of the MIT License:
 * ---------------------------------------------------
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of
 * the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
 * NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.tencent.devops.process.engine.control.command.container.impl

import com.tencent.devops.common.event.dispatcher.pipeline.PipelineEventDispatcher
import com.tencent.devops.common.event.enums.ActionType
import com.tencent.devops.common.log.utils.BuildLogPrinter
import com.tencent.devops.common.pipeline.enums.BuildStatus
import com.tencent.devops.process.engine.common.BS_CONTAINER_END_SOURCE_PREIX
import com.tencent.devops.process.engine.common.VMUtils
import com.tencent.devops.process.engine.control.MutexControl
import com.tencent.devops.process.engine.control.command.CmdFlowState
import com.tencent.devops.process.engine.control.command.container.ContainerCmd
import com.tencent.devops.process.engine.control.command.container.ContainerContext
import com.tencent.devops.process.engine.pojo.event.PipelineBuildStageEvent
import com.tencent.devops.process.engine.service.PipelineBuildDetailService
import com.tencent.devops.process.engine.service.PipelineRuntimeService
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Service
class UpdateStateContainerCmdFinally(
    private val mutexControl: MutexControl,
    private val pipelineRuntimeService: PipelineRuntimeService,
    private val pipelineBuildDetailService: PipelineBuildDetailService,
    private val pipelineEventDispatcher: PipelineEventDispatcher,
    private val buildLogPrinter: BuildLogPrinter
) : ContainerCmd {
    override fun canExecute(commandContext: ContainerContext): Boolean {
        return commandContext.cmdFlowState == CmdFlowState.FINALLY && !commandContext.container.status.isFinish()
    }

    override fun execute(commandContext: ContainerContext) {
        // 更新状态模型
        updateContainerStatus(commandContext = commandContext)
        // 结束时才会释放锁定及返回
        if (commandContext.buildStatus.isFinish()) {
            // 释放互斥组
            mutexRelease(commandContext = commandContext)
        }
        // 发送回Stage
        if (commandContext.buildStatus.isFinish() || commandContext.buildStatus == BuildStatus.UNKNOWN) {
            val source = commandContext.event.source
            val buildId = commandContext.container.buildId
            val stageId = commandContext.container.stageId
            val containerId = commandContext.container.containerId
            LOG.info("ENGINE|$buildId|$source|CONTAINER_FIN|$stageId|j($containerId)|" +
                "${commandContext.buildStatus}|${commandContext.latestSummary}")
            sendBackStage(commandContext = commandContext)
        }
    }

    /**
     * 释放[commandContext]中指定的互斥组
     */
    private fun mutexRelease(commandContext: ContainerContext) {
        // 返回stage的时候，需要解锁
        mutexControl.releaseContainerMutex(
            projectId = commandContext.event.projectId,
            buildId = commandContext.event.buildId,
            stageId = commandContext.event.stageId,
            containerId = commandContext.event.containerId,
            mutexGroup = commandContext.mutexGroup
        )
    }

    /**
     * 更新[commandContext]下指定的Container的状态以及编排模型状态
     */
    private fun updateContainerStatus(commandContext: ContainerContext) {
        val event = commandContext.event
        val buildStatus = commandContext.buildStatus

        var startTime: LocalDateTime? = null
        if (buildStatus == BuildStatus.SKIP || commandContext.container.status.isReadyToRun()) {
            startTime = LocalDateTime.now()
        }

        var endTime: LocalDateTime? = null
        if (buildStatus.isFinish()) {
            endTime = LocalDateTime.now()
        }

        pipelineRuntimeService.updateContainerStatus(
            buildId = event.buildId,
            stageId = event.stageId,
            containerId = event.containerId,
            buildStatus = buildStatus,
            startTime = startTime,
            endTime = endTime
        )

        if (buildStatus == BuildStatus.SKIP) {
            commandContext.containerTasks.forEach { task ->
                pipelineRuntimeService.updateTaskStatus(task = task, userId = task.starter, buildStatus = buildStatus)
            }
            // 刷新Model状态为SKIP，包含containerId下的所有插件任务
            pipelineBuildDetailService.containerSkip(buildId = event.buildId, containerId = event.containerId)
        } else if (commandContext.container.status.isReadyToRun() || buildStatus.isFinish()) {
            // 刷新Model状态-仅更新container状态
            pipelineBuildDetailService.updateContainerStatus(
                buildId = event.buildId, containerId = event.containerId, buildStatus = buildStatus
            )
        }
    }

    /**
     * 将[commandContext]中获得指定stageId,并发送Stage事件回stage
     */
    private fun sendBackStage(commandContext: ContainerContext) {
        with(commandContext.event) {
            val executeCount = commandContext.executeCount
            pipelineEventDispatcher.dispatch(
                PipelineBuildStageEvent(
                    source = "$BS_CONTAINER_END_SOURCE_PREIX${commandContext.buildStatus}", // Fast Kill 依赖
                    projectId = projectId,
                    pipelineId = pipelineId,
                    userId = userId,
                    buildId = buildId,
                    stageId = stageId,
                    actionType = ActionType.REFRESH
                )
            )

            buildLogPrinter.addLine(
                buildId = buildId,
                message = "[$executeCount]| Finish Job#${this.containerId}| summary: ${commandContext.latestSummary}",
                tag = VMUtils.genStartVMTaskId(containerId),
                jobId = containerId,
                executeCount = executeCount
            )
        }
    }

    companion object {
        private val LOG = LoggerFactory.getLogger(UpdateStateContainerCmdFinally::class.java)
    }
}
