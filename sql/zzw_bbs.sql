-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: zzw_bbs
-- ------------------------------------------------------
-- Server version	5.6.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bbs_bbs`
--

DROP TABLE IF EXISTS `bbs_bbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bbs_bbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `createId` int(11) DEFAULT NULL,
  `createName` varchar(45) DEFAULT NULL,
  `createDateTime` datetime DEFAULT NULL,
  `sortNum` int(11) DEFAULT NULL,
  `replyId` int(11) DEFAULT NULL COMMENT '回复Id',
  `isPublic` tinyint(1) DEFAULT '1' COMMENT '是否发布',
  `replyNum` int(11) DEFAULT NULL COMMENT '回帖数量',
  `typeId` int(11) DEFAULT NULL COMMENT '所属主题id',
  `typeTitle` varchar(45) DEFAULT NULL COMMENT '所属主题',
  PRIMARY KEY (`id`),
  KEY `bbs_fixed` (`replyId`,`createDateTime`),
  KEY `bbs_createId` (`createId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='bbs帖子';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_bbs`
--

LOCK TABLES `bbs_bbs` WRITE;
/*!40000 ALTER TABLE `bbs_bbs` DISABLE KEYS */;
/*!40000 ALTER TABLE `bbs_bbs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_type`
--

DROP TABLE IF EXISTS `bbs_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bbs_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `imgUrl` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `masterId` varchar(45) DEFAULT NULL COMMENT '版主Id',
  `masterName` varchar(45) DEFAULT NULL,
  `lastPoster` varchar(45) DEFAULT NULL COMMENT '最后发帖人',
  `lastPostDate` datetime DEFAULT NULL COMMENT '最后发帖时间',
  `postNum` int(11) DEFAULT NULL COMMENT '帖子数量',
  `note` varchar(255) DEFAULT NULL,
  `isUse` tinyint(1) DEFAULT NULL,
  `sortNum` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='bbs主题类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_type`
--

LOCK TABLES `bbs_type` WRITE;
/*!40000 ALTER TABLE `bbs_type` DISABLE KEYS */;
INSERT INTO `bbs_type` VALUES (1,'重大风采','/fileUpload/images/bbsType/201809/20_103941_366.png','2018-09-20 00:00:00','5','黑白永恒',NULL,NULL,NULL,'重大风采',1,1),(2,'昆明风采','/fileUpload/images/bbsType/201809/20_105042_57.png','2018-09-20 00:00:00','4','天道自然',NULL,NULL,NULL,'测试123',1,2);
/*!40000 ALTER TABLE `bbs_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_user`
--

DROP TABLE IF EXISTS `bbs_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bbs_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) DEFAULT NULL,
  `loginName` varchar(45) DEFAULT NULL,
  `loginPass` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `lastLoginIP` varchar(45) DEFAULT NULL,
  `lastLoginTime` varchar(45) DEFAULT NULL,
  `postNum` int(11) DEFAULT NULL COMMENT '发帖数量',
  `backNum` int(11) DEFAULT NULL COMMENT '回帖数量',
  `isUse` tinyint(1) DEFAULT '1',
  `note` varchar(255) DEFAULT NULL,
  `registerDate` date DEFAULT NULL COMMENT '注册时间',
  `imgUrl` varchar(255) DEFAULT NULL COMMENT '头像图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='bbs用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_user`
--

LOCK TABLES `bbs_user` WRITE;
/*!40000 ALTER TABLE `bbs_user` DISABLE KEYS */;
INSERT INTO `bbs_user` VALUES (4,'天道自然','tdzr','e10adc3949ba59abbe56e057f20f883e','13608817101','',NULL,0,0,1,'11133','2018-09-18','/fileUpload/images/bbsUser/201809/18_230703_216.png'),(5,'黑白永恒','hbyh','e10adc3949ba59abbe56e057f20f883e','13608817101','',NULL,0,0,1,'11','2018-09-18','/fileUpload/images/bbsUser/201809/18_230723_688.png');
/*!40000 ALTER TABLE `bbs_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_friend`
--

DROP TABLE IF EXISTS `web_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `linkUrl` varchar(45) DEFAULT NULL,
  `sortNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='友情链接';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_friend`
--

LOCK TABLES `web_friend` WRITE;
/*!40000 ALTER TABLE `web_friend` DISABLE KEYS */;
INSERT INTO `web_friend` VALUES (1,'bing','https://www.bing.com',1),(2,'163','https://www.163.com',2),(3,'重大网络学院','http://www.5any.com/PortalSite/index.htm',3);
/*!40000 ALTER TABLE `web_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_logs`
--

DROP TABLE IF EXISTS `web_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) DEFAULT NULL,
  `loginName` varchar(45) DEFAULT NULL,
  `className` varchar(255) DEFAULT NULL,
  `methodName` varchar(45) DEFAULT NULL,
  `paramStr` text,
  `resultStr` text,
  `createTime` datetime DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='系统日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_logs`
--

LOCK TABLES `web_logs` WRITE;
/*!40000 ALTER TABLE `web_logs` DISABLE KEYS */;
INSERT INTO `web_logs` VALUES (1,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 10:56:35','后台登录'),(2,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','use','{\"ids\":\"1\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 11:03:15','管理员启用/禁用'),(3,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','use','{\"ids\":\"1\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 11:03:19','管理员启用/禁用'),(4,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','add','{\"isUse\":\"\",\"note\":\"11212\",\"loginName\":\"test\",\"mobile\":\"13100000000\",\"actionUrl\":\"new\",\"loginPass\":\"123456\",\"id\":\"0\",\"userName\":\"测试\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 11:03:43','管理员添加'),(5,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','use','{\"ids\":\"2\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 11:03:48','管理员启用/禁用'),(6,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','modify','{\"isUse\":\"true\",\"note\":\"11212\",\"mobile\":\"13100000000\",\"actionUrl\":\"modify\",\"loginPass\":\"2222\",\"id\":\"2\",\"userName\":\"测试\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 11:03:55','管理员修改'),(7,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','modify','{\"isUse\":\"true\",\"note\":\"11212\",\"loginName\":\"ddd\",\"mobile\":\"13100000000\",\"actionUrl\":\"modify\",\"loginPass\":\"333\",\"id\":\"2\",\"userName\":\"测试\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 11:06:26','管理员修改'),(8,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','use','{\"ids\":\"2\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 11:07:58','管理员启用/禁用'),(9,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','modify','{\"isUse\":\"false\",\"note\":\"11212\",\"loginName\":\"ddd\",\"mobile\":\"13100000000\",\"actionUrl\":\"modify\",\"loginPass\":\"310dcbbf4cce62f762a2aaa148d556bd\",\"id\":\"2\",\"userName\":\"测试33\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 11:08:05','管理员修改'),(10,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','add','{\"isUse\":\"\",\"note\":\"2323\",\"loginName\":\"ddd\",\"mobile\":\"232323\",\"actionUrl\":\"new\",\"loginPass\":\"333\",\"id\":\"0\",\"userName\":\"33\"}','{\"code\":0,\"msg\":\"当前登录名已经存在!\",\"data\":null,\"success\":false}','2018-09-18 11:08:14','管理员添加'),(11,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','use','{\"ids\":\"2\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 11:08:19','管理员启用/禁用'),(12,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 15:49:40','后台登录'),(13,'127.0.0.1','admin','com.nature.jet.controller.web.UserController','use','{\"ids\":\"2\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 15:49:53','管理员启用/禁用'),(14,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 16:09:07','后台登录'),(15,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 16:30:16','后台登录'),(16,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 19:43:02','后台登录'),(17,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','add','{\"actionUrl\":\"new\",\"isPublic\":\"\",\"id\":\"0\",\"title\":\"111\",\"content\":\"\",\"createName\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 19:46:07','系统通知数据添加'),(18,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','modify','{\"actionUrl\":\"modify\",\"isPublic\":\"false\",\"id\":\"1\",\"title\":\"111\",\"content\":\"<p>1212</p><p>1212<img src=\\\"http://127.0.0.1:8080/design/webAdmin/images/face/25.gif\\\" alt=\\\"[抱抱]\\\"><img src=\\\"/fileUpload/images/layuiEidt/201809/18_194815_340.png\\\" alt=\\\"file\\\"></p>\",\"createName\":\"admin\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 19:48:17','系统通知数据修改'),(19,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 19:50:34','后台登录'),(20,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','add','{\"actionUrl\":\"new\",\"isPublic\":\"\",\"id\":\"0\",\"title\":\"44\",\"content\":\"<p>3434<img src=\\\"http://127.0.0.1:8080/design/webAdmin/images/face/37.gif\\\" alt=\\\"[色]\\\"></p><p><img src=\\\"/fileUpload/images/layuiEidt/201809/18_195048_826.png\\\" alt=\\\"file\\\"><br></p>\",\"createName\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 19:51:07','系统通知数据添加'),(21,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','delete','{\"ids\":\"2,1\"}','{\"code\":1,\"msg\":\"信息删除成功\",\"data\":null,\"success\":true}','2018-09-18 19:51:21','系统通知数据删除'),(22,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','add','{\"actionUrl\":\"new\",\"isPublic\":\"\",\"id\":\"0\",\"title\":\"测试\",\"content\":\"测试123<img src=\\\"http://127.0.0.1:8080/design/webAdmin/images/face/63.gif\\\" alt=\\\"[给力]\\\"><img src=\\\"/fileUpload/images/layuiEidt/201809/18_195159_408.png\\\" alt=\\\"file\\\">\",\"createName\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 19:52:01','系统通知数据添加'),(23,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','use','{\"ids\":\"3\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 19:52:52','系统通知启用/禁用'),(24,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 19:58:07','后台登录'),(25,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','delete','{\"ids\":\"3\"}','{\"code\":1,\"msg\":\"信息删除成功,已经发布的数据无法删除\",\"data\":null,\"success\":true}','2018-09-18 19:58:13','系统通知数据删除'),(26,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','use','{\"ids\":\"3\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 19:58:19','系统通知启用/禁用'),(27,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','use','{\"ids\":\"3\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 19:58:48','系统通知启用/禁用'),(28,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 20:31:58','后台登录'),(29,'127.0.0.1','admin','com.nature.jet.controller.web.FriendController','add','{\"linkUrl\":\"https://www.bing.com\",\"actionUrl\":\"new\",\"sortNum\":\"1\",\"id\":\"0\",\"title\":\"bing\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 20:33:31','友情链接数据添加'),(30,'127.0.0.1','admin','com.nature.jet.controller.web.FriendController','add','{\"linkUrl\":\"https://www.163.com\",\"actionUrl\":\"new\",\"sortNum\":\"2\",\"id\":\"0\",\"title\":\"163\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 20:33:48','友情链接数据添加'),(31,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 20:36:50','后台登录'),(32,'127.0.0.1','admin','com.nature.jet.controller.web.FriendController','add','{\"linkUrl\":\"http://www.5any.com/PortalSite/index.htm\",\"actionUrl\":\"new\",\"sortNum\":\"3\",\"id\":\"0\",\"title\":\"重大网络学院\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 20:37:21','友情链接数据添加'),(33,'127.0.0.1','admin','com.nature.jet.controller.web.FriendController','modify','{\"linkUrl\":\"https://www.163.com\",\"actionUrl\":\"modify\",\"sortNum\":\"4\",\"id\":\"2\",\"title\":\"163\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 20:37:37','友情链接数据修改'),(34,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 20:42:15','后台登录'),(35,'127.0.0.1','admin','com.nature.jet.controller.web.FriendController','modify','{\"linkUrl\":\"https://www.163.com\",\"actionUrl\":\"modify\",\"sortNum\":\"2\",\"id\":\"2\",\"title\":\"163\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 20:42:26','友情链接数据修改'),(36,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-18 23:00:46','后台登录'),(37,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','add','{\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230112_962.png\",\"isUse\":\"\",\"note\":\"123456\",\"backNum\":\"\",\"loginName\":\"test\",\"mobile\":\"13608817101\",\"actionUrl\":\"new\",\"postNum\":\"\",\"loginPass\":\"123456\",\"id\":\"0\",\"userName\":\"天道自然\",\"lastLoginIP\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 23:01:26','BBS用户数据添加'),(38,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','modify','{\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230112_962.png\",\"isUse\":\"false\",\"note\":\"1234564444\",\"backNum\":\"0\",\"loginName\":\"test\",\"mobile\":\"13608817101\",\"actionUrl\":\"modify\",\"postNum\":\"0\",\"loginPass\":\"e10adc3949ba59abbe56e057f20f883e\",\"id\":\"1\",\"userName\":\"天道自然\",\"lastLoginIP\":\"\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 23:03:15','BBS用户数据修改'),(39,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','use','{\"ids\":\"1\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 23:03:21','BBS用户启用/禁用'),(40,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','delete','{\"ids\":\"1\"}','{\"code\":1,\"msg\":\"信息删除成功\",\"data\":null,\"success\":true}','2018-09-18 23:03:32','BBS用户数据删除'),(41,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','delete','{\"ids\":\"1\"}','{\"code\":1,\"msg\":\"信息删除成功,已经启用的数据禁止删除\",\"data\":null,\"success\":true}','2018-09-18 23:04:01','BBS用户数据删除'),(42,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','add','{\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230428_292.png\",\"isUse\":\"\",\"note\":\"22\",\"backNum\":\"\",\"loginName\":\"hbyh\",\"mobile\":\"13608817101\",\"actionUrl\":\"new\",\"postNum\":\"\",\"loginPass\":\"123456\",\"id\":\"0\",\"userName\":\"黑白永恒\",\"lastLoginIP\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 23:04:36','BBS用户数据添加'),(43,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','modify','{\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230428_292.png\",\"isUse\":\"false\",\"note\":\"22\",\"backNum\":\"0\",\"loginName\":\"hbyh\",\"mobile\":\"13608817101\",\"actionUrl\":\"modify\",\"postNum\":\"0\",\"loginPass\":\"e10adc3949ba59abbe56e057f20f883e\",\"id\":\"2\",\"userName\":\"黑白永恒\",\"lastLoginIP\":\"\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 23:05:22','BBS用户数据修改'),(44,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','use','{\"ids\":\"1\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 23:06:12','BBS用户启用/禁用'),(45,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','modify','{\"isUse\":\"false\",\"note\":\"1234564444\",\"mobile\":\"13608817101\",\"actionUrl\":\"modify\",\"postNum\":\"0\",\"userName\":\"天道自然\",\"lastLoginIP\":\"\",\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230112_962.png\",\"backNum\":\"0\",\"loginName\":\"test\",\"loginPass\":\"e10adc3949ba59abbe56e057f20f883e\",\"id\":\"1\",\"registerDate\":\"\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 23:06:15','BBS用户数据修改'),(46,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','add','{\"isUse\":\"\",\"note\":\"22\",\"mobile\":\"13608817101\",\"actionUrl\":\"new\",\"postNum\":\"\",\"userName\":\"ce\",\"lastLoginIP\":\"\",\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230627_570.png\",\"backNum\":\"\",\"loginName\":\"123\",\"loginPass\":\"123456\",\"id\":\"0\",\"registerDate\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 23:06:35','BBS用户数据添加'),(47,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','modify','{\"isUse\":\"false\",\"note\":\"22\",\"mobile\":\"13608817101\",\"actionUrl\":\"modify\",\"postNum\":\"0\",\"userName\":\"ce\",\"lastLoginIP\":\"\",\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230627_570.png\",\"backNum\":\"0\",\"loginName\":\"123\",\"loginPass\":\"e10adc3949ba59abbe56e057f20f883e\",\"id\":\"3\",\"registerDate\":\"2018-09-18\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 23:06:40','BBS用户数据修改'),(48,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','delete','{\"ids\":\"3,2,1\"}','{\"code\":1,\"msg\":\"信息删除成功,已经启用的数据禁止删除\",\"data\":null,\"success\":true}','2018-09-18 23:06:48','BBS用户数据删除'),(49,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','add','{\"isUse\":\"\",\"note\":\"111\",\"mobile\":\"13608817101\",\"actionUrl\":\"new\",\"postNum\":\"\",\"userName\":\"天道自然\",\"lastLoginIP\":\"\",\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230703_216.png\",\"backNum\":\"\",\"loginName\":\"tdzr\",\"loginPass\":\"123456\",\"id\":\"0\",\"registerDate\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 23:07:10','BBS用户数据添加'),(50,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','add','{\"isUse\":\"\",\"note\":\"11\",\"mobile\":\"13608817101\",\"actionUrl\":\"new\",\"postNum\":\"\",\"userName\":\"黑白永恒\",\"lastLoginIP\":\"\",\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230723_688.png\",\"backNum\":\"\",\"loginName\":\"tdzr\",\"loginPass\":\"123456\",\"id\":\"0\",\"registerDate\":\"\"}','{\"code\":0,\"msg\":\"当前登录名已经存在\",\"data\":null,\"success\":false}','2018-09-18 23:07:30','BBS用户数据添加'),(51,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','add','{\"isUse\":\"\",\"note\":\"11\",\"mobile\":\"13608817101\",\"actionUrl\":\"new\",\"postNum\":\"\",\"userName\":\"黑白永恒\",\"lastLoginIP\":\"\",\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230723_688.png\",\"backNum\":\"\",\"loginName\":\"hbyh\",\"loginPass\":\"123456\",\"id\":\"0\",\"registerDate\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-18 23:07:36','BBS用户数据添加'),(52,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','modify','{\"isUse\":\"false\",\"note\":\"11133\",\"mobile\":\"13608817101\",\"actionUrl\":\"modify\",\"postNum\":\"0\",\"userName\":\"天道自然\",\"lastLoginIP\":\"\",\"imgUrl\":\"/fileUpload/images/bbsUser/201809/18_230703_216.png\",\"backNum\":\"0\",\"loginName\":\"tdzr\",\"loginPass\":\"e10adc3949ba59abbe56e057f20f883e\",\"id\":\"4\",\"registerDate\":\"2018-09-18\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-18 23:07:42','BBS用户数据修改'),(53,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','use','{\"ids\":\"5,4\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-18 23:07:46','BBS用户启用/禁用'),(54,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','use','{\"ids\":\"5\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-19 09:26:53','BBS用户启用/禁用'),(55,'127.0.0.1','admin','com.nature.jet.controller.web.BbsUserController','use','{\"ids\":\"5\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-19 09:27:04','BBS用户启用/禁用'),(56,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-19 10:37:08','后台登录'),(57,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','add','{\"actionUrl\":\"new\",\"isPublic\":\"\",\"id\":\"0\",\"title\":\"测试\",\"content\":\"<img src=\\\"/fileUpload/images/layuiEidt/201809/19_103906_166.png\\\" alt=\\\"file\\\">\",\"createName\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-19 10:39:08','系统通知数据添加'),(58,'127.0.0.1','admin','com.nature.jet.controller.web.NoticeController','use','{\"ids\":\"4\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-19 10:39:12','系统通知启用/禁用'),(59,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-19 10:56:00','后台登录'),(60,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-20 10:39:17','后台登录'),(61,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','add','{\"imgUrl\":\"/fileUpload/images/bbsType/201809/20_103941_366.png\",\"isUse\":\"\",\"masterId\":\"\",\"note\":\"重大风采\",\"actionUrl\":\"new\",\"id\":\"0\",\"title\":\"重大风采\",\"masterName\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-20 10:39:51','BBS主题数据添加'),(62,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-20 10:50:22','后台登录'),(63,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','add','{\"imgUrl\":\"/fileUpload/images/bbsType/201809/20_105042_57.png\",\"isUse\":\"\",\"masterId\":\"4\",\"note\":\"测试\",\"actionUrl\":\"new\",\"id\":\"0\",\"title\":\"昆明风采\",\"masterName\":\"\"}','{\"code\":1,\"msg\":\"信息创建成功\",\"data\":null,\"success\":true}','2018-09-20 10:50:59','BBS主题数据添加'),(64,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','modify','{\"imgUrl\":\"/fileUpload/images/bbsType/201809/20_105042_57.png\",\"isUse\":\"false\",\"masterId\":\"4\",\"note\":\"测试\",\"actionUrl\":\"modify\",\"id\":\"2\",\"title\":\"昆明风采\",\"masterName\":\"天道自然\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-20 10:52:19','BBS主题数据修改'),(65,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','modify','{\"imgUrl\":\"/fileUpload/images/bbsType/201809/20_103941_366.png\",\"isUse\":\"false\",\"masterId\":\"5\",\"note\":\"重大风采\",\"actionUrl\":\"modify\",\"id\":\"1\",\"title\":\"重大风采\",\"masterName\":\"黑白永恒\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-20 10:52:32','BBS主题数据修改'),(66,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-20 10:55:39','后台登录'),(67,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','modify','{\"imgUrl\":\"/fileUpload/images/bbsType/201809/20_105042_57.png\",\"isUse\":\"false\",\"masterId\":\"4\",\"note\":\"测试123\",\"actionUrl\":\"modify\",\"id\":\"2\",\"title\":\"昆明风采\",\"masterName\":\"天道自然\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-20 10:55:49','BBS主题数据修改'),(68,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-20 11:02:58','后台登录'),(69,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','modify','{\"imgUrl\":\"/fileUpload/images/bbsType/201809/20_103941_366.png\",\"isUse\":\"false\",\"masterId\":\"5\",\"note\":\"重大风采\",\"actionUrl\":\"modify\",\"sortNum\":\"1\",\"id\":\"1\",\"title\":\"重大风采\",\"masterName\":\"黑白永恒\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-20 11:03:08','BBS主题数据修改'),(70,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','modify','{\"imgUrl\":\"/fileUpload/images/bbsType/201809/20_105042_57.png\",\"isUse\":\"false\",\"masterId\":\"4\",\"note\":\"测试123\",\"actionUrl\":\"modify\",\"sortNum\":\"2\",\"id\":\"2\",\"title\":\"昆明风采\",\"masterName\":\"天道自然\"}','{\"code\":1,\"msg\":\"信息修改成功\",\"data\":null,\"success\":true}','2018-09-20 11:03:12','BBS主题数据修改'),(71,'127.0.0.1','admin','com.nature.jet.controller.web.BbsTypeController','use','{\"ids\":\"2,1\"}','{\"code\":1,\"msg\":\"信息启用/禁用完成\",\"data\":null,\"success\":true}','2018-09-20 11:04:26','BBS主题启用/禁用'),(72,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-20 14:00:58','后台登录'),(73,'127.0.0.1','','com.nature.jet.controller.system.IndexController','webAdminLogOut','{}','\"redirect:/webAdmin\"','2018-09-20 14:01:31','后台登出'),(74,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-20 14:26:47','后台登录'),(75,'127.0.0.1','admin','com.nature.jet.controller.system.IndexController','webAdminLogin','{\"loginName\":\"admin\",\"loginPass\":\"123456\"}','{\"code\":1,\"msg\":\"登录成功\",\"data\":null,\"success\":true}','2018-09-20 14:32:47','后台登录');
/*!40000 ALTER TABLE `web_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_notice`
--

DROP TABLE IF EXISTS `web_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `createName` varchar(45) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `content` text,
  `isPublic` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='论坛通知信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_notice`
--

LOCK TABLES `web_notice` WRITE;
/*!40000 ALTER TABLE `web_notice` DISABLE KEYS */;
INSERT INTO `web_notice` VALUES (3,'测试','admin','2018-09-18 19:52:01','测试123<img src=\"http://127.0.0.1:8080/design/webAdmin/images/face/63.gif\" alt=\"[给力]\"><img src=\"/fileUpload/images/layuiEidt/201809/18_195159_408.png\" alt=\"file\">',1),(4,'测试','admin','2018-09-19 10:39:08','<img src=\"/fileUpload/images/layuiEidt/201809/19_103906_166.png\" alt=\"file\">',1);
/*!40000 ALTER TABLE `web_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_user`
--

DROP TABLE IF EXISTS `web_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) DEFAULT NULL,
  `loginName` varchar(45) DEFAULT NULL,
  `loginPass` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `isUse` tinyint(1) DEFAULT '1',
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_user`
--

LOCK TABLES `web_user` WRITE;
/*!40000 ALTER TABLE `web_user` DISABLE KEYS */;
INSERT INTO `web_user` VALUES (1,'admin','admin','e10adc3949ba59abbe56e057f20f883e','13608817101',1,'主要管理员'),(2,'测试33','ddd','310dcbbf4cce62f762a2aaa148d556bd','13100000000',0,'11212');
/*!40000 ALTER TABLE `web_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-20 14:37:04
