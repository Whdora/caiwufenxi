/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : cwfx

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2016-05-01 23:02:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tannounce
-- ----------------------------
DROP TABLE IF EXISTS `tannounce`;
CREATE TABLE `tannounce` (
  `CID` varchar(36) NOT NULL,
  `CCONTENT` longtext,
  `CCREATEDATE` datetime DEFAULT NULL,
  `CMODIFYDATE` datetime DEFAULT NULL,
  `CTITLE` varchar(200) DEFAULT NULL,
  `USERID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK849E0DD2D65CDBF` (`USERID`),
  CONSTRAINT `FK849E0DD2D65CDBF` FOREIGN KEY (`USERID`) REFERENCES `tuser` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tannounce
-- ----------------------------
INSERT INTO `tannounce` VALUES ('87f3a646-2b99-42b2-a435-f0ab6cea7a41', '2016年五一放假三天', '2016-04-30 21:48:03', '2016-04-30 21:48:03', '五一放假通知', '1');

-- ----------------------------
-- Table structure for tauth
-- ----------------------------
DROP TABLE IF EXISTS `tauth`;
CREATE TABLE `tauth` (
  `CID` varchar(36) NOT NULL,
  `CDESC` varchar(200) DEFAULT NULL,
  `CNAME` varchar(100) NOT NULL,
  `CSEQ` decimal(22,0) DEFAULT NULL,
  `CURL` varchar(5000) DEFAULT NULL,
  `CPID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK690841C5F603FBE` (`CPID`),
  CONSTRAINT `FK690841C5F603FBE` FOREIGN KEY (`CPID`) REFERENCES `tauth` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tauth
-- ----------------------------
INSERT INTO `tauth` VALUES ('9fba5577-0a5c-49fc-b033-9713ace053f3', null, '管理员', '1', '/analysisAction!subject.action,/auditAction!auditManager.action,/budgetAction!budgetManager.action,/costAction!costManager.action,/kmlzAction!kmlzAdd.action,/analysisAction!funds.action,/userAction!userManager.action,/menuAction!menuManager.action,/authAction!authManager.action,/roleAction!roleManager.action,/deptAction!deptManager.action,/announceAction!announceManager.action,/linkAction!linkManager.action,/fileAction!fileManager.action,/kindAction!kindManager.action,/kjkmAction!kjkmManager.action,/projectAction!projectManager.action,/shangpinAction!shangpinManager.action,/zrzxAction!zrzxManager.action,/downloadAction!downloadManager.action,/authAction!authEdit.action', null);

-- ----------------------------
-- Table structure for tbudget
-- ----------------------------
DROP TABLE IF EXISTS `tbudget`;
CREATE TABLE `tbudget` (
  `CID` varchar(36) NOT NULL,
  `CAUDITFILENAME` varchar(200) DEFAULT NULL,
  `CAUDITFILEPATH` varchar(200) DEFAULT NULL,
  `CCREATEDATE` datetime DEFAULT NULL,
  `CDATE` date DEFAULT NULL,
  `CFYCY` double DEFAULT NULL,
  `CMODIFYDATE` datetime DEFAULT NULL,
  `CSJ` double DEFAULT NULL,
  `CSJFY` double DEFAULT NULL,
  `CSJQSSJ` date DEFAULT NULL,
  `CSTATE` int(11) DEFAULT NULL,
  `CTOTAL` double DEFAULT NULL,
  `CYJFY` double DEFAULT NULL,
  `CYJLR` double DEFAULT NULL,
  `CYJQSSJ` date DEFAULT NULL,
  `CYJYWLS` double DEFAULT NULL,
  `CYT` double DEFAULT NULL,
  `CYTCY` double DEFAULT NULL,
  `CDEPTID` varchar(36) DEFAULT NULL,
  `CFILEID` varchar(36) DEFAULT NULL,
  `CPROJECTID` varchar(36) DEFAULT NULL,
  `CUSERID` varchar(36) DEFAULT NULL,
  `CZRZXID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FKA62D88B984A42656` (`CDEPTID`),
  KEY `FKA62D88B988452304` (`CFILEID`),
  KEY `FKA62D88B91EA8957C` (`CPROJECTID`),
  KEY `FKA62D88B9A26EB7E2` (`CUSERID`),
  KEY `FKA62D88B9AAF4C278` (`CZRZXID`),
  CONSTRAINT `FKA62D88B91EA8957C` FOREIGN KEY (`CPROJECTID`) REFERENCES `tproject` (`CID`),
  CONSTRAINT `FKA62D88B984A42656` FOREIGN KEY (`CDEPTID`) REFERENCES `tdept` (`Cid`),
  CONSTRAINT `FKA62D88B988452304` FOREIGN KEY (`CFILEID`) REFERENCES `tfile` (`CID`),
  CONSTRAINT `FKA62D88B9A26EB7E2` FOREIGN KEY (`CUSERID`) REFERENCES `tuser` (`CID`),
  CONSTRAINT `FKA62D88B9AAF4C278` FOREIGN KEY (`CZRZXID`) REFERENCES `tzrzx` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbudget
-- ----------------------------
INSERT INTO `tbudget` VALUES ('70ac5bbb-deb3-44b7-bdcc-39c8b19e0494', '', '', '2016-05-01 22:08:01', null, '988', '2016-05-01 22:25:16', '123', '1111', '2016-05-01', '3', '1234', '123', '12345', '2016-04-26', '123456', null, null, 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3', '92497c94-0e9d-4f7f-acd2-7e8b4e21e110', '27c2ae69-3df3-4c50-a7f4-3a98371ece4f', '1', '6efd229a-349e-4bab-add2-3b56cee42538');
INSERT INTO `tbudget` VALUES ('9c75ff48-c6be-4b63-8d90-906729be41e3', null, null, '2016-04-30 22:53:08', null, null, '2016-05-01 00:12:23', null, null, null, '3', null, '1', '1', '2016-04-13', '1', null, null, 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3', '56ba71da-49dd-40c8-b1bf-f2e181f4a7b7', '27c2ae69-3df3-4c50-a7f4-3a98371ece4f', '1', '3720c808-56db-4649-9e0b-4f05de158095');

-- ----------------------------
-- Table structure for tcost
-- ----------------------------
DROP TABLE IF EXISTS `tcost`;
CREATE TABLE `tcost` (
  `CID` varchar(36) NOT NULL,
  `CAMOUNT` double DEFAULT NULL,
  `CBH` varchar(20) DEFAULT NULL,
  `CCREATEDATE` datetime DEFAULT NULL,
  `CDATE` date DEFAULT NULL,
  `CFX` varchar(10) DEFAULT NULL,
  `CISZD` int(11) DEFAULT NULL,
  `CLZFS` varchar(20) DEFAULT NULL,
  `CMODIFYDATE` datetime DEFAULT NULL,
  `CPROGRESS` int(11) DEFAULT NULL,
  `CPZH` varchar(30) DEFAULT NULL,
  `CRZSX` varchar(4) DEFAULT NULL,
  `CSHIYOU` longtext,
  `CSJ` double DEFAULT NULL,
  `CXZ` varchar(8) DEFAULT NULL,
  `CGSYS` varchar(36) DEFAULT NULL,
  `CDEPTMENT` varchar(36) DEFAULT NULL,
  `CGUILEI` varchar(36) DEFAULT NULL,
  `CPROJECT` varchar(36) DEFAULT NULL,
  `CSHANGPIN` varchar(36) DEFAULT NULL,
  `CKJKM` varchar(36) DEFAULT NULL,
  `CUSERID` varchar(36) DEFAULT NULL,
  `CZRZX` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK691564160554B7C` (`CGSYS`),
  KEY `FK6915641EE290499` (`CDEPTMENT`),
  KEY `FK69156418AA4187A` (`CGUILEI`),
  KEY `FK6915641F53C85E1` (`CPROJECT`),
  KEY `FK6915641D049DE51` (`CSHANGPIN`),
  KEY `FK691564184574082` (`CKJKM`),
  KEY `FK6915641A26EB7E2` (`CUSERID`),
  KEY `FK691564164E9279D` (`CZRZX`),
  CONSTRAINT `FK691564160554B7C` FOREIGN KEY (`CGSYS`) REFERENCES `tbudget` (`CID`),
  CONSTRAINT `FK691564164E9279D` FOREIGN KEY (`CZRZX`) REFERENCES `tzrzx` (`CID`),
  CONSTRAINT `FK691564184574082` FOREIGN KEY (`CKJKM`) REFERENCES `tsubject` (`CID`),
  CONSTRAINT `FK69156418AA4187A` FOREIGN KEY (`CGUILEI`) REFERENCES `tkind` (`CID`),
  CONSTRAINT `FK6915641A26EB7E2` FOREIGN KEY (`CUSERID`) REFERENCES `tuser` (`CID`),
  CONSTRAINT `FK6915641D049DE51` FOREIGN KEY (`CSHANGPIN`) REFERENCES `tshangpin` (`CID`),
  CONSTRAINT `FK6915641EE290499` FOREIGN KEY (`CDEPTMENT`) REFERENCES `tdept` (`Cid`),
  CONSTRAINT `FK6915641F53C85E1` FOREIGN KEY (`CPROJECT`) REFERENCES `tproject` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tcost
-- ----------------------------
INSERT INTO `tcost` VALUES ('60b604b3-d8ec-4845-8801-a8ad4a4d3bbe', '123456', '123412', '2016-05-01 22:30:09', '2016-05-01', '借', '1', '银行', '2016-05-01 22:30:09', '1', null, '正常', 'danfan', '0', '正常', null, 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3', null, null, 'a3309e8d-0b53-4828-889d-ab5ce558a01b', '111', '1', '94a74c4c-d400-46e7-ae00-fd4189528d81');
INSERT INTO `tcost` VALUES ('749895bb-f270-48de-8578-1bc449d302ce', '123452134', '12342134', '2016-05-01 00:17:06', '2016-05-01', '借', '2', '现金', '2016-05-01 00:17:06', '2', '123243', '正常', '餐饮费', '1234', '正常', null, 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3', '68e2caab-76ce-4263-8c19-85454d398799', '27c2ae69-3df3-4c50-a7f4-3a98371ece4f', '4882d575-4445-4422-b74d-c2bf2f5ba67c', '123', '1', '3720c808-56db-4649-9e0b-4f05de158095');
INSERT INTO `tcost` VALUES ('c8ff6774-ac94-4910-9fec-92b23d864d64', '123', '1', '2016-05-01 22:06:54', '2016-04-30', '贷', '2', '现金', '2016-05-01 22:06:54', '2', '1234', '正常', '123', '1', '正常', null, 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3', '68e2caab-76ce-4263-8c19-85454d398799', '27c2ae69-3df3-4c50-a7f4-3a98371ece4f', '4882d575-4445-4422-b74d-c2bf2f5ba67c', '111', '1', '3720c808-56db-4649-9e0b-4f05de158095');

-- ----------------------------
-- Table structure for tdept
-- ----------------------------
DROP TABLE IF EXISTS `tdept`;
CREATE TABLE `tdept` (
  `Cid` varchar(36) NOT NULL,
  `CcreateDatetime` datetime DEFAULT NULL,
  `CdeptName` varchar(40) NOT NULL,
  `CmodifyDatetime` datetime DEFAULT NULL,
  `Cseq` int(11) DEFAULT NULL,
  `Pid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`Cid`),
  KEY `FK691A4B95F345F9E` (`Pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tdept
-- ----------------------------
INSERT INTO `tdept` VALUES ('fcc63cd4-e153-4a3f-b86b-a6a7df8029c3', '2016-04-30 22:44:15', '痛快科技', '2016-04-30 23:39:38', '1', null);

-- ----------------------------
-- Table structure for tdownload
-- ----------------------------
DROP TABLE IF EXISTS `tdownload`;
CREATE TABLE `tdownload` (
  `CID` varchar(36) NOT NULL,
  `CCOUNT` int(11) DEFAULT NULL,
  `CFILENAME` varchar(200) DEFAULT NULL,
  `CFILEPATH` varchar(250) DEFAULT NULL,
  `CUPLOADDATE` datetime DEFAULT NULL,
  `CUSERID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK841D14FCA26EB7E2` (`CUSERID`),
  CONSTRAINT `FK841D14FCA26EB7E2` FOREIGN KEY (`CUSERID`) REFERENCES `tuser` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tdownload
-- ----------------------------
INSERT INTO `tdownload` VALUES ('362413c1-2437-4e3e-8a4d-baab3466d831', '0', 'Pictures.zip', '/attached/upload/file/20160430/20160430225558_403.zip', '2016-04-30 22:56:04', '1');

-- ----------------------------
-- Table structure for tfile
-- ----------------------------
DROP TABLE IF EXISTS `tfile`;
CREATE TABLE `tfile` (
  `CID` varchar(36) NOT NULL,
  `CCREATEDATE` datetime DEFAULT NULL,
  `CDATE` date DEFAULT NULL,
  `CENDDATE` date DEFAULT NULL,
  `CFILENUMBER` varchar(30) DEFAULT NULL,
  `CFILEPATH` varchar(240) DEFAULT NULL,
  `CMODIFYDATE` datetime DEFAULT NULL,
  `CNAME` varchar(60) DEFAULT NULL,
  `CPASS` int(11) DEFAULT NULL,
  `CSTARTDATE` date DEFAULT NULL,
  `CDEPTID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK6929BF084A42656` (`CDEPTID`),
  CONSTRAINT `FK6929BF084A42656` FOREIGN KEY (`CDEPTID`) REFERENCES `tdept` (`Cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tfile
-- ----------------------------
INSERT INTO `tfile` VALUES ('56ba71da-49dd-40c8-b1bf-f2e181f4a7b7', '2016-04-30 22:57:05', '2016-04-30', '2016-04-30', '20160501001', '/attached/upload/file/20160430/20160430225703_6857.zip', '2016-05-01 16:59:08', '发票抬头', '0', '2016-04-30', 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3');
INSERT INTO `tfile` VALUES ('92497c94-0e9d-4f7f-acd2-7e8b4e21e110', '2016-05-01 16:58:08', '2016-04-01', '2016-05-14', '20160501002', '/attached/upload/file/20160501/20160501165806_8280.zip', '2016-05-01 16:58:54', '报销办法', '0', '2016-04-02', 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3');

-- ----------------------------
-- Table structure for tkind
-- ----------------------------
DROP TABLE IF EXISTS `tkind`;
CREATE TABLE `tkind` (
  `CID` varchar(36) NOT NULL,
  `CNAME` varchar(30) DEFAULT NULL,
  `CSEQ` int(11) DEFAULT NULL,
  `PID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK694E2085F379CED` (`PID`),
  CONSTRAINT `FK694E2085F379CED` FOREIGN KEY (`PID`) REFERENCES `tkind` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tkind
-- ----------------------------
INSERT INTO `tkind` VALUES ('68e2caab-76ce-4263-8c19-85454d398799', '报销类', '1', null);
INSERT INTO `tkind` VALUES ('c284e368-200c-493b-9e66-714d23e7c589', '发票类', '2', null);

-- ----------------------------
-- Table structure for tkmlz
-- ----------------------------
DROP TABLE IF EXISTS `tkmlz`;
CREATE TABLE `tkmlz` (
  `CID` varchar(36) NOT NULL,
  `CAMOUNT` double DEFAULT NULL,
  `CDATE` date DEFAULT NULL,
  `CPZH` varchar(20) DEFAULT NULL,
  `CCOST` varchar(36) DEFAULT NULL,
  `CKJKM` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK694F0E464D4264B` (`CCOST`),
  KEY `FK694F0E484574082` (`CKJKM`),
  CONSTRAINT `FK694F0E464D4264B` FOREIGN KEY (`CCOST`) REFERENCES `tcost` (`CID`),
  CONSTRAINT `FK694F0E484574082` FOREIGN KEY (`CKJKM`) REFERENCES `tsubject` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tkmlz
-- ----------------------------

-- ----------------------------
-- Table structure for tlink
-- ----------------------------
DROP TABLE IF EXISTS `tlink`;
CREATE TABLE `tlink` (
  `CID` varchar(36) NOT NULL,
  `CCREATEDATE` datetime DEFAULT NULL,
  `CMODIFYDATE` datetime DEFAULT NULL,
  `CTITLE` varchar(150) DEFAULT NULL,
  `CURL` varchar(200) DEFAULT NULL,
  `CUSERID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK695566EA26EB7E2` (`CUSERID`),
  CONSTRAINT `FK695566EA26EB7E2` FOREIGN KEY (`CUSERID`) REFERENCES `tuser` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tlink
-- ----------------------------
INSERT INTO `tlink` VALUES ('5d0f55d4-a12f-4740-a15c-915bfc39e301', '2016-04-30 18:52:13', '2016-04-30 18:52:22', '百度', 'www.baidu.com', '1');

-- ----------------------------
-- Table structure for tmenu
-- ----------------------------
DROP TABLE IF EXISTS `tmenu`;
CREATE TABLE `tmenu` (
  `CID` varchar(36) NOT NULL,
  `CICONCLS` varchar(100) DEFAULT NULL,
  `CNAME` varchar(100) NOT NULL,
  `CSEQ` decimal(22,0) DEFAULT NULL,
  `CURL` varchar(200) DEFAULT NULL,
  `CPID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK695BBD35F657775` (`CPID`),
  CONSTRAINT `FK695BBD35F657775` FOREIGN KEY (`CPID`) REFERENCES `tmenu` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tmenu
-- ----------------------------
INSERT INTO `tmenu` VALUES ('00856f62-d0e5-4b13-b271-40fe5393ba8f', 'icon-sum', '统计分析', '33', '', null);
INSERT INTO `tmenu` VALUES ('01b31419-01e8-4866-be58-4ce8f91655ca', '', '资金管理', '21', 'analysisAction!funds.action', '00856f62-d0e5-4b13-b271-40fe5393ba8f');
INSERT INTO `tmenu` VALUES ('0d37b32f-fc32-4ca5-a7dd-72f6478a4a33', 'icon-sum', '文件管理', '23', '', null);
INSERT INTO `tmenu` VALUES ('0e4df649-efab-4308-9712-9ecd9b00bed0', '', '预算管理', '10', 'budgetAction!budgetManager.action', '10a5efe6-f836-429c-a9e3-d2931b8eb122');
INSERT INTO `tmenu` VALUES ('10a5efe6-f836-429c-a9e3-d2931b8eb122', 'icon-sum', '财务管理', '25', '', null);
INSERT INTO `tmenu` VALUES ('120d920f-d495-4d13-a9a7-555c5a22b733', 'icon-sum', '系统管理', '22', '', null);
INSERT INTO `tmenu` VALUES ('19a18df9-efdd-46af-9d98-7c781d5fe09e', '', '商品管理', '19', 'shangpinAction!shangpinManager.action', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f');
INSERT INTO `tmenu` VALUES ('1aad3bc5-d6c1-4bf1-aaeb-89b2fdc7edde', '', '用户管理', '2', 'userAction!userManager.action', '120d920f-d495-4d13-a9a7-555c5a22b733');
INSERT INTO `tmenu` VALUES ('1c23b8a7-0e8c-4045-a032-491461e864df', '', '单位管理', '6', 'deptAction!deptManager.action', '120d920f-d495-4d13-a9a7-555c5a22b733');
INSERT INTO `tmenu` VALUES ('23f1974a-c9b3-4e69-99a1-cb6dbb79bb90', '', '会计科目', '15', 'kjkmAction!kjkmManager.action', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f');
INSERT INTO `tmenu` VALUES ('2d4286cb-f721-4239-97bc-16a4388fa2d3', '', '正常成本费用', '28', 'analysisAction!normal.action', '00856f62-d0e5-4b13-b271-40fe5393ba8f');
INSERT INTO `tmenu` VALUES ('3b8f425f-b539-452a-908d-8a6607454572', '', '角色管理', '5', 'roleAction!roleManager.action', '120d920f-d495-4d13-a9a7-555c5a22b733');
INSERT INTO `tmenu` VALUES ('49033718-f881-4ca0-9c3a-02a35da53232', '', '通告管理', '8', 'announceAction!announceManager.action', '120d920f-d495-4d13-a9a7-555c5a22b733');
INSERT INTO `tmenu` VALUES ('5e4c748b-1153-440e-946b-8c76e6d647ac', '', '专业管理', '20', 'zrzxAction!zrzxManager.action', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f');
INSERT INTO `tmenu` VALUES ('640598e7-bd96-4f8e-a932-826fe0fed3a4', '', '审计管理', '9', 'auditAction!auditManager.action', '10a5efe6-f836-429c-a9e3-d2931b8eb122');
INSERT INTO `tmenu` VALUES ('70cd042b-7ad3-4349-b781-04faf10f55e7', '', '链接管理', '17', 'linkAction!linkManager.action', '120d920f-d495-4d13-a9a7-555c5a22b733');
INSERT INTO `tmenu` VALUES ('77b77258-8fdd-451d-b3a4-433352fcffa1', '', '重点业务成本', '27', 'analysisAction!project.action', '00856f62-d0e5-4b13-b271-40fe5393ba8f');
INSERT INTO `tmenu` VALUES ('8e299a21-b781-4039-b1b1-7f340b54e27f', '', '文件号管理', '13', 'fileAction!fileManager.action', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f');
INSERT INTO `tmenu` VALUES ('91eeea68-8670-4060-9730-52f85e0f8924', '', '资金使用情况', '29', 'analysisAction!funds.action', '00856f62-d0e5-4b13-b271-40fe5393ba8f');
INSERT INTO `tmenu` VALUES ('94cb5b23-fdbd-4cad-aa61-a13fe56109f6', '', '菜单管理', '3', 'menuAction!menuManager.action', '120d920f-d495-4d13-a9a7-555c5a22b733');
INSERT INTO `tmenu` VALUES ('9dc579a2-c2be-4729-90b9-77e9df2845aa', '', '科目余额', '7', 'analysisAction!subject.action', '00856f62-d0e5-4b13-b271-40fe5393ba8f');
INSERT INTO `tmenu` VALUES ('9ecc0dbb-806c-4b51-bc3a-f720b8c244a1', '', '归类管理', '14', 'kindAction!kindManager.action', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f');
INSERT INTO `tmenu` VALUES ('a4a1afe2-7350-4f7d-91e4-a064cf0ea6f8', '', '下载管理', '12', 'downloadAction!downloadManager.action', '0d37b32f-fc32-4ca5-a7dd-72f6478a4a33');
INSERT INTO `tmenu` VALUES ('a6d4ed2d-6957-410a-8257-b0ee5a83f0a1', '', '消费管理', '11', 'costAction!costManager.action', '10a5efe6-f836-429c-a9e3-d2931b8eb122');
INSERT INTO `tmenu` VALUES ('b0fe2ef3-b507-422b-98ab-0acab16f6e9f', '', '项目管理', '18', 'projectAction!projectManager.action', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f');
INSERT INTO `tmenu` VALUES ('b1f9509a-41cd-44bd-afc7-20230b84c6d4', '', '正常成本费用', '32', 'costAction!normalCostManager.action', '10a5efe6-f836-429c-a9e3-d2931b8eb122');
INSERT INTO `tmenu` VALUES ('b7c960f4-5359-4daf-af4e-106c30c24123', '', '业务费预算审核', '31', 'budgetAction!budgetAudit.action', '10a5efe6-f836-429c-a9e3-d2931b8eb122');
INSERT INTO `tmenu` VALUES ('c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f', 'icon-sum', '元数据管理', '24', '', null);
INSERT INTO `tmenu` VALUES ('e00901bb-55b5-4ba6-87f1-64e111d211d7', '', '成本费用', '16', 'kmlzAction!kmlzAdd.action', '00856f62-d0e5-4b13-b271-40fe5393ba8f');
INSERT INTO `tmenu` VALUES ('f010247d-8bca-4222-811f-3cf50158db38', '', '权限管理', '4', 'authAction!authManager.action', '120d920f-d495-4d13-a9a7-555c5a22b733');

-- ----------------------------
-- Table structure for tproject
-- ----------------------------
DROP TABLE IF EXISTS `tproject`;
CREATE TABLE `tproject` (
  `CID` varchar(36) NOT NULL,
  `CNAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tproject
-- ----------------------------
INSERT INTO `tproject` VALUES ('27c2ae69-3df3-4c50-a7f4-3a98371ece4f', '数据城市');
INSERT INTO `tproject` VALUES ('cfe820c7-8087-478c-8f03-199085e80311', '地中海项目');

-- ----------------------------
-- Table structure for trole
-- ----------------------------
DROP TABLE IF EXISTS `trole`;
CREATE TABLE `trole` (
  `CID` varchar(36) NOT NULL,
  `CDESC` varchar(200) DEFAULT NULL,
  `CNAME` varchar(100) NOT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trole
-- ----------------------------
INSERT INTO `trole` VALUES ('5d6292c6-1fff-4dc3-b983-a10daf943594', '拥有超级权限', '超级管理员');
INSERT INTO `trole` VALUES ('98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a', '', '普通管理员');

-- ----------------------------
-- Table structure for trole_tauth
-- ----------------------------
DROP TABLE IF EXISTS `trole_tauth`;
CREATE TABLE `trole_tauth` (
  `CID` varchar(36) NOT NULL,
  `CAUTHID` varchar(36) DEFAULT NULL,
  `CROLEID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FKE482B6878067985C` (`CAUTHID`),
  KEY `FKE482B6879D196278` (`CROLEID`),
  CONSTRAINT `FKE482B6878067985C` FOREIGN KEY (`CAUTHID`) REFERENCES `tauth` (`CID`),
  CONSTRAINT `FKE482B6879D196278` FOREIGN KEY (`CROLEID`) REFERENCES `trole` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trole_tauth
-- ----------------------------
INSERT INTO `trole_tauth` VALUES ('38a68c25-20e8-4e80-8a63-8acf14006b6f', '9fba5577-0a5c-49fc-b033-9713ace053f3', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tauth` VALUES ('dd4401ab-20ff-448f-895e-a929c628fa0c', '9fba5577-0a5c-49fc-b033-9713ace053f3', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');

-- ----------------------------
-- Table structure for trole_tmenu
-- ----------------------------
DROP TABLE IF EXISTS `trole_tmenu`;
CREATE TABLE `trole_tmenu` (
  `CID` varchar(36) NOT NULL,
  `CMENUID` varchar(36) DEFAULT NULL,
  `CROLEID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FKE487EE3E9402F60A` (`CMENUID`),
  KEY `FKE487EE3E9D196278` (`CROLEID`),
  CONSTRAINT `FKE487EE3E9402F60A` FOREIGN KEY (`CMENUID`) REFERENCES `tmenu` (`CID`),
  CONSTRAINT `FKE487EE3E9D196278` FOREIGN KEY (`CROLEID`) REFERENCES `trole` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trole_tmenu
-- ----------------------------
INSERT INTO `trole_tmenu` VALUES ('05878262-4969-48f5-add0-5df8150e26af', 'b7c960f4-5359-4daf-af4e-106c30c24123', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('1a829a38-3881-4091-a2a6-7ad15e6763fd', '1aad3bc5-d6c1-4bf1-aaeb-89b2fdc7edde', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('20c99bf7-0eee-4555-9d40-61f7225656a4', '120d920f-d495-4d13-a9a7-555c5a22b733', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('25b46051-5802-49cf-95a8-c3728ccc68fa', '94cb5b23-fdbd-4cad-aa61-a13fe56109f6', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('2ea1979b-cb35-493b-a9b3-3399e24d296e', '8e299a21-b781-4039-b1b1-7f340b54e27f', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('354d6e5e-3954-4fb3-ab74-76548db4ff39', '5e4c748b-1153-440e-946b-8c76e6d647ac', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('42f28de8-3c58-4f8d-9452-b44f67d1210c', '0d37b32f-fc32-4ca5-a7dd-72f6478a4a33', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('4e091d14-40dd-4eab-9941-10eb8f37fe08', '70cd042b-7ad3-4349-b781-04faf10f55e7', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('5586cd31-bb43-4836-9bb0-31fec49ce1d1', '01b31419-01e8-4866-be58-4ce8f91655ca', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('56d1cc90-c714-42cc-a3fe-3813af81f669', 'b0fe2ef3-b507-422b-98ab-0acab16f6e9f', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('59e72ebd-6c36-490e-b5ef-9cdd3db056de', '9dc579a2-c2be-4729-90b9-77e9df2845aa', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('5a319017-383c-45e1-820f-1335c91bddb2', 'b1f9509a-41cd-44bd-afc7-20230b84c6d4', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('5d49312a-b2ff-415e-b676-749060fe359d', '640598e7-bd96-4f8e-a932-826fe0fed3a4', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('5fe32932-539a-4135-a3bc-dc952939d23f', '1c23b8a7-0e8c-4045-a032-491461e864df', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('691ec1bd-f1f4-4ee1-a543-6781a71b5feb', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('6f6704c1-13df-45ea-99d6-288a6e0862df', 'a4a1afe2-7350-4f7d-91e4-a064cf0ea6f8', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('79fc7512-5b51-404a-9aab-08e871a5187e', 'a6d4ed2d-6957-410a-8257-b0ee5a83f0a1', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('94ef155c-bdca-412f-a1f6-3196273425a2', '9ecc0dbb-806c-4b51-bc3a-f720b8c244a1', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('96f2f9cf-6f24-4c6e-a8cd-32c1aae08bdd', 'a4a1afe2-7350-4f7d-91e4-a064cf0ea6f8', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('978e74d9-a2da-4cca-8112-0eba5795298d', 'f010247d-8bca-4222-811f-3cf50158db38', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('98363ae9-102b-4a20-a136-d7ffec61f48e', '2d4286cb-f721-4239-97bc-16a4388fa2d3', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('a171685a-9f0d-4d78-9060-6ab8c1e04e12', '19a18df9-efdd-46af-9d98-7c781d5fe09e', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('a86eb256-5a19-4ad9-a917-f86799ea1322', '0e4df649-efab-4308-9712-9ecd9b00bed0', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('a951e7b0-592d-4f5d-8ac4-3f996dc60454', '5e4c748b-1153-440e-946b-8c76e6d647ac', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('a9a54bcc-b327-4158-9897-a5aa278fdb9f', '01b31419-01e8-4866-be58-4ce8f91655ca', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('b5702b8a-5d4e-4af5-8d3f-276c261a985f', '3b8f425f-b539-452a-908d-8a6607454572', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('b7b1f624-f1d2-4ee3-a380-14950789658b', '91eeea68-8670-4060-9730-52f85e0f8924', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('b966fdc6-bc83-4e77-84f1-703a19b0c99c', 'b0fe2ef3-b507-422b-98ab-0acab16f6e9f', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('bc336ea8-4203-42e3-baf0-218144085adf', '640598e7-bd96-4f8e-a932-826fe0fed3a4', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('bccaa691-c8e4-4ae6-8671-95bfd0bb7f48', 'e00901bb-55b5-4ba6-87f1-64e111d211d7', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('be9f1b45-fe23-43b9-bcf6-d0c1378d0bec', '49033718-f881-4ca0-9c3a-02a35da53232', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('c197e95a-7a5d-440e-9dd7-14adab90746d', '0d37b32f-fc32-4ca5-a7dd-72f6478a4a33', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('c8b8e3c6-b9b3-450f-9be8-520a3a0d4cd3', 'e00901bb-55b5-4ba6-87f1-64e111d211d7', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('cce60976-8cd3-4969-b6e6-62b3599e98d4', '9ecc0dbb-806c-4b51-bc3a-f720b8c244a1', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('cd75b956-e911-41a5-9164-790dd03cd2a2', 'c7bda01e-fae1-4f18-9b7a-1ebabaa88c6f', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('cf26c500-e9ea-4d69-a8bd-4ef0aa65d550', '10a5efe6-f836-429c-a9e3-d2931b8eb122', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('d848e649-eec3-4178-9491-0cac32bc118c', 'a6d4ed2d-6957-410a-8257-b0ee5a83f0a1', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('dc8a0478-6074-45f1-a54b-5c3597816493', '19a18df9-efdd-46af-9d98-7c781d5fe09e', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('e1177c32-8acc-478b-b7f7-8015a201f8af', '0e4df649-efab-4308-9712-9ecd9b00bed0', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('e25c0ca7-8272-41c5-9f79-edece11b7f41', '23f1974a-c9b3-4e69-99a1-cb6dbb79bb90', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('e545e559-d2f0-4ca6-8f4f-60bbac405a86', '77b77258-8fdd-451d-b3a4-433352fcffa1', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('e6d0362f-4e83-4ee1-b240-6c6d0a3fa200', '10a5efe6-f836-429c-a9e3-d2931b8eb122', '5d6292c6-1fff-4dc3-b983-a10daf943594');
INSERT INTO `trole_tmenu` VALUES ('eedfc897-6449-41a4-8365-96c3ff975212', '8e299a21-b781-4039-b1b1-7f340b54e27f', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('f4b38e43-dce4-4c8b-96a3-4a20472ff750', '9dc579a2-c2be-4729-90b9-77e9df2845aa', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('f4e10f51-0ebe-4095-9c43-6049d1429e86', '23f1974a-c9b3-4e69-99a1-cb6dbb79bb90', '98d0b3b8-08aa-4f3f-b577-44cdee6b0f8a');
INSERT INTO `trole_tmenu` VALUES ('f5c289ac-30e1-4852-9f96-7cf799655d6d', '00856f62-d0e5-4b13-b271-40fe5393ba8f', '5d6292c6-1fff-4dc3-b983-a10daf943594');

-- ----------------------------
-- Table structure for tshangpin
-- ----------------------------
DROP TABLE IF EXISTS `tshangpin`;
CREATE TABLE `tshangpin` (
  `CID` varchar(36) NOT NULL,
  `CNAME` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tshangpin
-- ----------------------------
INSERT INTO `tshangpin` VALUES ('4882d575-4445-4422-b74d-c2bf2f5ba67c', '电脑');
INSERT INTO `tshangpin` VALUES ('a3309e8d-0b53-4828-889d-ab5ce558a01b', '单反相机');

-- ----------------------------
-- Table structure for tsubject
-- ----------------------------
DROP TABLE IF EXISTS `tsubject`;
CREATE TABLE `tsubject` (
  `CID` varchar(36) NOT NULL,
  `CNAME` varchar(50) DEFAULT NULL,
  `CSEQ` int(11) DEFAULT NULL,
  `CPID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FKA2B2AA387EE09CE6` (`CPID`),
  CONSTRAINT `FKA2B2AA387EE09CE6` FOREIGN KEY (`CPID`) REFERENCES `tsubject` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tsubject
-- ----------------------------
INSERT INTO `tsubject` VALUES ('111', '产品部', '2', null);
INSERT INTO `tsubject` VALUES ('123', '项目部', '1', null);

-- ----------------------------
-- Table structure for tuser
-- ----------------------------
DROP TABLE IF EXISTS `tuser`;
CREATE TABLE `tuser` (
  `CID` varchar(36) NOT NULL,
  `CCREATEDATETIME` datetime DEFAULT NULL,
  `CLASTLOGIN` datetime DEFAULT NULL,
  `CMODIFYDATETIME` datetime DEFAULT NULL,
  `CPASSWORD` varchar(40) NOT NULL,
  `CROLE` int(11) DEFAULT NULL,
  `CUSERNAME` varchar(36) NOT NULL,
  `CDEPARTMENT` varchar(36) NOT NULL,
  PRIMARY KEY (`CID`),
  KEY `FK699923F26321208` (`CDEPARTMENT`),
  CONSTRAINT `FK699923F26321208` FOREIGN KEY (`CDEPARTMENT`) REFERENCES `tdept` (`Cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tuser
-- ----------------------------
INSERT INTO `tuser` VALUES ('1', '2016-04-30 18:45:04', '2016-04-30 18:45:07', '2016-04-30 23:21:21', 'e10adc3949ba59abbe56e057f20f883e', null, 'admin', 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3');
INSERT INTO `tuser` VALUES ('a7e5a579-5208-47b9-a097-452c7e292996', '2016-04-30 23:25:23', null, '2016-04-30 23:38:26', 'e10adc3949ba59abbe56e057f20f883e', null, 'test', 'fcc63cd4-e153-4a3f-b86b-a6a7df8029c3');

-- ----------------------------
-- Table structure for tuser_trole
-- ----------------------------
DROP TABLE IF EXISTS `tuser_trole`;
CREATE TABLE `tuser_trole` (
  `CID` varchar(36) NOT NULL,
  `CROLEID` varchar(36) DEFAULT NULL,
  `CUSERID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`),
  KEY `FKEB0130EA9D196278` (`CROLEID`),
  KEY `FKEB0130EAA26EB7E2` (`CUSERID`),
  CONSTRAINT `FKEB0130EA9D196278` FOREIGN KEY (`CROLEID`) REFERENCES `trole` (`CID`),
  CONSTRAINT `FKEB0130EAA26EB7E2` FOREIGN KEY (`CUSERID`) REFERENCES `tuser` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tuser_trole
-- ----------------------------
INSERT INTO `tuser_trole` VALUES ('574a7175-dc77-4e23-911d-7536841ecf54', '5d6292c6-1fff-4dc3-b983-a10daf943594', 'a7e5a579-5208-47b9-a097-452c7e292996');
INSERT INTO `tuser_trole` VALUES ('c48e63a1-1d4d-4246-8f3a-8dc8bd173a74', '5d6292c6-1fff-4dc3-b983-a10daf943594', '1');

-- ----------------------------
-- Table structure for tzdywys
-- ----------------------------
DROP TABLE IF EXISTS `tzdywys`;
CREATE TABLE `tzdywys` (
  `CID` varchar(36) NOT NULL,
  `CCONTENT` longtext,
  `CCOST` double DEFAULT NULL,
  `CCREATEDATETIME` datetime DEFAULT NULL,
  `CCREATEUSER` varchar(36) DEFAULT NULL,
  `CCYCLE` varchar(16) DEFAULT NULL,
  `CFILENAME` varchar(100) DEFAULT NULL,
  `CFILENUMBER` varchar(30) DEFAULT NULL,
  `CMAKEDATE` date DEFAULT NULL,
  `CMODIFYDATETIME` datetime DEFAULT NULL,
  `CPLANDATE` date DEFAULT NULL,
  `CPROFIT` double DEFAULT NULL,
  `CPROJECT` varchar(36) DEFAULT NULL,
  `CYWLS` double DEFAULT NULL,
  `CZHUANYE` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tzdywys
-- ----------------------------

-- ----------------------------
-- Table structure for tzrzx
-- ----------------------------
DROP TABLE IF EXISTS `tzrzx`;
CREATE TABLE `tzrzx` (
  `CID` varchar(36) NOT NULL,
  `CNAME` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tzrzx
-- ----------------------------
INSERT INTO `tzrzx` VALUES ('3720c808-56db-4649-9e0b-4f05de158095', 'IT类');
INSERT INTO `tzrzx` VALUES ('6efd229a-349e-4bab-add2-3b56cee42538', '一线生产');
INSERT INTO `tzrzx` VALUES ('94a74c4c-d400-46e7-ae00-fd4189528d81', '工业类');
