/*
Navicat MySQL Data Transfer

Source Server         : local mysql
Source Server Version : 50156
Source Host           : localhost:3306
Source Database       : VoterMatters

Target Server Type    : MYSQL
Target Server Version : 50156
File Encoding         : 65001

Date: 2011-07-12 16:17:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `groups`
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `user_name` char(50) NOT NULL DEFAULT '',
  `user_group` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_name`,`user_group`),
  CONSTRAINT `groups_user_name` FOREIGN KEY (`user_name`) REFERENCES `users` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Authentication Group Table';

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO `groups` VALUES ('admin', 'Administrator');
