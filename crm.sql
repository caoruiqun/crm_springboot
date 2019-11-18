/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2019-10-19 18:45:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_activity`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('31ffa5633d194125a1f91bff04d24d8e', '40f6cdea0bd34aceb77492a1656d9fb3', '海天盛筵', '2019-09-03', '2019-09-24', '50000000', '美女干high了', '2019-09-16 20:47:09', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('33bf5f6f971543f9b3d4490ce8eb811d', '40f6cdea0bd34aceb77492a1656d9fb3', '情人1', '2019-06-19', '2019-06-27', '2', '2', '2019-06-18 12:03:32', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('366be888cba34d0bba29c6a0c954bb56', '40f6cdea0bd34aceb77492a1656d9fb3', '情人网123女大学生', '2019-06-17', '2019-06-24', '2', '爽aa', '2019-06-17 21:02:05', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('58e30abb22204f948a1c67b0a4050069', '40f6cdea0bd34aceb77492a1656d9fb3', '情人网123小三', '2019-06-17', '2019-06-30', '2', '草比', '2019-06-17 21:02:44', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('796434292d374582b8f3c7032f5796a1', '40f6cdea0bd34aceb77492a1656d9fb3', '情人12444444', '2019-06-19', '2019-06-27', '3', '3', '2019-06-18 12:03:45', '张三', '2019-06-18 19:16:00', '张三');
INSERT INTO `tbl_activity` VALUES ('7af72081693d4f269dd279b275b1c8c8', '40f6cdea0bd34aceb77492a1656d9fb3', '情人网123玫瑰', '2019-06-17', '2019-06-24', '2', '爽aa', '2019-06-17 21:01:47', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('8f437dbe664442d5ba258a35305164fe', '40f6cdea0bd34aceb77492a1656d9fb3', '情人网123有钱大叔', '2019-06-17', '2019-06-24', '2', '爽aa', '2019-06-17 21:01:57', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('9ec7e48eb1964270a5a2e7eaf224827a', '40f6cdea0bd34aceb77492a1656d9fb3', '情人网123', '2019-06-17', '2019-06-24', '2', '爽aa', '2019-06-17 21:00:35', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('a5d06777bc824ee6b2ba2572afc399e4', '40f6cdea0bd34aceb77492a1656d9fb3', 'wecaobi', '', '', '34', '', '2019-09-07 17:10:34', '张三', '2019-09-15 23:06:30', '张三');
INSERT INTO `tbl_activity` VALUES ('cc4829a8040943d49aa5e4d5fce0505d', '40f6cdea0bd34aceb77492a1656d9fb3', '换妻', '', '', '0', '刺激', '2019-09-16 20:45:30', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('d8cac4a8b05449beabc8d9e4581ff97c', '40f6cdea0bd34aceb77492a1656d9fb3', '酒店发小广告', '2019-06-18', '2019-06-26', '200', '危险', '2019-06-17 16:17:28', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('efea46325e8341b598bba27a96841a5c', '40f6cdea0bd34aceb77492a1656d9fb3', '白马会所', '', '', '280000', '', '2019-09-16 20:49:10', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('faa226623d234407b725abf47119494e', '40f6cdea0bd34aceb77492a1656d9fb3', '情人网', '2019-06-17', '2019-06-30', '1', '爽', '2019-06-17 21:00:03', '张三', null, null);

-- ----------------------------
-- Table structure for `tbl_activity_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('0248f3abd3324916b578b463994dd844', '有村千佳', '2019-06-19 14:03:40', '张三', '2019-06-19 15:33:10', '张三', '1', '796434292d374582b8f3c7032f5796a1');
INSERT INTO `tbl_activity_remark` VALUES ('14f016ddaebf49ad8d32509052536a6a', '飞机', '2019-06-19 13:53:54', '张三', null, null, '0', '33bf5f6f971543f9b3d4490ce8eb811d');
INSERT INTO `tbl_activity_remark` VALUES ('27374845845859', '69', '2019-06-18 12:03:50', '张三', null, '', '0', '33bf5f6f971543f9b3d4490ce8eb811d');
INSERT INTO `tbl_activity_remark` VALUES ('3e7b6bb6db094a79b8c706c2aa940dd1', 'jan情', '2019-09-15 23:48:26', '张三', '2019-09-16 00:10:42', '张三', '1', 'a5d06777bc824ee6b2ba2572afc399e4');
INSERT INTO `tbl_activity_remark` VALUES ('53d23244cf1f4674aa3ad5e1e380eeca', '吃', '2019-09-15 23:36:04', '张三', null, null, '0', 'a5d06777bc824ee6b2ba2572afc399e4');
INSERT INTO `tbl_activity_remark` VALUES ('551953beb1344a8faf70702d38943d5b', '34626236236', '2019-06-19 13:52:14', '张三', null, null, '0', '33bf5f6f971543f9b3d4490ce8eb811d');
INSERT INTO `tbl_activity_remark` VALUES ('a4cc66a292e44815b9b8554e7c1a7cb3', '轮奸', '2019-09-16 00:02:57', '张三', null, null, '0', 'a5d06777bc824ee6b2ba2572afc399e4');
INSERT INTO `tbl_activity_remark` VALUES ('beba8873f2f34a1d95dddbb80dd2ed1c', '妖媚', '2019-09-11 21:40:41', '张三', null, null, '0', '8f437dbe664442d5ba258a35305164fe');
INSERT INTO `tbl_activity_remark` VALUES ('cd349bf486f04969b1afa825b0c0993d', '胸推', '2019-09-15 23:33:42', '张三', null, null, '0', 'a5d06777bc824ee6b2ba2572afc399e4');
INSERT INTO `tbl_activity_remark` VALUES ('dcac6088824f4b5f92ea7c6d84ed61df', '冰火两重天', '2019-09-16 20:08:47', '张三', '2019-09-16 20:29:30', null, '1', 'a5d06777bc824ee6b2ba2572afc399e4');

-- ----------------------------
-- Table structure for `tbl_clue`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
INSERT INTO `tbl_clue` VALUES ('2e97a8f73ea243e29c4c97a9a1c0d0ac', '北都', '女士', '40f6cdea0bd34aceb77492a1656d9fb3', '小仓柚子', '女友', '', '08-7-7', '', '687979', '试图联系', '销售邮件', '张三', '2019-09-17 21:52:24', null, null, '', '', '', '');
INSERT INTO `tbl_clue` VALUES ('91a704277a0b41708d282551c5877ad2', '马云', '', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'ceo', '', '', '', '', '', '', '张三', '2019-09-13 15:40:53', null, null, '挂了', '退休', '2019-09-24', '');
INSERT INTO `tbl_clue` VALUES ('ca97087f0f3b48169a15582df7c312ea', '王健林', '', '40f6cdea0bd34aceb77492a1656d9fb3', '万达集团', '老总', '', '', '', '', '', '', '张三', '2019-09-13 15:43:02', null, null, '跑路', '地点', '2019-09-24', '');
INSERT INTO `tbl_clue` VALUES ('e211e771f90648b4b88456030b507094', 'faf', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', 'asfaf', '51251', '', '51', '', '414', '试图联系', '销售邮件', '张三', '2019-09-17 21:51:37', null, null, '', '', '', '');

-- ----------------------------
-- Table structure for `tbl_clue_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------
INSERT INTO `tbl_clue_activity_relation` VALUES ('171f40bd0809445ab9fd76ce5bd93733', '91a704277a0b41708d282551c5877ad2', '366be888cba34d0bba29c6a0c954bb56');
INSERT INTO `tbl_clue_activity_relation` VALUES ('5233834b6b994e978d162186ae320fcc', '91a704277a0b41708d282551c5877ad2', '58e30abb22204f948a1c67b0a4050069');
INSERT INTO `tbl_clue_activity_relation` VALUES ('72542081693d4f269dd279b275b1c8c8', 'ca97087f0f3b48169a15582df7c312ea', '7af72081693d4f269dd279b275b1c8c8');
INSERT INTO `tbl_clue_activity_relation` VALUES ('cac816b728954fd49717d7927b0f7ff4', '91a704277a0b41708d282551c5877ad2', '33bf5f6f971543f9b3d4490ce8eb811d');

-- ----------------------------
-- Table structure for `tbl_clue_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_contacts`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('00801f74b0974e79b40374d0aed0eba9', '40f6cdea0bd34aceb77492a1656d9fb3', '', '1422d1b3f73a409da84fd5172a2301f0', 'gagg', '交易会', '', '', '', null, '张三', '2019-09-18 22:57:48', null, null, '', '', '', '');
INSERT INTO `tbl_contacts` VALUES ('1378508501c54db3bc00ad00b06713f7', '40f6cdea0bd34aceb77492a1656d9fb3', '', '227b36b8c0ea41d78a679aae1c97e8f7', '22', '', 'bh', '166', '', null, '张三', '2019-09-18 23:03:52', null, null, '', '', '', '');
INSERT INTO `tbl_contacts` VALUES ('bde34abf9b1c4a229c9944a783d6f361', '40f6cdea0bd34aceb77492a1656d9fb3', '合作伙伴研讨会', '8b0db1b6df6a4345adbf9edbdbc1e46f', '小姐', '虚假线索', '@', '133', '', null, '张三', '2019-09-18 23:02:25', null, null, '', '', '', '');
INSERT INTO `tbl_contacts` VALUES ('c9d961407fa94e70821b34d866e56a93', '40f6cdea0bd34aceb77492a1656d9fb3', '', 'b438a05f01244a7ea72587ef6b27f263', 'dbbb', '', '', '', 'dsb', null, '张三', '2019-09-18 22:55:12', null, null, '', '', '', '');
INSERT INTO `tbl_contacts` VALUES ('d5d3a8ab219f4021a871f4e00271e105', '40f6cdea0bd34aceb77492a1656d9fb3', '', '227b36b8c0ea41d78a679aae1c97e8f7', '22小妹', '', 'fg', '177', '', null, '张三', '2019-09-18 23:08:21', null, null, '', '', '', '');

-- ----------------------------
-- Table structure for `tbl_contacts_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('35c540ed0fe34c55b4484432d2e88b2f', '00801f74b0974e79b40374d0aed0eba9', '33bf5f6f971543f9b3d4490ce8eb811d');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('e002c9862f0448da9148b6628360bc28', 'bde34abf9b1c4a229c9944a783d6f361', '33bf5f6f971543f9b3d4490ce8eb811d');

-- ----------------------------
-- Table structure for `tbl_contacts_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('34a1369626af4fba843d5b2dcc620b25', '干', '张三', '2019-09-18 23:02:25', null, null, '0', 'bde34abf9b1c4a229c9944a783d6f361');

-- ----------------------------
-- Table structure for `tbl_customer`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('1422d1b3f73a409da84fd5172a2301f0', '40f6cdea0bd34aceb77492a1656d9fb3', '是DVD', '', '', '张三', '2019-09-18 22:57:48', null, null, '', '', '', '');
INSERT INTO `tbl_customer` VALUES ('20584c01404f47548db01f4642e0c783', null, 'sun', null, null, '张三', '2019-09-22 00:36:40', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('2222222252151gdgs', '40f6cdea0bd34aceb77492a1656d9fb3', '2她的肉体', null, null, '张三', '2019-09-20 22:47:35', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('227b36b8c0ea41d78a679aae1c97e855', '40f6cdea0bd34aceb77492a1656d9fb3', '2深户', null, null, '张三', '2019-09-19 22:47:35', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('227b36b8c0ea41d78a679aae1c97e8f7', '40f6cdea0bd34aceb77492a1656d9fb3', '22', '', '', '张三', '2019-09-18 23:03:52', null, null, '', '', '', '');
INSERT INTO `tbl_customer` VALUES ('26383f50e578413091f2ff6b39716fc8', null, '中石化', null, null, '张三', '2019-09-22 13:35:07', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('63af272be00b4c22b8a6fd2ad049d837', null, '国务院', null, null, '张三', '2019-09-22 13:56:18', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('77a992b98c484597a38b783e0f270bba', null, '', null, null, '张三', '2019-09-22 00:26:30', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('7c005714d3bd427e8e9c07c6a0763bc6', null, 'baidu', null, null, '张三', '2019-09-22 00:23:52', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('85a32e59e8734eb39ac79aea3e81824d', null, 'fffff', null, null, '张三', '2019-09-21 23:40:27', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('8b0db1b6df6a4345adbf9edbdbc1e46f', '40f6cdea0bd34aceb77492a1656d9fb3', '妓院', '', '', '张三', '2019-09-18 23:02:25', null, null, '', '', '', '');
INSERT INTO `tbl_customer` VALUES ('94a1e7b813524931866383c9d93ab271', null, 'caoruiqun', null, null, '张三', '2019-09-22 00:32:52', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('b438a05f01244a7ea72587ef6b27f263', '40f6cdea0bd34aceb77492a1656d9fb3', 'ltl', '', '', '张三', '2019-09-18 22:47:35', null, null, '', '', '', '');
INSERT INTO `tbl_customer` VALUES ('ee2eac46c0c34257b4a321725a8a503f', null, 'ggg', null, null, '张三', '2019-09-22 00:41:14', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('f544b978a3cb48d0ba1b4aa3a8aea571', null, 'ghjjjjjjjj', null, null, '张三', '2019-09-22 00:24:52', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `tbl_customer_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('78774aa10fd743fd98e8ce350bfc6d14', '干', '张三', '2019-09-18 23:02:25', null, null, '0', '8b0db1b6df6a4345adbf9edbdbc1e46f');

-- ----------------------------
-- Table structure for `tbl_dic_type`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '����������������Ϊ�գ����ܺ������ġ�',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for `tbl_dic_value`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '����������UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '����Ϊ�գ�����Ҫ��ͬһ���ֵ��������ֵ�ֵ�����ظ�������Ψһ�ԡ�',
  `text` varchar(255) DEFAULT NULL COMMENT '����Ϊ��',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '����Ϊ�գ�����Ϊ�յ�ʱ��Ҫ�������������',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '���',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for `tbl_tran`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('0943eff235114fde864f3fb6563c4fe1', '40f6cdea0bd34aceb77492a1656d9fb3', '', '22', '', '20584c01404f47548db01f4642e0c783', '02需求分析', '', '', '366be888cba34d0bba29c6a0c954bb56', '', '张三', '2019-09-22 00:36:40', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('13eabe71230f4d04b123d93d2011924f', '40f6cdea0bd34aceb77492a1656d9fb3', '', '11', '', '94a1e7b813524931866383c9d93ab271', '02需求分析', '', '', '', '', '张三', '2019-09-22 00:32:52', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('1cf668533b5b45a69bc67fa61e6fcd9c', '40f6cdea0bd34aceb77492a1656d9fb3', '78', '四射', '', '227b36b8c0ea41d78a679aae1c97e855', '02需求分析', '', '', '', '', '张三', '2019-09-21 23:43:22', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('322b7d509b3945feb464de3971335f6e', '40f6cdea0bd34aceb77492a1656d9fb3', '', '虽九死其犹未悔', '', '94a1e7b813524931866383c9d93ab271', '02需求分析', '', '', '796434292d374582b8f3c7032f5796a1', 'bde34abf9b1c4a229c9944a783d6f361', '张三', '2019-09-22 13:31:57', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('3a57a69ad0bb4df687f6f1c620fb80ca', '40f6cdea0bd34aceb77492a1656d9fb3', '', '7777', '', '94a1e7b813524931866383c9d93ab271', '05提案/报价', '', '', '', '', '张三', '2019-09-22 13:37:46', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('4544cc370f5d4a12bd75a6c120965cd5', '40f6cdea0bd34aceb77492a1656d9fb3', '', '路慢慢吸气修养', '', '26383f50e578413091f2ff6b39716fc8', '05提案/报价', '', '', '58e30abb22204f948a1c67b0a4050069', 'c9d961407fa94e70821b34d866e56a93', '张三', '2019-09-22 13:35:07', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('59f6cdea0bd34aceb77492a1656d9fb3', '40f6cdea0bd34aceb77492a1656d9fb3', null, '0922', null, '227b36b8c0ea41d78a679aae1c97e8f7', '05提案/报价', null, null, null, 'd5d3a8ab219f4021a871f4e00271e105', '张三', '2019-09-22 12:38:17', null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('6296657d84e74f6b99b485e932455ee0', '40f6cdea0bd34aceb77492a1656d9fb3', '', '222', '', '77a992b98c484597a38b783e0f270bba', '04确定决策者', '', '', '366be888cba34d0bba29c6a0c954bb56', '1378508501c54db3bc00ad00b06713f7', '张三', '2019-09-22 00:37:10', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('a7fa585397604c8a840944b73ea52321', '40f6cdea0bd34aceb77492a1656d9fb3', '1000', 'cao', '2019-09-18', '227b36b8c0ea41d78a679aae1c97e8f7', '07成交', '已有业务', '', '366be888cba34d0bba29c6a0c954bb56', 'd5d3a8ab219f4021a871f4e00271e105', '张三', '2019-09-18 23:08:21', '张三', '2019-10-19 16:58:16', '', '', '');

-- ----------------------------
-- Table structure for `tbl_tran_history`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('382e7a5aeebc40fd8829add62b1a33b3', '07成交', '1000', '2019-09-18', '2019-10-19 16:58:16', '张三', 'a7fa585397604c8a840944b73ea52321');
INSERT INTO `tbl_tran_history` VALUES ('94e342e6c3b340df93aab4ee55d011e4', '04确定决策者', '1000', '2019-09-18', '2019-09-18 23:08:21', '张三', 'a7fa585397604c8a840944b73ea52321');
INSERT INTO `tbl_tran_history` VALUES ('aa3c78b898524eac9beda023cb80c673', '05提案/报价', '1000', '2019-09-18', '2019-10-19 16:58:00', '张三', 'a7fa585397604c8a840944b73ea52321');
INSERT INTO `tbl_tran_history` VALUES ('bf415a7a92f1409d8b58e04f75013f13', '03价值建议', '1000', '2019-09-18', '2019-10-19 16:39:07', '张三', 'a7fa585397604c8a840944b73ea52321');
INSERT INTO `tbl_tran_history` VALUES ('ef987f0432374e729e70454e67b16ea8', '09因竞争丢失关闭', '1000', '2019-09-18', '2019-10-19 16:58:09', '张三', 'a7fa585397604c8a840944b73ea52321');

-- ----------------------------
-- Table structure for `tbl_tran_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_user`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2018-11-27 21:50:05', '1', 'A001', '192.168.1.1', '2018-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2019-11-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', '张三', null, null);
