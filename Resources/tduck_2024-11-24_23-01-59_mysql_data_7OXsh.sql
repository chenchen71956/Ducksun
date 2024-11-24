-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: tduck
-- ------------------------------------------------------
-- Server version	8.4.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ac_user`
--

DROP TABLE IF EXISTS `ac_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ac_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别0未知 1男2女',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `phone_number` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `reg_channel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '注册渠道',
  `last_login_channel` tinyint DEFAULT NULL COMMENT '最后登录渠道',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '最后登录Ip',
  `password_type` tinyint(1) DEFAULT '0' COMMENT '密码类型',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15674 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ac_user`
--

LOCK TABLES `ac_user` WRITE;
/*!40000 ALTER TABLE `ac_user` DISABLE KEYS */;
INSERT INTO `ac_user` VALUES
(1,'admin','http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/e31e9b24b2644351a779f827255430b0.png',1,'admin@tduckcloud.com',NULL,'$2a$10$FgOTdkh3qVLE9DNgD4XzDu2PCJB3QtnGbriBPaMhMKTVWM9XYsiIm','1',2,'2024-11-22 17:31:46','49.73.249.117',1,0,'2021-06-13 13:49:25','2024-11-22 17:31:46'),
(15672,'chen','https://s1.locimg.com/2023/05/16/17db376b12ec4.png',0,'chenjianhao98@outlook.com','13205232576','$2a$10$QlBWiMhOJWQ7vqNsxwv4bepT6PPZjtsZ5iq.DC5YmtL065lYSbqfC',NULL,2,'2024-09-09 18:26:06','74.48.68.88',1,0,'2024-09-09 16:14:54','2024-09-09 18:26:06'),
(15673,'逯运凡','https://s1.locimg.com/2023/05/16/17db376b12ec4.png',0,'kongchengli@cynasck.asia',NULL,'$2a$10$uj2CIRaaMcYLFE/INYdzCO1.i5eu4M9DdmPO56bJkB76xGJOnScDm','2',NULL,NULL,NULL,1,0,'2024-09-09 18:25:54','2024-09-09 18:25:54');
/*!40000 ALTER TABLE `ac_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ac_user_authorize`
--

DROP TABLE IF EXISTS `ac_user_authorize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ac_user_authorize` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '第三方平台类型',
  `app_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平台AppId',
  `open_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '平台OpenId',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '平台用户名',
  `user_id` bigint DEFAULT NULL COMMENT '用户Id',
  `user_info` json DEFAULT NULL COMMENT '平台用户信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `open_id` (`open_id`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='第三方用户授权信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ac_user_authorize`
--

LOCK TABLES `ac_user_authorize` WRITE;
/*!40000 ALTER TABLE `ac_user_authorize` DISABLE KEYS */;
/*!40000 ALTER TABLE `ac_user_authorize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ac_user_token`
--

DROP TABLE IF EXISTS `ac_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ac_user_token` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL DEFAULT '0' COMMENT '类型',
  `user_id` bigint NOT NULL COMMENT '用户Id',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'token',
  `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=1431 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ac_user_token`
--

LOCK TABLES `ac_user_token` WRITE;
/*!40000 ALTER TABLE `ac_user_token` DISABLE KEYS */;
INSERT INTO `ac_user_token` VALUES
(28,0,15672,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxNTY3MiIsImlhdCI6MTcyNTkwNjMwNCwiZXhwIjoxNzI2NTExMTA0fQ._xMQpqCFRKaHE6sPfgIpNhaLimiuXok-WpQhbWVungLFwk8FEmGFpUMeuBYeQ7tSeGJCAXW3D1XthA8-yOpnTg','2024-09-16 18:25:05','2024-09-09 18:25:05','2024-09-09 18:25:05'),
(29,0,15672,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxNTY3MiIsImlhdCI6MTcyNTkwNjM2NSwiZXhwIjoxNzI2NTExMTY1fQ.fQo00Wi_dL7XW-DTPb0PAgMeN25Uw6fz9OepEtIwFIAAftQfxndq94UWjNzn45Ynn-cIfp2NWvxcyaxIxLtCOQ','2024-09-16 18:26:06','2024-09-09 18:26:06','2024-09-09 18:26:06'),
(1429,0,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzMxNzY0ODkyLCJleHAiOjE3MzIzNjk2OTJ9.gO_J-TnTzKJTuz65J1ReO8ukhhjGcCVJBWp9Asd8H_pwXamtRellbZzYAcRUN1Jg9kI1HDVpSQUtczrlpywH2A','2024-11-23 13:48:13','2024-11-16 13:48:13','2024-11-16 13:48:13'),
(1430,0,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzMyMjk2NzA2LCJleHAiOjE3MzI5MDE1MDZ9.pd5Eyd23AugENPnuRxANsIP8wL2xzonw7Rkxs-9RHea-VO-ch1TBqMOow74Hi0JHiX-y69IfeK47NvGeDGrA0w','2024-11-29 17:31:46','2024-11-22 17:31:46','2024-11-22 17:31:46');
/*!40000 ALTER TABLE `ac_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_form_template`
--

DROP TABLE IF EXISTS `fm_form_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_form_template` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '模板Id',
  `form_key` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '模板唯一标识',
  `cover_img` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '封面图',
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '模板名称',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '模板I描述',
  `category_id` int NOT NULL COMMENT '模板类型',
  `scheme` json DEFAULT NULL COMMENT '模板定义',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3613 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='表单模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_form_template`
--

LOCK TABLES `fm_form_template` WRITE;
/*!40000 ALTER TABLE `fm_form_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `fm_form_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_form_template_category`
--

DROP TABLE IF EXISTS `fm_form_template_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_form_template_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '分类名称',
  `sort` int DEFAULT NULL COMMENT '排序',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='项目模板分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_form_template_category`
--

LOCK TABLES `fm_form_template_category` WRITE;
/*!40000 ALTER TABLE `fm_form_template_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `fm_form_template_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_form_theme`
--

DROP TABLE IF EXISTS `fm_form_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_form_theme` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主题名称',
  `style` bigint NOT NULL COMMENT '主题风格',
  `head_img_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '头部图片',
  `background_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '背景图片',
  `theme_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主题颜色代码',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='项目主题外观模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_form_theme`
--

LOCK TABLES `fm_form_theme` WRITE;
/*!40000 ALTER TABLE `fm_form_theme` DISABLE KEYS */;
/*!40000 ALTER TABLE `fm_form_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_form_theme_category`
--

DROP TABLE IF EXISTS `fm_form_theme_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_form_theme_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主题名称',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='表单主题分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_form_theme_category`
--

LOCK TABLES `fm_form_theme_category` WRITE;
/*!40000 ALTER TABLE `fm_form_theme_category` DISABLE KEYS */;
INSERT INTO `fm_form_theme_category` VALUES
(32,'空城里',NULL,'2024-09-09 17:49:47','2024-09-09 17:49:47');
/*!40000 ALTER TABLE `fm_form_theme_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form`
--

DROP TABLE IF EXISTS `fm_user_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form_key` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单唯一标识',
  `source_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '来源Id',
  `source_type` tinyint DEFAULT NULL COMMENT '来源类型',
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '表单描述',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '表单类型',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `is_folder` tinyint unsigned DEFAULT '0' COMMENT '是文件夹',
  `folder_id` bigint DEFAULT '0' COMMENT '文件夹Id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`form_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8470 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户表单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form`
--

LOCK TABLES `fm_user_form` WRITE;
/*!40000 ALTER TABLE `fm_user_form` DISABLE KEYS */;
INSERT INTO `fm_user_form` VALUES
(8467,'hlYd7ZZQ',NULL,1,'<h2 style=\"text-align: center;\">【空城里】招新问卷生电篇</h2>','<p>一个关于 空城里服务器的招新问卷生电版本</p>\n<p>注：本问卷部分题目可能过难，但是均为服务器版本1.20.1试验下获得的答案。 当您答不上时，请尝试更换其他问卷进行答案提交。</p>\n<p>本页面所有答案都允许您使用wiki搜索答案（只要您查得到）</p>\n<p>假如wiki进不去可以找群主花五块钱购买包月VPS，至于用途，我们不管（别随意分享就行）</p>',1,'1',2,0,0,0,'2024-09-12 08:49:43','2024-09-09 16:17:21'),
(8468,'K2gUquCR',NULL,1,'<h2 style=\"text-align: center;\">【空城里】招新问卷建筑篇</h2>','<h3>感谢您选择此问卷填写，鉴于此问卷的特殊性，会进行人工审核</h3>\n<h3>请认真作答，题目中的问题也请诚实填写。</h3>\n<h3>如果发现填写不属实将移除您的白名单重新选择问卷进行填写！</h3>',1,'1',2,0,0,0,'2024-09-12 09:08:20','2024-09-12 08:50:18'),
(8469,'GwZfxHGI',NULL,1,'<h2 style=\"text-align: center;\">【空城里】招新问卷小白篇</h2>','<p style=\"text-align: left;\">如果您填写了生电，建筑篇都不通过或者太难，选择此问卷是一个不错的选择。</p>\n<p style=\"text-align: left;\">但我们不保证您能通过审核，所以请优先选择其他两个问卷。</p>',1,'1',2,0,0,0,'2024-09-12 09:20:03','2024-09-12 09:06:17');
/*!40000 ALTER TABLE `fm_user_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form_auth`
--

DROP TABLE IF EXISTS `fm_user_form_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form_auth` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form_key` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '项目key',
  `auth_group_id` bigint DEFAULT NULL COMMENT '授权组id',
  `user_id_list` json DEFAULT NULL COMMENT '用户Id列表',
  `role_id_list` json DEFAULT NULL COMMENT '角色Id列表',
  `dept_id_list` json DEFAULT NULL COMMENT '部门Id列表',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `project_key` (`form_key`,`auth_group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='表单授权对象';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form_auth`
--

LOCK TABLES `fm_user_form_auth` WRITE;
/*!40000 ALTER TABLE `fm_user_form_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `fm_user_form_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form_data`
--

DROP TABLE IF EXISTS `fm_user_form_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单key',
  `serial_number` int DEFAULT NULL COMMENT '序号',
  `original_data` json DEFAULT NULL COMMENT '填写结果',
  `submit_ua` json DEFAULT NULL COMMENT '提交ua',
  `submit_os` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '提交系统',
  `submit_browser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '提交浏览器',
  `submit_request_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '请求ip',
  `submit_address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '提交地址',
  `complete_time` int DEFAULT NULL COMMENT '完成时间 毫秒',
  `wx_open_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '微信openId',
  `wx_user_info` json DEFAULT NULL COMMENT '微信用户信息',
  `ext_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '扩展字段记录来源等',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `project_key` (`form_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=211761 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='表单收集数据结果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form_data`
--

LOCK TABLES `fm_user_form_data` WRITE;
/*!40000 ALTER TABLE `fm_user_form_data` DISABLE KEYS */;
INSERT INTO `fm_user_form_data` VALUES
(211740,'GwZfxHGI',1,'{\"input1726132409905\": \"5年（电脑端3个月）\", \"input1726132426633\": \"jzzkkk\", \"input1726132477559\": \"3439322815@qq.com\", \"input1726132612256\": \"pcl\", \"radio1726132226180\": 1, \"radio1726132226180label\": \"PCL启动器\"}','{\"os\": {\"name\": \"Android\", \"version\": \"14\"}, \"ua\": \"Mozilla/5.0 (Linux; Android 14; V2324A Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/116.0.0.0 Mobile Safari/537.36 mailapp/6.5.6\", \"cpu\": {}, \"device\": {\"type\": \"mobile\", \"model\": \"V2324A\", \"vendor\": \"Vivo\"}, \"engine\": {\"name\": \"Blink\", \"version\": \"116.0.0.0\"}, \"browser\": {\"name\": \"Chrome WebView\", \"major\": \"116\", \"version\": \"116.0.0.0\"}}','Android','Chrome WebView','218.92.71.34','江苏省-连云港市',52131,NULL,'{}',NULL,'2024-09-12 10:37:54',NULL,'2024-09-12 10:37:54',NULL),
(211743,'GwZfxHGI',2,'{\"input1726132409905\": \"3个月\", \"input1726132426633\": \"greanty\", \"input1726132477559\": \"705272600@qq.com\", \"input1726132612256\": \"复制mod文件到mods文件夹\", \"radio1726132226180\": 3, \"radio1726132226180label\": \"HMCL启动器\"}','{\"os\": {\"name\": \"Android\", \"version\": \"12\"}, \"ua\": \"Mozilla/5.0 (Linux; Android 12; 22041216C Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/109.0.5414.86 MQQBrowser/6.2 TBS/047001 Mobile Safari/537.36 V1_AND_SQ_8.3.9_356_TIM_D QQ/3.5.6.3208 NetType/4G WebP/0.3.0 Pixel/1080 StatusBarHeight/101 SimpleUISwitch/0 QQTheme/1015712\", \"cpu\": {}, \"device\": {\"type\": \"mobile\", \"model\": \"22041216C\", \"vendor\": \"Xiaomi\"}, \"engine\": {\"name\": \"Blink\", \"version\": \"109.0.5414.86\"}, \"browser\": {\"name\": \"QQ\", \"major\": \"3\", \"version\": \"3.5.6.3208\"}}','Android','QQ','218.12.17.16','河北省-石家庄市',75530,NULL,'{}',NULL,'2024-09-13 08:56:00',NULL,'2024-09-13 08:56:00',NULL),
(211745,'GwZfxHGI',3,'{\"input1726132409905\": \"13y\", \"input1726132426633\": \"C1zmo1o\", \"input1726132477559\": \"3441759670@qq.com\", \"input1726132612256\": \"mod文件夹\", \"radio1726132226180\": 1, \"radio1726132226180label\": \"PCL启动器\"}','{\"os\": {\"name\": \"iOS\", \"version\": \"17.5.1\"}, \"ua\": \"Mozilla/5.0 (iPhone; CPU iPhone OS 17_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 mailapp/6.5.6\", \"cpu\": {}, \"device\": {\"type\": \"mobile\", \"model\": \"iPhone\", \"vendor\": \"Apple\"}, \"engine\": {\"name\": \"WebKit\", \"version\": \"605.1.15\"}, \"browser\": {\"name\": \"WebKit\", \"major\": \"605\", \"version\": \"605.1.15\"}}','iOS','WebKit','220.205.248.28','安徽省-合肥市',40739,NULL,'{}',NULL,'2024-09-13 09:50:03',NULL,'2024-09-13 09:50:03',NULL),
(211748,'GwZfxHGI',5,'{\"input1726132409905\": \"1year\", \"input1726132426633\": \"Ccheng6\", \"input1726132477559\": \"3295390871@qq.com\", \"input1726132612256\": \"整合包\", \"radio1726132226180\": 3, \"radio1726132226180label\": \"HMCL启动器\"}','{\"os\": {\"name\": \"Windows\", \"version\": \"10\"}, \"ua\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 Edg/128.0.0.0\", \"cpu\": {\"architecture\": \"amd64\"}, \"device\": {}, \"engine\": {\"name\": \"Blink\", \"version\": \"128.0.0.0\"}, \"browser\": {\"name\": \"Edge\", \"major\": \"128\", \"version\": \"128.0.0.0\"}}','Windows','Edge','223.147.65.106','湖南省-衡阳市',27536,NULL,'{}',NULL,'2024-09-13 12:00:32',NULL,'2024-09-13 12:00:32',NULL),
(211752,'GwZfxHGI',1,'{\"input1726132409905\": \"7年\", \"input1726132426633\": \"zw018\", \"input1726132477559\": \"2195251843@qq.com\", \"input1726132612256\": \"把mod啥啊加入mod我就去夹\", \"radio1726132226180\": 1, \"radio1726132226180label\": \"PCL启动器\"}','{\"os\": {\"name\": \"Android\", \"version\": \"13\"}, \"ua\": \"Mozilla/5.0 (Linux; U; Android 13; zh-cn; 21091116AC Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.5414.118 Mobile Safari/537.36 XiaoMi/MiuiBrowser/18.5.40902\", \"cpu\": {}, \"device\": {\"type\": \"mobile\", \"model\": \"21091116AC\", \"vendor\": \"Xiaomi\"}, \"engine\": {\"name\": \"Blink\", \"version\": \"109.0.5414.118\"}, \"browser\": {\"name\": \"MIUI Browser\", \"major\": \"18\", \"version\": \"18.5.40902\"}}','Android','MIUI Browser','36.148.106.244','湖南省-永州市',62591,NULL,'{}',NULL,'2024-09-22 07:38:02',NULL,'2024-09-22 07:38:02',NULL),
(211753,'hlYd7ZZQ',4,'{\"input1725899166854\": \"1632465709@qq.com\", \"input1725903676830\": \"c\", \"radio1725898708741\": 3, \"radio1725898863178\": 3, \"radio1725898894866\": 5, \"radio1725898918202\": 2, \"radio1725898954252\": 2, \"radio1725899049559\": 1, \"radio1725899103760\": 1, \"radio1726130061946\": 1, \"radio1726130285270\": 1, \"radio1726130573585\": 1, \"radio1725898708741label\": \"9000\", \"radio1725898863178label\": \"12\", \"radio1725898894866label\": \"侦测器\", \"radio1725898918202label\": \"3\", \"radio1725898954252label\": \"BUD更新\", \"radio1725899049559label\": \"使用题2的原理\", \"radio1725899103760label\": \"64 64 64 64 64\", \"radio1726130061946label\": \"两个拉杆状态相同输出0，不同输出1\", \"radio1726130285270label\": \"在信号快消失时重新充能\", \"radio1726130573585label\": \"右侧拉杆开启输出0\"}','{\"os\": {\"name\": \"Android\", \"version\": \"13\"}, \"ua\": \"Mozilla/5.0 (Linux; Android 13; WDY-AN00 Build/HONORWDY-AN00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/121.0.6167.71 MQQBrowser/6.2 TBS/047205 Mobile Safari/537.36 V1_AND_SQ_9.1.0_7518_YYB_D QQ/9.1.0.19695 NetType/4G WebP/0.3.0 AppId/537244897 Pixel/720 StatusBarHeight/48 SimpleUISwitch/0 QQTheme/1103 StudyMode/0 CurrentMode/0 CurrentFontScale/1.0 GlobalDensityScale/0.9 AllowLandscape/false InMagicWin/0\", \"cpu\": {}, \"device\": {\"type\": \"mobile\", \"model\": \"WDY-AN00\", \"vendor\": \"Huawei\"}, \"engine\": {\"name\": \"Blink\", \"version\": \"121.0.6167.71\"}, \"browser\": {\"name\": \"QQ\", \"major\": \"9\", \"version\": \"9.1.0.19695\"}}','Android','QQ','49.93.224.25','江苏省-',57347,NULL,'{}',NULL,'2024-09-28 14:28:33',NULL,'2024-09-28 14:28:33',NULL),
(211754,'hlYd7ZZQ',5,'{\"input1725899166854\": \"1632465709@qq.com\", \"input1725903676830\": \"c\", \"radio1725898708741\": 1, \"radio1725898863178\": 1, \"radio1725898894866\": 1, \"radio1725898918202\": 4, \"radio1725898954252\": 3, \"radio1725899049559\": 3, \"radio1725899103760\": 2, \"radio1726130061946\": 2, \"radio1726130285270\": 3, \"radio1726130573585\": 2, \"radio1725898708741label\": \"6000\", \"radio1725898863178label\": \"10\", \"radio1725898894866label\": \"黑曜石\", \"radio1725898918202label\": \"5\", \"radio1725898954252label\": \"魔法检测\", \"radio1725899049559label\": \"比较器比较树苗是否成长\", \"radio1725899103760label\": \"10 10 10 10 10\", \"radio1726130061946label\": \"不论状态都无法输出0\", \"radio1726130285270label\": \"为输出的信号强制充能\", \"radio1726130573585label\": \"左侧拉杆开启输出0\"}','{\"os\": {\"name\": \"Android\", \"version\": \"13\"}, \"ua\": \"Mozilla/5.0 (Linux; Android 13; WDY-AN00 Build/HONORWDY-AN00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/121.0.6167.71 MQQBrowser/6.2 TBS/047205 Mobile Safari/537.36 V1_AND_SQ_9.1.0_7518_YYB_D QQ/9.1.0.19695 NetType/4G WebP/0.3.0 AppId/537244897 Pixel/720 StatusBarHeight/48 SimpleUISwitch/0 QQTheme/1103 StudyMode/0 CurrentMode/0 CurrentFontScale/1.0 GlobalDensityScale/0.9 AllowLandscape/false InMagicWin/0\", \"cpu\": {}, \"device\": {\"type\": \"mobile\", \"model\": \"WDY-AN00\", \"vendor\": \"Huawei\"}, \"engine\": {\"name\": \"Blink\", \"version\": \"121.0.6167.71\"}, \"browser\": {\"name\": \"QQ\", \"major\": \"9\", \"version\": \"9.1.0.19695\"}}','Android','QQ','49.93.224.25','江苏省-南京市',45320,NULL,'{}',NULL,'2024-09-28 14:32:30',NULL,'2024-09-28 14:32:30',NULL),
(211755,'hlYd7ZZQ',6,'{\"input1725899166854\": \"1632465709@qq.com\", \"input1725903676830\": \"test\", \"radio1725898708741\": 1, \"radio1725898863178\": 4, \"radio1725898894866\": 1, \"radio1725898918202\": 4, \"radio1725898954252\": 2, \"radio1725899049559\": 3, \"radio1725899103760\": 3, \"radio1726130061946\": 2, \"radio1726130285270\": 3, \"radio1726130573585\": 2, \"radio1725898708741label\": \"6000\", \"radio1725898863178label\": \"13\", \"radio1725898894866label\": \"黑曜石\", \"radio1725898918202label\": \"5\", \"radio1725898954252label\": \"BUD更新\", \"radio1725899049559label\": \"比较器比较树苗是否成长\", \"radio1725899103760label\": \"37 5 5 5 5\", \"radio1726130061946label\": \"不论状态都无法输出0\", \"radio1726130285270label\": \"为输出的信号强制充能\", \"radio1726130573585label\": \"左侧拉杆开启输出0\"}','{\"os\": {\"name\": \"Linux\", \"version\": \"x86_64\"}, \"ua\": \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.2792.65\", \"cpu\": {\"architecture\": \"amd64\"}, \"device\": {}, \"engine\": {\"name\": \"Blink\", \"version\": \"129.0.0.0\"}, \"browser\": {\"name\": \"Edge\", \"major\": \"129\", \"version\": \"129.0.2792.65\"}}','Linux','Edge','49.93.224.25','江苏省-',31496,NULL,'{}',NULL,'2024-09-30 01:35:03',NULL,'2024-09-30 01:35:03',NULL),
(211756,'hlYd7ZZQ',7,'{\"input1725899166854\": \"chenjianhao98@outlook.com\", \"input1725903676830\": \"chenchen71956\", \"radio1725898708741\": 2, \"radio1725898863178\": 3, \"radio1725898894866\": 1, \"radio1725898918202\": 4, \"radio1725898954252\": 4, \"radio1725899049559\": 3, \"radio1725899103760\": 2, \"radio1726130061946\": 1, \"radio1726130285270\": 2, \"radio1726130573585\": 2, \"radio1725898708741label\": \"7200\", \"radio1725898863178label\": \"12\", \"radio1725898894866label\": \"黑曜石\", \"radio1725898918202label\": \"5\", \"radio1725898954252label\": \"玩家操作\", \"radio1725899049559label\": \"比较器比较树苗是否成长\", \"radio1725899103760label\": \"10 10 10 10 10\", \"radio1726130061946label\": \"两个拉杆状态相同输出0，不同输出1\", \"radio1726130285270label\": \"定时启动传输信号的装置\", \"radio1726130573585label\": \"左侧拉杆开启输出0\"}','{\"os\": {\"name\": \"Linux\", \"version\": \"x86_64\"}, \"ua\": \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.2792.65\", \"cpu\": {\"architecture\": \"amd64\"}, \"device\": {}, \"engine\": {\"name\": \"Blink\", \"version\": \"129.0.0.0\"}, \"browser\": {\"name\": \"Edge\", \"major\": \"129\", \"version\": \"129.0.2792.65\"}}','Linux','Edge','49.64.145.92','江苏省-苏州市',26322,NULL,'{}',NULL,'2024-09-30 20:54:31',NULL,'2024-09-30 20:54:31',NULL),
(211757,'hlYd7ZZQ',8,'{\"input1725899166854\": \"1632465709@qq.com\", \"input1725903676830\": \"test\", \"radio1725898708741\": 3, \"radio1725898863178\": 3, \"radio1725898894866\": 4, \"radio1725898918202\": 4, \"radio1725898954252\": 3, \"radio1725899049559\": 3, \"radio1725899103760\": 3, \"radio1726130061946\": 2, \"radio1726130285270\": 4, \"radio1726130573585\": 2, \"radio1725898708741label\": \"9000\", \"radio1725898863178label\": \"12\", \"radio1725898894866label\": \"玻璃\", \"radio1725898918202label\": \"5\", \"radio1725898954252label\": \"魔法检测\", \"radio1725899049559label\": \"比较器比较树苗是否成长\", \"radio1725899103760label\": \"37 5 5 5 5\", \"radio1726130061946label\": \"不论状态都无法输出0\", \"radio1726130285270label\": \"并没有任何作用\", \"radio1726130573585label\": \"左侧拉杆开启输出0\"}','{\"os\": {\"name\": \"Linux\", \"version\": \"x86_64\"}, \"ua\": \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.2792.65\", \"cpu\": {\"architecture\": \"amd64\"}, \"device\": {}, \"engine\": {\"name\": \"Blink\", \"version\": \"129.0.0.0\"}, \"browser\": {\"name\": \"Edge\", \"major\": \"129\", \"version\": \"129.0.2792.65\"}}','Linux','Edge','49.64.145.92','江苏省-苏州市',24933,NULL,'{}',NULL,'2024-10-01 02:39:18',NULL,'2024-10-01 02:39:18',NULL),
(211758,'K2gUquCR',1,'{\"input1726132002096\": \"jiuyue_cat\", \"input1726132041930\": \"1360675895@qq.com\", \"radio1726131235748\": 2, \"textarea1726131522515\": \"用投影很方便\", \"radio1726131235748label\": \"没有\", \"image_upload1726131285413\": [], \"image_upload1726131409643\": [{\"url\": \"http://bot.cynasck.asia:8999/u/8f43d945d449df243d3f4671365a500c/cd49e7dc064b4ee6ad5681a47082b22b.jpg\", \"name\": \"1704889651326.jpg\"}]}','{\"os\": {\"name\": \"Windows\", \"version\": \"10\"}, \"ua\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0\", \"cpu\": {\"architecture\": \"amd64\"}, \"device\": {}, \"engine\": {\"name\": \"Blink\", \"version\": \"129.0.0.0\"}, \"browser\": {\"name\": \"Edge\", \"major\": \"129\", \"version\": \"129.0.0.0\"}}','Windows','Edge','122.231.105.181','浙江省-杭州市',47300,NULL,'{}',NULL,'2024-10-12 11:09:15',NULL,'2024-10-12 11:09:15',NULL),
(211759,'hlYd7ZZQ',1,'{\"input1725899166854\": \"shjn1538@163.com\", \"input1725903676830\": \"ShringJ\", \"radio1725898708741\": 4, \"radio1725898863178\": 3, \"radio1725898894866\": 5, \"radio1725898918202\": 5, \"radio1725898954252\": 2, \"radio1725899049559\": 4, \"radio1725899103760\": 4, \"radio1726130061946\": 1, \"radio1726130285270\": 3, \"radio1726130573585\": 3, \"textarea1726130865273\": \"可能用于全树种树场变形开关与主开关，排除非正常状态运行可能。\", \"radio1725898708741label\": \"12000\", \"radio1725898863178label\": \"12\", \"radio1725898894866label\": \"侦测器\", \"radio1725898918202label\": \"16\", \"radio1725898954252label\": \"BUD更新\", \"radio1725899049559label\": \"在树苗一旁放上中继器进行充能，变成原木方块时充能被导出\", \"radio1725899103760label\": \"37 1 1 1 1\", \"radio1726130061946label\": \"两个拉杆状态相同输出0，不同输出1\", \"radio1726130285270label\": \"为输出的信号强制充能\", \"radio1726130573585label\": \"双重保险确认开关\"}','{\"os\": {\"name\": \"Windows\", \"version\": \"10\"}, \"ua\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36\", \"cpu\": {\"architecture\": \"amd64\"}, \"device\": {}, \"engine\": {\"name\": \"Blink\", \"version\": \"131.0.0.0\"}, \"browser\": {\"name\": \"Chrome\", \"major\": \"131\", \"version\": \"131.0.0.0\"}}','Windows','Chrome','114.255.146.98','北京市-北京市',360015,NULL,'{}',NULL,'2024-11-23 12:18:25',NULL,'2024-11-23 12:18:25',NULL),
(211760,'GwZfxHGI',1,'{\"input1726132409905\": \"最早接触PE版 0.7.1，Java 玩过1.19.2和1.20.1\", \"input1726132426633\": \"ShringJ\", \"input1726132477559\": \"shjn1538@163.com\", \"input1726132612256\": \"下载拖入mod文件夹或借助启动器直接拖入mod文件\", \"radio1726132226180\": 1, \"radio1726132226180label\": \"PCL启动器\"}','{\"os\": {\"name\": \"Windows\", \"version\": \"10\"}, \"ua\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36\", \"cpu\": {\"architecture\": \"amd64\"}, \"device\": {}, \"engine\": {\"name\": \"Blink\", \"version\": \"131.0.0.0\"}, \"browser\": {\"name\": \"Chrome\", \"major\": \"131\", \"version\": \"131.0.0.0\"}}','Windows','Chrome','114.255.146.98','北京市-北京市',121205,NULL,'{}',NULL,'2024-11-24 08:33:00',NULL,'2024-11-24 08:33:00',NULL);
/*!40000 ALTER TABLE `fm_user_form_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form_item`
--

DROP TABLE IF EXISTS `fm_user_form_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '项目key',
  `form_item_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单项Id',
  `type` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单项类型 ',
  `label` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单项标题',
  `is_display_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '展示类型组件',
  `is_hide_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '隐藏类型组件',
  `is_special_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '特殊处理类型',
  `show_label` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否显示标签',
  `default_value` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '表单项默认值',
  `required` tinyint(1) NOT NULL COMMENT '是否必填',
  `placeholder` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '输入型提示文字',
  `sort` bigint DEFAULT '0' COMMENT '排序',
  `span` int NOT NULL DEFAULT '24' COMMENT '栅格宽度',
  `scheme` json DEFAULT NULL COMMENT '表表单原始JSON',
  `reg_list` json DEFAULT NULL COMMENT '正则表达式 ',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `project_key` (`form_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59084 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='表单项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form_item`
--

LOCK TABLES `fm_user_form_item` WRITE;
/*!40000 ALTER TABLE `fm_user_form_item` DISABLE KEYS */;
INSERT INTO `fm_user_form_item` VALUES
(59044,'hlYd7ZZQ','radio1725898708741','RADIO','<p>1.   在JAVA 空城里.cn 服务器的（设TPS为20）某个基于末地传送门的主世界区块常加载的刷沙机，其运行时近似匀速的将沙子复制到末地，落沙经按钮破坏变成掉落物的形式并被图中的漏斗A吸收。初始时刻漏斗和箱子中无物品，某玩家在主世界启动刷沙机后进入末地，发现箱子内物品在不断增加。若该装置在稳定运行一小时后两端同时关机（可继续进行收集）的情况下可收集多少沙子？</p>\n<p>!!漏斗的效率一般为2.5个物品/秒</p>',0,0,0,1,NULL,1,'此题为必填项目',65536,24,'{\"dId\": 59044, \"key\": \"radio1725898708741172590348504659044\", \"size\": \"medium\", \"sort\": 65536, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>1.   在JAVA 空城里.cn 服务器的（设TPS为20）某个基于末地传送门的主世界区块常加载的刷沙机，其运行时近似匀速的将沙子复制到末地，落沙经按钮破坏变成掉落物的形式并被图中的漏斗A吸收。初始时刻漏斗和箱子中无物品，某玩家在主世界启动刷沙机后进入末地，发现箱子内物品在不断增加。若该装置在稳定运行一小时后两端同时关机（可继续进行收集）的情况下可收集多少沙子？</p>\\n<p>!!漏斗的效率一般为2.5个物品/秒</p>\", \"border\": false, \"formId\": \"radio1725898708741\", \"inline\": false, \"options\": [{\"label\": \"6000\", \"value\": 1}, {\"label\": \"7200\", \"value\": 2}, {\"label\": \"9000\", \"value\": 3}, {\"label\": \"12000\", \"value\": 4}], \"regList\": [], \"tagIcon\": \"radio\", \"hideType\": false, \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17258987087411725898708741\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": false, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1725898708741\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1725898708741\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-09 17:38:55','2024-09-09 16:18:31'),
(59045,'hlYd7ZZQ','image1725898824703','IMAGE','图片展示',1,0,0,0,NULL,0,'',196608,7,'{\"alt\": \"\", \"dId\": 59045, \"fit\": \"contain\", \"key\": \"image1725898824703172672110221259045\", \"src\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/65ba66db36a541078ad50c0f7afc0cec.png\", \"sort\": 196608, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-image\", \"span\": 7, \"error\": \"image\", \"label\": \"图片展示\", \"formId\": \"image1725898824703\", \"regList\": [], \"tagIcon\": \"image\", \"required\": false, \"changeTag\": true, \"renderKey\": \"image17258988247031725898824703\", \"showLabel\": false, \"displayType\": true, \"showRegList\": false, \"showRequired\": false, \"showClearable\": false, \"showDefaultValue\": false}, \"typeId\": \"IMAGE\", \"vModel\": \"image1725898824703\", \"regList\": [], \"formItemId\": \"image1725898824703\", \"displayType\": true, \"placeholder\": \"\"}','[]','2024-09-19 04:46:18','2024-09-09 16:20:29'),
(59046,'hlYd7ZZQ','radio1725898863178','RADIO','<p>2.   在JAVA 空城里.cn 服务器中，一个活塞（粘性活塞同理）最多可以推出多少个方块</p>',0,0,0,1,NULL,1,'此题为必填项目',327680,24,'{\"dId\": 59046, \"key\": \"radio1725898863178172590348504659046\", \"size\": \"medium\", \"sort\": 327680, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>2.   在JAVA 空城里.cn 服务器中，一个活塞（粘性活塞同理）最多可以推出多少个方块</p>\", \"border\": false, \"formId\": \"radio1725898863178\", \"inline\": false, \"options\": [{\"label\": \"10\", \"value\": 1}, {\"label\": \"11\", \"value\": 2}, {\"label\": \"12\", \"value\": 3}, {\"label\": \"13\", \"value\": 4}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17258988631781725898863178\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1725898863178\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1725898863178\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-09 17:39:03','2024-09-09 16:21:04'),
(59047,'hlYd7ZZQ','radio1725898894866','RADIO','<p>3.   下列选项中，哪个方块可以被即将拉回的粘液块黏住并拉回</p>',0,0,0,1,NULL,1,'此题为必填项目',458752,24,'{\"dId\": 59047, \"key\": \"radio1725898894866172590348504659047\", \"size\": \"medium\", \"sort\": 458752, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>3.   下列选项中，哪个方块可以被即将拉回的粘液块黏住并拉回</p>\", \"border\": false, \"formId\": \"radio1725898894866\", \"inline\": false, \"options\": [{\"label\": \"黑曜石\", \"value\": 1}, {\"label\": \"末地传送门框架\", \"value\": 2}, {\"label\": \"树叶\", \"value\": 3}, {\"label\": \"玻璃\", \"value\": 4}, {\"label\": \"侦测器\", \"value\": 5}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17258988948661725898894866\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1725898894866\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1725898894866\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-09 17:39:09','2024-09-09 16:21:37'),
(59048,'hlYd7ZZQ','radio1725898918202','RADIO','<p>4.   在JAVA 空城里.cn 服务器中，玩家chenchen71956准备建造一个y轴为-63开始的2048核的恐吓式生物刷铁机，在他建造时，每个单元的最低村民数量为？</p>',0,0,0,1,NULL,1,'此题为必填项目',589824,24,'{\"dId\": 59048, \"key\": \"radio1725898918202172590348504659048\", \"size\": \"medium\", \"sort\": 589824, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>4.   在JAVA 空城里.cn 服务器中，玩家chenchen71956准备建造一个y轴为-63开始的2048核的恐吓式生物刷铁机，在他建造时，每个单元的最低村民数量为？</p>\", \"border\": false, \"formId\": \"radio1725898918202\", \"inline\": false, \"options\": [{\"label\": \"3\", \"value\": 2}, {\"label\": \"4\", \"value\": 3}, {\"label\": \"5\", \"value\": 4}, {\"label\": \"16\", \"value\": 5}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17258989182021725898918202\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1725898918202\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1725898918202\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-09 17:39:21','2024-09-09 16:21:59'),
(59049,'hlYd7ZZQ','radio1725898954252','RADIO','<p>5.   如图，请回答是哪种特性使得在右下角的活塞相邻处放置任意方块都会导致粘液块和红石块被推出</p>',0,0,0,1,NULL,1,'此题为必填项目',720896,24,'{\"dId\": 59049, \"key\": \"radio1725898954252172590348504659049\", \"size\": \"medium\", \"sort\": 720896, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>5.   如图，请回答是哪种特性使得在右下角的活塞相邻处放置任意方块都会导致粘液块和红石块被推出</p>\", \"border\": false, \"formId\": \"radio1725898954252\", \"inline\": false, \"options\": [{\"label\": \"BUD更新\", \"value\": 2}, {\"label\": \"魔法检测\", \"value\": 3}, {\"label\": \"玩家操作\", \"value\": 4}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17258989542521725898954252\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1725898954252\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1725898954252\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-09 17:39:27','2024-09-09 16:22:35'),
(59050,'hlYd7ZZQ','image1725899007299','IMAGE','<p>第5题图</p>',1,0,0,1,NULL,0,'',851968,12,'{\"alt\": \"\", \"dId\": 59050, \"fit\": \"contain\", \"key\": \"image1725899007299172672110221259050\", \"src\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/b7cf2910a20a4f5dbce2c7a68c347377.png\", \"sort\": 851968, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-image\", \"span\": 12, \"error\": \"image\", \"label\": \"<p>第5题图</p>\", \"formId\": \"image1725899007299\", \"regList\": [], \"tagIcon\": \"image\", \"required\": false, \"changeTag\": true, \"renderKey\": \"image17258990072991725899007299\", \"showLabel\": true, \"displayType\": true, \"showRegList\": false, \"showRequired\": false, \"showClearable\": false, \"showDefaultValue\": false}, \"typeId\": \"IMAGE\", \"vModel\": \"image1725899007299\", \"regList\": [], \"formItemId\": \"image1725899007299\", \"displayType\": true, \"placeholder\": \"\"}','[]','2024-09-19 04:46:28','2024-09-09 16:23:29'),
(59051,'hlYd7ZZQ','radio1725899049559','RADIO','<p>6.  在bilibili作者：喜欢发呆的执念 BV号为BV1sp4y1J7Pd 的作品中，这款全树种会检测树苗是否长大变成原木，该检测装置位于机器底下四个不断运动的活塞，看起来像一个四缸发动机。其中使用的检测方式为？</p>',0,0,0,1,NULL,1,'此题为必填项目',983040,24,'{\"dId\": 59051, \"key\": \"radio1725899049559172590348504659051\", \"size\": \"medium\", \"sort\": 983040, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>6.  在bilibili作者：喜欢发呆的执念 BV号为BV1sp4y1J7Pd 的作品中，这款全树种会检测树苗是否长大变成原木，该检测装置位于机器底下四个不断运动的活塞，看起来像一个四缸发动机。其中使用的检测方式为？</p>\", \"border\": false, \"formId\": \"radio1725899049559\", \"inline\": false, \"options\": [{\"label\": \"使用题2的原理\", \"value\": 1}, {\"label\": \"侦测器查看树苗是否长大\", \"value\": 2}, {\"label\": \"比较器比较树苗是否成长\", \"value\": 3}, {\"label\": \"在树苗一旁放上中继器进行充能，变成原木方块时充能被导出\", \"value\": 4}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17258990495591725899049559\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1725899049559\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1725899049559\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-09 17:39:35','2024-09-09 16:24:10'),
(59052,'hlYd7ZZQ','image1725899074446','IMAGE','<h4>第6题图<code></code></h4>',1,0,0,1,NULL,0,'',1114112,12,'{\"alt\": \"\", \"dId\": 59052, \"fit\": \"contain\", \"key\": \"image1725899074446172672110221259052\", \"src\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/fa5bb0ca01b543b893bafea30477702d.png\", \"sort\": 1114112, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-image\", \"span\": 12, \"error\": \"image\", \"label\": \"<h4>第6题图<code></code></h4>\", \"formId\": \"image1725899074446\", \"regList\": [], \"tagIcon\": \"image\", \"required\": false, \"changeTag\": true, \"renderKey\": \"image17258990744461725899074446\", \"showLabel\": true, \"displayType\": true, \"showRegList\": false, \"showRequired\": false, \"showClearable\": false, \"showDefaultValue\": false}, \"typeId\": \"IMAGE\", \"vModel\": \"image1725899074446\", \"regList\": [], \"formItemId\": \"image1725899074446\", \"displayType\": true, \"placeholder\": \"\"}','[]','2024-09-19 04:46:39','2024-09-09 16:24:35'),
(59053,'hlYd7ZZQ','radio1725899103760','RADIO','<p>7.   如图，玩家chenchen71956正在建造一个打包机单片，当他准备填充物品时，发现自己不会填。您认为图中标记的漏斗在不考虑填充材料是否足够的情况下应该怎么装填想要收集的物品？</p>',0,0,0,1,NULL,1,'此题为必填项目',1245184,24,'{\"dId\": 59053, \"key\": \"radio1725899103760172590348504659053\", \"size\": \"medium\", \"sort\": 1245184, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>7.   如图，玩家chenchen71956正在建造一个打包机单片，当他准备填充物品时，发现自己不会填。您认为图中标记的漏斗在不考虑填充材料是否足够的情况下应该怎么装填想要收集的物品？</p>\", \"border\": false, \"formId\": \"radio1725899103760\", \"inline\": false, \"options\": [{\"label\": \"64 64 64 64 64\", \"value\": 1}, {\"label\": \"10 10 10 10 10\", \"value\": 2}, {\"label\": \"37 5 5 5 5\", \"value\": 3}, {\"label\": \"37 1 1 1 1\", \"value\": 4}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17258991037601725899103760\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1725899103760\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1725899103760\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-09 17:40:38','2024-09-09 16:25:07'),
(59054,'hlYd7ZZQ','image1725899139023','IMAGE','<p>第7题图</p>',1,0,0,1,NULL,0,'',1376256,12,'{\"alt\": \"\", \"dId\": 59054, \"fit\": \"contain\", \"key\": \"image1725899139023172672110221259054\", \"src\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/95dd1e0a596f4066817498acc6ba9abb.png\", \"sort\": 1376256, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-image\", \"span\": 12, \"error\": \"image\", \"label\": \"<p>第7题图</p>\", \"formId\": \"image1725899139023\", \"regList\": [], \"tagIcon\": \"image\", \"required\": false, \"changeTag\": true, \"renderKey\": \"image17258991390231725899139023\", \"showLabel\": true, \"displayType\": true, \"showRegList\": false, \"showRequired\": false, \"showClearable\": false, \"showDefaultValue\": false}, \"typeId\": \"IMAGE\", \"vModel\": \"image1725899139023\", \"regList\": [], \"formItemId\": \"image1725899139023\", \"displayType\": true, \"placeholder\": \"\"}','[]','2024-09-19 04:46:44','2024-09-09 16:25:40'),
(59055,'hlYd7ZZQ','input1725899166854','INPUT','<p>请填写您正在使用的邮箱，但尽量不要是qq.com</p>',0,0,0,1,NULL,1,'请务必核对邮箱',1507328,24,'{\"dId\": 59055, \"key\": \"input1725899166854172614212027559055\", \"sort\": 1507328, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>请填写您正在使用的邮箱，但尽量不要是qq.com</p>\", \"append\": \"\", \"formId\": \"input1725899166854\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"email\", \"message\": \"请输入正确的邮箱地址\"}, \"required\": true, \"changeTag\": true, \"renderKey\": 1725904046940, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1725899166854\", \"regList\": [], \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"formItemId\": \"input1725899166854\", \"displayType\": false, \"placeholder\": \"请务必核对邮箱\", \"prefix-icon\": \"el-icon-warning\", \"suffix-icon\": \"el-icon-message\", \"show-word-limit\": false}','[]','2024-09-12 11:55:23','2024-09-09 16:26:10'),
(59057,'hlYd7ZZQ','input1725903676830','INPUT','<p>您的玩家ID</p>',0,0,0,1,NULL,1,'请输入游戏ID',1441792,24,'{\"dId\": 59057, \"key\": \"input1725903676830172614208998759057\", \"sort\": 1441792, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>您的玩家ID</p>\", \"append\": \"\", \"formId\": \"input1725903676830\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"message\": \"请输入正确的无校验\"}, \"required\": true, \"changeTag\": true, \"renderKey\": 1725903717262, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1725903676830\", \"regList\": [], \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"formItemId\": \"input1725903676830\", \"displayType\": false, \"placeholder\": \"请输入游戏ID\", \"prefix-icon\": \"el-icon-edit-outline\", \"suffix-icon\": \"el-icon-coordinate\", \"show-word-limit\": false}','[]','2024-09-12 11:55:13','2024-09-09 17:41:32'),
(59058,'hlYd7ZZQ','radio1726130061946','RADIO','<p>8. 下列哪项是该装置的用途？</p>',0,0,0,1,NULL,1,'',1409024,24,'{\"size\": \"medium\", \"sort\": 1409024, \"style\": {}, \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>8. 下列哪项是该装置的用途？</p>\", \"border\": false, \"formId\": \"radio1726130061946\", \"inline\": false, \"options\": [{\"label\": \"两个拉杆状态相同输出1，不同输出0\", \"value\": 4}, {\"label\": \"两个拉杆状态相同输出0，不同输出1\", \"value\": 1}, {\"label\": \"不论状态都无法输出0\", \"value\": 2}, {\"label\": \"不论状态都无法输出1\", \"value\": 3}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17261300619461726130061946\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1726130061946\", \"disabled\": false}','[]','2024-09-12 08:37:52','2024-09-12 08:34:21'),
(59060,'hlYd7ZZQ','image1726130122322','IMAGE','<p>第8题图</p>',1,0,0,1,NULL,0,'',1425408,12,'{\"alt\": \"\", \"dId\": 59060, \"fit\": \"contain\", \"key\": \"image1726130122322172672110221259060\", \"src\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/5b1e45b30ab84e9d88a843196de49b14.jpg\", \"sort\": 1425408, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-image\", \"span\": 12, \"error\": \"image\", \"label\": \"<p>第8题图</p>\", \"formId\": \"image1726130122322\", \"regList\": [], \"tagIcon\": \"image\", \"required\": false, \"changeTag\": true, \"renderKey\": \"image17261301223221726130122322\", \"showLabel\": true, \"displayType\": true, \"showRegList\": false, \"showRequired\": false, \"showClearable\": false, \"showDefaultValue\": false}, \"typeId\": \"IMAGE\", \"vModel\": \"image1726130122322\", \"regList\": [], \"formItemId\": \"image1726130122322\", \"displayType\": true, \"placeholder\": \"\"}','[]','2024-09-19 04:47:13','2024-09-12 08:35:26'),
(59061,'hlYd7ZZQ','radio1726130285270','RADIO','<p>9. 该装置的作用？</p>',0,0,0,1,NULL,1,'',1433600,24,'{\"size\": \"medium\", \"sort\": 1433600, \"style\": {}, \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>9. 该装置的作用？</p>\", \"border\": false, \"formId\": \"radio1726130285270\", \"inline\": false, \"options\": [{\"label\": \"定时启动传输信号的装置\", \"value\": 2}, {\"label\": \"为输出的信号强制充能\", \"value\": 3}, {\"label\": \"并没有任何作用\", \"value\": 4}, {\"label\": \"在信号快消失时重新充能\", \"value\": 1}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17261302852701726130285270\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1726130285270\", \"disabled\": false}','[]','2024-09-12 08:42:23','2024-09-12 08:38:05'),
(59062,'hlYd7ZZQ','image1726130301511','IMAGE','<p>第9题图</p>',1,0,0,1,NULL,0,'',1437696,12,'{\"alt\": \"\", \"dId\": 59062, \"fit\": \"contain\", \"key\": \"image1726130301511172672110221359062\", \"src\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/ea192253b49b4bd68a44ab0ff397852a.jpg\", \"sort\": 1437696, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-image\", \"span\": 12, \"error\": \"image\", \"label\": \"<p>第9题图</p>\", \"formId\": \"image1726130301511\", \"regList\": [], \"tagIcon\": \"image\", \"required\": false, \"changeTag\": true, \"renderKey\": \"image17261303015111726130301511\", \"showLabel\": true, \"displayType\": true, \"showRegList\": false, \"showRequired\": false, \"showClearable\": false, \"showDefaultValue\": false}, \"typeId\": \"IMAGE\", \"vModel\": \"image1726130301511\", \"regList\": [], \"formItemId\": \"image1726130301511\", \"displayType\": true, \"placeholder\": \"\"}','[]','2024-09-19 04:47:24','2024-09-12 08:38:22'),
(59063,'hlYd7ZZQ','radio1726130573585','RADIO','<p>10. 该装置的实际用途？</p>',0,0,0,1,NULL,1,'',1439744,24,'{\"size\": \"medium\", \"sort\": 1439744, \"style\": {}, \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>10. 该装置的实际用途？</p>\", \"border\": false, \"formId\": \"radio1726130573585\", \"inline\": false, \"options\": [{\"label\": \"右侧拉杆开启输出0\", \"value\": 1}, {\"label\": \"左侧拉杆开启输出0\", \"value\": 2}, {\"label\": \"双重保险确认开关\", \"value\": 3}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17261305735851726130573585\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1726130573585\", \"disabled\": false}','[]','2024-09-12 08:47:36','2024-09-12 08:42:53'),
(59064,'hlYd7ZZQ','image1726130594868','IMAGE','<p>第10题图</p>',1,0,0,1,NULL,0,'',1440768,12,'{\"alt\": \"\", \"dId\": 59064, \"fit\": \"contain\", \"key\": \"image1726130594868172672110221359064\", \"src\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/74e06f97dca04e14baf1b7569bc0931d.jpg\", \"sort\": 1440768, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-image\", \"span\": 12, \"error\": \"image\", \"label\": \"<p>第10题图</p>\", \"formId\": \"image1726130594868\", \"regList\": [], \"tagIcon\": \"image\", \"required\": false, \"changeTag\": true, \"renderKey\": \"image17261305948681726130594868\", \"showLabel\": true, \"displayType\": true, \"showRegList\": false, \"showRequired\": false, \"showClearable\": false, \"showDefaultValue\": false}, \"typeId\": \"IMAGE\", \"vModel\": \"image1726130594868\", \"regList\": [], \"formItemId\": \"image1726130594868\", \"displayType\": true, \"placeholder\": \"\"}','[]','2024-09-19 04:47:29','2024-09-12 08:43:15'),
(59065,'hlYd7ZZQ','textarea1726130865273','TEXTAREA','<p>您认为第10题可以运用在什么机器上？有着什么作用？（不计分，但答案合理其余题目可不作答）</p>',0,0,0,1,NULL,0,'请输入多行文本',1441280,24,'{\"dId\": 59065, \"key\": \"textarea1726130865273173229671729959065\", \"sort\": 1441280, \"type\": \"textarea\", \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"el-input\", \"span\": 24, \"label\": \"<p>您认为第10题可以运用在什么机器上？有着什么作用？（不计分，但答案合理其余题目可不作答）</p>\", \"formId\": \"textarea1726130865273\", \"regList\": [], \"tagIcon\": \"textarea\", \"required\": false, \"changeTag\": true, \"renderKey\": \"textarea17261308652731726130865273\", \"showLabel\": true}, \"typeId\": \"TEXTAREA\", \"vModel\": \"textarea1726130865273\", \"regList\": [], \"autosize\": {\"maxRows\": 4, \"minRows\": 4}, \"disabled\": false, \"readonly\": false, \"formItemId\": \"textarea1726130865273\", \"displayType\": false, \"placeholder\": \"请输入多行文本\", \"show-word-limit\": false}','[]','2024-11-22 17:34:48','2024-09-12 08:47:45'),
(59066,'K2gUquCR','radio1726131235748','RADIO','<p>您是否有原创建筑？（不含改编）</p>',0,0,0,1,NULL,1,'此题为必填项目',65536,24,'{\"dId\": 59066, \"key\": \"radio1726131235748172613132470959066\", \"size\": \"medium\", \"sort\": 65536, \"style\": {}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>您是否有原创建筑？（不含改编）</p>\", \"border\": false, \"formId\": \"radio1726131235748\", \"inline\": true, \"options\": [{\"label\": \"有\", \"value\": 1}, {\"label\": \"没有\", \"value\": 2}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17261312357481726131235748\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1726131235748\", \"regList\": [], \"disabled\": false, \"formItemId\": \"radio1726131235748\", \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-12 08:59:58','2024-09-12 08:53:55'),
(59067,'K2gUquCR','image_upload1726131285413','IMAGE_UPLOAD','<p>请上传您的原创建筑图片（20M内）可多选</p>',0,0,0,1,'[]',1,'此题为必填项目',196608,24,'{\"dId\": 59067, \"key\": \"image_upload1726131285413172613132471059067\", \"name\": \"file\", \"sort\": 196608, \"limit\": 2, \"accept\": \"image/*\", \"action\": \"http://bot.cynasck.asia:8999/form/file/upload/K2gUquCR\", \"config\": {\"tag\": \"t-image-upload\", \"span\": 24, \"label\": \"<p>请上传您的原创建筑图片（20M内）可多选</p>\", \"formId\": \"image_upload1726131285413\", \"regList\": [], \"showTip\": false, \"tagIcon\": \"image-upload\", \"fileSize\": 20, \"required\": true, \"sizeUnit\": \"MB\", \"changeTag\": true, \"renderKey\": \"image_upload17261312854131726131285413\", \"showLabel\": true, \"buttonText\": \"点击上传\", \"showRegList\": false, \"defaultValue\": []}, \"typeId\": \"IMAGE_UPLOAD\", \"vModel\": \"image_upload1726131285413\", \"regList\": [], \"disabled\": false, \"multiple\": false, \"formItemId\": \"image_upload1726131285413\", \"auto-upload\": true, \"displayType\": false, \"placeholder\": \"此题为必填项目\"}','[]','2024-09-12 08:58:11','2024-09-12 08:54:45'),
(59069,'K2gUquCR','image_upload1726131409643','IMAGE_UPLOAD','<p>请上传您的非原创（含改编）建筑图片（20M内）可多选</p>',0,0,0,1,'[]',1,'',458752,24,'{\"dId\": 59069, \"key\": \"image_upload1726131409643172626757562459069\", \"name\": \"file\", \"sort\": 458752, \"limit\": 2, \"accept\": \"image/*\", \"action\": \"http://bot.cynasck.asia:8999/form/file/upload/K2gUquCR\", \"config\": {\"tag\": \"t-image-upload\", \"span\": 24, \"label\": \"<p>请上传您的非原创（含改编）建筑图片（20M内）可多选</p>\", \"formId\": \"image_upload1726131409643\", \"regList\": [], \"showTip\": false, \"tagIcon\": \"image-upload\", \"fileSize\": 20, \"required\": true, \"sizeUnit\": \"MB\", \"changeTag\": true, \"renderKey\": \"image_upload17261314096431726131409643\", \"showLabel\": true, \"buttonText\": \"点击上传\", \"showRegList\": false, \"defaultValue\": []}, \"typeId\": \"IMAGE_UPLOAD\", \"vModel\": \"image_upload1726131409643\", \"regList\": [], \"disabled\": false, \"multiple\": true, \"formItemId\": \"image_upload1726131409643\", \"auto-upload\": true, \"displayType\": false, \"placeholder\": \"\"}','[]','2024-09-13 22:46:26','2024-09-12 08:56:49'),
(59070,'K2gUquCR','textarea1726131522515','TEXTAREA','<p>作为一名非原创（含改编）建筑玩家，分享一下您的建筑心得</p>',0,0,0,1,NULL,0,'请输入多行文本',589824,24,'{\"sort\": 589824, \"type\": \"textarea\", \"style\": {\"width\": \"100%\"}, \"config\": {\"tag\": \"el-input\", \"span\": 24, \"label\": \"<p>作为一名非原创（含改编）建筑玩家，分享一下您的建筑心得</p>\", \"formId\": \"textarea1726131522515\", \"regList\": [], \"tagIcon\": \"textarea\", \"required\": false, \"changeTag\": true, \"renderKey\": \"textarea17261315225151726131522515\", \"showLabel\": true}, \"typeId\": \"TEXTAREA\", \"vModel\": \"textarea1726131522515\", \"autosize\": {\"maxRows\": 4, \"minRows\": 4}, \"disabled\": false, \"readonly\": false, \"placeholder\": \"请输入多行文本\", \"show-word-limit\": false}','[]','2024-09-12 08:59:25','2024-09-12 08:58:42'),
(59071,'K2gUquCR','input1726132002096','INPUT','<p>您的游戏ID</p>',0,0,0,1,NULL,1,'请输入您的游戏ID',720896,24,'{\"sort\": 720896, \"style\": {\"width\": \"100%\"}, \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>您的游戏ID</p>\", \"append\": \"\", \"formId\": \"input1726132002096\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"\", \"message\": \"\"}, \"required\": true, \"changeTag\": true, \"renderKey\": 1726132093880, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1726132002096\", \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"placeholder\": \"请输入您的游戏ID\", \"prefix-icon\": \"\", \"suffix-icon\": \"\", \"show-word-limit\": false}','[]','2024-09-12 09:08:13','2024-09-12 09:06:43'),
(59072,'K2gUquCR','input1726132041930','INPUT','<p>您的常用邮箱</p>',0,0,0,1,NULL,1,'请输入邮箱地址',851968,24,'{\"sort\": 851968, \"style\": {\"width\": \"100%\"}, \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>您的常用邮箱</p>\", \"append\": \"\", \"formId\": \"input1726132041930\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"email\", \"message\": \"请输入正确的邮箱地址\"}, \"required\": true, \"changeTag\": true, \"renderKey\": 1726132080603, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1726132041930\", \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"placeholder\": \"请输入邮箱地址\", \"prefix-icon\": \"\", \"suffix-icon\": \"\", \"show-word-limit\": false}','[]','2024-09-12 09:08:00','2024-09-12 09:07:22'),
(59077,'GwZfxHGI','radio1726132226180','RADIO','<p>您的启动器是？</p>',0,0,0,1,NULL,1,'',327680,24,'{\"size\": \"medium\", \"sort\": 327680, \"style\": {}, \"config\": {\"tag\": \"t-radio-group\", \"span\": 24, \"label\": \"<p>您的启动器是？</p>\", \"border\": false, \"formId\": \"radio1726132226180\", \"inline\": false, \"options\": [{\"label\": \"PCL启动器\", \"value\": 1}, {\"label\": \"FCL启动器\", \"value\": 2}, {\"label\": \"HMCL启动器\", \"value\": 3}, {\"label\": \"其他启动器\", \"value\": 4}], \"regList\": [], \"tagIcon\": \"radio\", \"required\": true, \"changeTag\": true, \"hideQuota\": false, \"renderKey\": \"radio17261322261801726132226180\", \"showLabel\": true, \"optionType\": \"default\", \"optionsType\": 0, \"showRegList\": false, \"otherRequired\": true, \"dynamicOptions\": {\"url\": \"\", \"dataPath\": \"\", \"labelField\": \"\", \"valueField\": \"\"}, \"quotaCycleRule\": \"fixed\", \"showVoteResult\": false, \"quotaRecoverable\": true, \"quotaBlankWarning\": \"\", \"withExclusiveChoice\": false, \"exclusiveChoiceApiCodes\": [], \"hideChoiceWhenQuotaEmpty\": false}, \"typeId\": \"RADIO\", \"vModel\": \"radio1726132226180\", \"disabled\": false}','[]','2024-09-12 09:11:47','2024-09-12 09:10:25'),
(59078,'GwZfxHGI','input1726132313632','INPUT','<p>其他启动器名称</p>',0,0,0,1,NULL,0,'请输入启动器名称',458752,24,'{\"dId\": 59078, \"key\": \"input1726132313632172613234633559078\", \"sort\": 458752, \"style\": {\"width\": \"100%\"}, \"action\": \"http://bot.cynasck.asia:8999undefined\", \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>其他启动器名称</p>\", \"append\": \"\", \"formId\": \"input1726132313632\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"\", \"message\": \"\"}, \"required\": false, \"changeTag\": true, \"renderKey\": 1726132449430, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1726132313632\", \"regList\": [], \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"formItemId\": \"input1726132313632\", \"displayType\": false, \"placeholder\": \"请输入启动器名称\", \"prefix-icon\": \"\", \"suffix-icon\": \"\", \"show-word-limit\": false}','[]','2024-09-12 09:14:08','2024-09-12 09:11:53'),
(59080,'GwZfxHGI','input1726132409905','INPUT','<p>您游玩我的世界有多长时间了？</p>',0,0,0,1,NULL,1,'请输入游玩时间',589824,24,'{\"sort\": 589824, \"style\": {\"width\": \"100%\"}, \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>您游玩我的世界有多长时间了？</p>\", \"append\": \"\", \"formId\": \"input1726132409905\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"\", \"message\": \"\"}, \"required\": true, \"changeTag\": true, \"renderKey\": 1726132456674, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1726132409905\", \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"placeholder\": \"请输入游玩时间\", \"prefix-icon\": \"\", \"suffix-icon\": \"\", \"show-word-limit\": false}','[]','2024-09-12 09:14:16','2024-09-12 09:13:28'),
(59081,'GwZfxHGI','input1726132426633','INPUT','<p>您的游戏ID</p>',0,0,0,1,NULL,1,'请输入您的游戏ID',720896,24,'{\"sort\": 720896, \"style\": {\"width\": \"100%\"}, \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>您的游戏ID</p>\", \"append\": \"\", \"formId\": \"input1726132426633\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"\", \"message\": \"\"}, \"required\": true, \"changeTag\": true, \"renderKey\": 1726132474397, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1726132426633\", \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"placeholder\": \"请输入您的游戏ID\", \"prefix-icon\": \"\", \"suffix-icon\": \"\", \"show-word-limit\": false}','[]','2024-09-12 09:14:33','2024-09-12 09:13:46'),
(59082,'GwZfxHGI','input1726132477559','INPUT','<p>您的常用邮箱</p>',0,0,0,1,NULL,1,'请输入您的邮箱地址',851968,24,'{\"sort\": 851968, \"style\": {\"width\": \"100%\"}, \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>您的常用邮箱</p>\", \"append\": \"\", \"formId\": \"input1726132477559\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"email\", \"message\": \"请输入正确的邮箱地址\"}, \"required\": true, \"changeTag\": true, \"renderKey\": 1726132490414, \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1726132477559\", \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"placeholder\": \"请输入您的邮箱地址\", \"prefix-icon\": \"\", \"suffix-icon\": \"\", \"show-word-limit\": false}','[]','2024-09-12 09:15:04','2024-09-12 09:14:37'),
(59083,'GwZfxHGI','input1726132612256','INPUT','<p>如何添加mod？</p>',0,0,0,1,NULL,1,'请输入单行文本',393216,24,'{\"sort\": 393216, \"style\": {\"width\": \"100%\"}, \"config\": {\"tag\": \"t-input\", \"span\": 24, \"label\": \"<p>如何添加mod？</p>\", \"append\": \"\", \"formId\": \"input1726132612256\", \"prepend\": \"\", \"regList\": [], \"tagIcon\": \"input\", \"dataType\": {\"type\": \"\", \"message\": \"\"}, \"required\": true, \"changeTag\": true, \"renderKey\": \"input17261326122561726132612256\", \"showLabel\": true}, \"typeId\": \"INPUT\", \"vModel\": \"input1726132612256\", \"disabled\": false, \"readonly\": false, \"clearable\": true, \"notRepeat\": false, \"placeholder\": \"请输入单行文本\", \"prefix-icon\": \"\", \"suffix-icon\": \"\", \"show-word-limit\": false}','[]','2024-09-12 09:17:04','2024-09-12 09:16:52');
/*!40000 ALTER TABLE `fm_user_form_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form_logic`
--

DROP TABLE IF EXISTS `fm_user_form_logic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form_logic` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '逻辑Id',
  `form_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单key',
  `scheme` json DEFAULT NULL COMMENT '逻辑定义',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `project_key` (`form_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1710 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='项目逻辑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form_logic`
--

LOCK TABLES `fm_user_form_logic` WRITE;
/*!40000 ALTER TABLE `fm_user_form_logic` DISABLE KEYS */;
INSERT INTO `fm_user_form_logic` VALUES
(1707,'hlYd7ZZQ','[]','2024-09-09 16:29:01','2024-10-28 17:26:43'),
(1708,'K2gUquCR','[{\"triggerList\": [{\"type\": \"show\", \"formItemId\": \"image_upload1726131285413\"}], \"conditionList\": [{\"relation\": \"OR\", \"expression\": \"eq\", \"formItemId\": \"radio1726131235748\", \"optionValue\": 1}]}, {\"triggerList\": [{\"type\": \"show\", \"formItemId\": \"image_upload1726131409643\"}, {\"type\": \"show\", \"formItemId\": \"textarea1726131522515\"}], \"conditionList\": [{\"relation\": \"AND\", \"expression\": \"eq\", \"formItemId\": \"radio1726131235748\", \"optionValue\": 2}]}]','2024-09-12 08:54:26','2024-11-03 10:29:45'),
(1709,'GwZfxHGI','[{\"triggerList\": [{\"type\": \"show\", \"formItemId\": \"input1726132313632\"}], \"conditionList\": [{\"relation\": \"AND\", \"expression\": \"eq\", \"formItemId\": \"radio1726132226180\", \"optionValue\": 4}]}]','2024-09-12 09:12:17','2024-09-12 09:12:23');
/*!40000 ALTER TABLE `fm_user_form_logic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form_setting`
--

DROP TABLE IF EXISTS `fm_user_form_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单key',
  `settings` json DEFAULT NULL COMMENT '设置内容 ',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `project_key` (`form_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=494 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='表单设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form_setting`
--

LOCK TABLES `fm_user_form_setting` WRITE;
/*!40000 ALTER TABLE `fm_user_form_setting` DISABLE KEYS */;
INSERT INTO `fm_user_form_setting` VALUES
(491,'hlYd7ZZQ','{\"formKey\": \"hlYd7ZZQ\", \"wxNotify\": false, \"shareWxImg\": true, \"submitJump\": true, \"emailNotify\": true, \"onlyWxWrite\": false, \"shareWxDesc\": true, \"publicResult\": false, \"recordWxUser\": false, \"shareWxTitle\": true, \"shareWxImgUrl\": \"http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/4a4695e36e914c86b81c7b7ad32947bf.png\", \"submitJumpUrl\": \"https://www.kongchengli.cn/player.html\", \"submitShowType\": 2, \"shareWxDescContent\": \"快来填写问卷，加入我们和小伙伴一起游玩吧！\", \"newWriteNotifyEmail\": \"chenjianhao98@outlook.com;2195251843@qq.com\", \"shareWxTitleContent\": \"空城里 招新问卷生电篇\", \"writeInterviewTimeStatus\": false, \"submitShowCustomPageContent\": \"您的审核结果已发放，一小时内查看您的邮箱，或您的垃圾邮箱。\"}','2024-10-28 17:26:26','2024-09-09 16:32:18'),
(492,'K2gUquCR','{\"formKey\": \"K2gUquCR\", \"submitJump\": true, \"emailNotify\": true, \"publicResult\": false, \"submitJumpUrl\": \"https://www.cynasck.asia/player.html\", \"submitShowType\": 2, \"newWriteNotifyEmail\": \"2195251843@qq.com;chenjianhao98@outlook.com\", \"submitShowCustomPageContent\": \"您的审核已提交，24小时内查看您的邮箱，或您的垃圾邮箱。\"}','2024-09-19 06:02:27','2024-09-12 09:03:48'),
(493,'GwZfxHGI','{\"formKey\": \"GwZfxHGI\", \"submitJump\": true, \"emailNotify\": true, \"publicResult\": false, \"submitJumpUrl\": \"https://www.cynasck.asia/player.html\", \"submitShowType\": 2, \"newWriteNotifyEmail\": \"2195251843@qq.com;chenjianhao98@outlook.com\", \"submitShowCustomPageContent\": \"提交成功您的审核结果已发放，一小时内查看您的邮箱，或您的垃圾邮箱。\"}','2024-09-19 06:02:35','2024-09-12 09:17:22');
/*!40000 ALTER TABLE `fm_user_form_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form_theme`
--

DROP TABLE IF EXISTS `fm_user_form_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form_theme` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单key',
  `submit_btn_text` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '提交按钮文字',
  `logo_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'logo图片',
  `logo_position` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'logo位置',
  `background_color` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '背景颜色',
  `background_img` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '背景图片',
  `show_title` tinyint(1) DEFAULT '1' COMMENT '是否显示标题',
  `show_describe` tinyint(1) DEFAULT '1' COMMENT '是否显示描述语',
  `theme_color` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '主题颜色\r\n',
  `show_number` tinyint(1) DEFAULT '0' COMMENT '显示序号',
  `show_submit_btn` tinyint(1) DEFAULT '1' COMMENT '显示提交按钮',
  `head_img_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头部图片',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `project_key` (`form_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1775 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='项目表单项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form_theme`
--

LOCK TABLES `fm_user_form_theme` WRITE;
/*!40000 ALTER TABLE `fm_user_form_theme` DISABLE KEYS */;
INSERT INTO `fm_user_form_theme` VALUES
(1772,'hlYd7ZZQ','点我提交',NULL,'left','','http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/57dd07167c6142849afcce222402b427.jpg',1,1,NULL,0,1,'http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/cfeacb75f65d4b0d9429b3d97eb409b8.png','2024-09-09 16:30:45','2024-09-09 16:29:14'),
(1773,'K2gUquCR','点我提交',NULL,'left','','http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/102bcd159eb549ce8f421380caefe770.jpg',1,1,NULL,0,1,'http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/cc67f9711697494fa1091620599afe85.png','2024-09-12 09:02:38','2024-09-12 09:01:45'),
(1774,'GwZfxHGI','点我提交',NULL,'left','','http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/04aa4c72992040a9b9448a0652e8a2a6.jpg',1,1,NULL,0,1,'http://bot.cynasck.asia:8999/u/c4ca4238a0b923820dcc509a6f75849b/fb2756c5dbb848338e9020bfd1cd2ef4.png','2024-09-12 09:19:52','2024-09-12 09:19:20');
/*!40000 ALTER TABLE `fm_user_form_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fm_user_form_view_count`
--

DROP TABLE IF EXISTS `fm_user_form_view_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fm_user_form_view_count` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form_key` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表单唯一标识',
  `count` int NOT NULL DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `form_key` (`form_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户表单查看次数';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fm_user_form_view_count`
--

LOCK TABLES `fm_user_form_view_count` WRITE;
/*!40000 ALTER TABLE `fm_user_form_view_count` DISABLE KEYS */;
INSERT INTO `fm_user_form_view_count` VALUES
(1,'hlYd7ZZQ',56,'2024-10-28 08:49:58','2024-09-09 16:39:26'),
(2,'GwZfxHGI',11,'2024-09-30 16:01:01','2024-09-12 10:10:11'),
(3,'K2gUquCR',3,'2024-09-13 19:59:51','2024-09-13 08:54:29');
/*!40000 ALTER TABLE `fm_user_form_view_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_env_config`
--

DROP TABLE IF EXISTS `sys_env_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_env_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `env_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `env_value` json NOT NULL COMMENT '参数键值',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='系统环境配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_env_config`
--

LOCK TABLES `sys_env_config` WRITE;
/*!40000 ALTER TABLE `sys_env_config` DISABLE KEYS */;
INSERT INTO `sys_env_config` VALUES
(9,'systemInfoConfig','{\"webBaseUrl\": \"tduck.cynasck.asia\", \"openWxMpLogin\": false, \"allowThirdPartyLogin\": false, \"thirdPartyLoginTypeList\": []}','2024-09-09 16:14:16','2023-04-06 21:19:21'),
(14,'fileEnvConfig','{\"ossType\": \"LOCAL\"}','2023-03-26 14:34:38','2023-04-04 22:48:43'),
(27,'emailEnvConfig','{\"host\": \"smtp.exmail.qq.com\", \"port\": \"465\", \"password\": \"6pe9uSieuqCfD3Gt\", \"username\": \"kongchengli@cynasck.asia\"}','2024-09-09 16:13:21','2024-09-09 16:13:21');
/*!40000 ALTER TABLE `sys_env_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_config`
--

DROP TABLE IF EXISTS `webhook_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `hook_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Webhook配置名称',
  `source_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置的来源类型',
  `source_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来源Id',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Webhook的URL地址',
  `request_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Webhook请求类型，如POST、GET等',
  `enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  `other_options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '其他Webhook配置，例如请求头等。以JSON格式存储',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `source_type` (`source_type`,`source_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='Webhook配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_config`
--

LOCK TABLES `webhook_config` WRITE;
/*!40000 ALTER TABLE `webhook_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_event`
--

DROP TABLE IF EXISTS `webhook_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_event` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `webhook_config_id` bigint NOT NULL COMMENT '关联的Webhook配置ID',
  `source_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来源的数据Id',
  `event_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Webhook事件类型',
  `event_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Webhook事件数据',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Webhook事件状态，如pending、success、failed等',
  `retry_times` int NOT NULL DEFAULT '0' COMMENT 'Webhook事件重试次数',
  `last_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Webhook事件最后一次错误信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='Webhook事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_event`
--

LOCK TABLES `webhook_event` WRITE;
/*!40000 ALTER TABLE `webhook_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wx_mp_user`
--

DROP TABLE IF EXISTS `wx_mp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wx_mp_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `appid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公众号AppId',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '昵称',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别',
  `head_img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
  `union_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `open_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '国家',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '城市',
  `is_subscribe` tinyint(1) DEFAULT '1' COMMENT '是否关注',
  `user_id` bigint DEFAULT NULL COMMENT '用户Id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `wx_union_id` (`head_img_url`(191)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15651 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='微信公众号用户 ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wx_mp_user`
--

LOCK TABLES `wx_mp_user` WRITE;
/*!40000 ALTER TABLE `wx_mp_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `wx_mp_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tduck'
--

--
-- Dumping routines for database 'tduck'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-24 23:01:59
