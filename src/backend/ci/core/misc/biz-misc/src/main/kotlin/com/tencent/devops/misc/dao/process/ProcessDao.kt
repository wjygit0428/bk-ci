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

package com.tencent.devops.misc.dao.process

import com.tencent.devops.model.process.tables.TPipelineBuildHisDataClear
import com.tencent.devops.model.process.tables.TPipelineBuildHistory
import com.tencent.devops.model.process.tables.TPipelineInfo
import org.jooq.Condition
import org.jooq.DSLContext
import org.jooq.Record
import org.jooq.Result
import org.jooq.impl.DSL
import org.springframework.stereotype.Repository
import java.time.LocalDateTime

@Repository
class ProcessDao {

    fun addBuildHisDataClear(
        dslContext: DSLContext,
        projectId: String,
        pipelineId: String,
        buildId: String
    ) {
        with(TPipelineBuildHisDataClear.T_PIPELINE_BUILD_HIS_DATA_CLEAR) {
            dslContext.insertInto(this,
                PROJECT_ID,
                PIPELINE_ID,
                BUILD_ID)
                .values(
                    projectId,
                    pipelineId,
                    buildId
                ).onDuplicateKeyUpdate()
                .set(PROJECT_ID, projectId)
                .set(BUILD_ID, buildId)
                .execute()
        }
    }

    fun getPipelineIdListByProjectId(
        dslContext: DSLContext,
        projectId: String
    ): Result<out Record>? {
        with(TPipelineInfo.T_PIPELINE_INFO) {
            return dslContext.select(PIPELINE_ID).from(this).where(PROJECT_ID.eq(projectId)).fetch()
        }
    }

    fun getMaxPipelineBuildNum(
        dslContext: DSLContext,
        projectId: String,
        pipelineId: String
    ): Long {
        with(TPipelineBuildHistory.T_PIPELINE_BUILD_HISTORY) {
            return dslContext.select(DSL.max(BUILD_NUM))
                .from(this)
                .where(PROJECT_ID.eq(projectId).and(PIPELINE_ID.eq(pipelineId)))
                .fetchOne(0, Long::class.java)
        }
    }

    fun getTotalBuildCount(
        dslContext: DSLContext,
        pipelineId: String,
        maxBuildNum: Int? = null,
        maxStartTime: LocalDateTime? = null
    ): Long {
        with(TPipelineBuildHistory.T_PIPELINE_BUILD_HISTORY) {
            val conditions = getQueryBuildHistoryCondition(pipelineId, maxBuildNum, maxStartTime)
            return dslContext.select(DSL.max(BUILD_NUM))
                .from(this)
                .where(conditions)
                .fetchOne(0, Long::class.java)
        }
    }

    private fun TPipelineBuildHistory.getQueryBuildHistoryCondition(
        pipelineId: String,
        maxBuildNum: Int?,
        maxStartTime: LocalDateTime?
    ): MutableList<Condition> {
        val conditions = mutableListOf<Condition>()
        conditions.add(PIPELINE_ID.eq(pipelineId))
        if (maxBuildNum != null) {
            conditions.add(BUILD_NUM.le(maxBuildNum))
        }
        if (maxStartTime != null) {
            conditions.add(START_TIME.lt(maxStartTime))
        }
        return conditions
    }

    fun getHistoryBuildIdList(
        dslContext: DSLContext,
        pipelineId: String,
        totalHandleNum: Int,
        handlePageSize: Int,
        isCompletelyDelete: Boolean,
        maxBuildNum: Int? = null,
        maxStartTime: LocalDateTime? = null
    ): Result<out Record>? {
        with(TPipelineBuildHistory.T_PIPELINE_BUILD_HISTORY) {
            val conditions = getQueryBuildHistoryCondition(pipelineId, maxBuildNum, maxStartTime)
            val baseStep = dslContext.select(BUILD_ID)
                .from(this)
                .where(conditions)
            if (isCompletelyDelete) {
                baseStep.limit(handlePageSize)
            } else {
                baseStep.limit(totalHandleNum, handlePageSize)
            }
            return baseStep.fetch()
        }
    }
}
