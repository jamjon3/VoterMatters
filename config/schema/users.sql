/*
Navicat MySQL Data Transfer

Source Server         : local mysql
Source Server Version : 50156
Source Host           : localhost:3306
Source Database       : VoterMatters

Target Server Type    : MYSQL
Target Server Version : 50156
File Encoding         : 65001

Date: 2011-07-12 16:17:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `user_passwd` varchar(20) NOT NULL DEFAULT '',
  `user_passwd_md5` varchar(32) NOT NULL,
  `RegisteredEmail` text,
  `AlternateEmail` text,
  `last_updated` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `MiddleName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Authentication User Table';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('admin', '', '', null, null, null, null, null, null, null);
