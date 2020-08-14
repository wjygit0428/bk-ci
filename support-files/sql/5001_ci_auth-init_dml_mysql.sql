use devops_ci_auth;
SET NAMES utf8mb4;

-- 内置组权限初始化
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("4c36a72256d948429a97e3af2db30de2","project_view","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("f1c02514904a4d838448cf3966a80766","project_create","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("2cd11ebbaa704d049120471eee4a0056","project_edit","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("bc329e44b9164e41b4a3bb4e639e628d","project_delete","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("92ed7dff747446e8aec46cc9a780844e","project_manage","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("9afd78a150e742db8b92cc8a10f00212","pipeline_view","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("d2ca3168f997441889292071b18b98a1","pipeline_edit","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("666392edd0a44833b7b48337e4569267","pipeline_create","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("b81608de171245178b7132a737df90d4","pipeline_download","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("e3cafd081eba42a7ba4b8e0bb75cb2ec","pipeline_delete","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("b05910a4393240639c38c1ea5a9cc9f3","pipeline_share","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("263e5a3a477a43409eda907da129f49a","pipeline_execute","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("f712d7cc0ea5409f8b50b0ca0f683ffa","repository_view","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("04f998f73e154d3b9f53d8b2124895f5","repository_edit","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("567e36852ce6445594b011c1a6db10a8","repository_create","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("cb1073a80c93478da4847626ad4bb9e7","repository_delete","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("d78848554bf84ca29c494c715d8b0db6","repository_use","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("37874321490a46fcaf9440c84e6ac387","credential_view","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("6f4d8072e5164f548af4c9600af7cf0c","credential_edit","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("6aecf1fe99f0454080f7f65f6568121d","credential_create","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("18476e40f7fb4d25a086317fdadc6e17","credential_delete","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("40ce7c43ca0c4aee937e23168302239e","credential_use","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("e82a54bb1c524b9bba10cb16c83a6365","environment_view","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("5bb762cc7aa44b2fb26afe4131b1242f","environment_edit","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("d3ee469b8c324e2ba8a15c03d5101e67","environment_create","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("ed99b3b3d4804213b69d6c147a1b06f9","environment_delete","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("ce50200212e04d0583ed3e5f2e9f01f3","environment_use","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("4536e49cd3bc493682b341c1c23ca660","node_view","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("fa11f19c60194763a60d7b70bc58adaf","node_edit","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("3ab6baa47c8f4aada46bf5272b700b71","node_create","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("aed4275ee6f948f9a6049ffa6da35593","node_delete","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
REPLACE INTO  `T_AUTH_GROUP_PERSSION` (`ID`, `AUTH_ACTION`, `GROUP_CODE`, `CREATE_USER`, `UPDATE_USER`, `CREATE_TIME`, `UPDATE_TIME`) VALUES  ("1bc8bc33341149f78a049e1a43c99f20","node_use","ciAdmin","system",'',"2020-06-25 17:13:58",NULL);
