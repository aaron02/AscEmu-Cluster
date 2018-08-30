/*
Navicat MySQL Data Transfer

Source Server         : localhost_3308
Source Server Version : 50045
Source Host           : localhost:3308
Source Database       : char

Target Server Type    : MYSQL
Target Server Version : 50045
File Encoding         : 65001

Date: 2018-08-31 00:50:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account_data`
-- ----------------------------
DROP TABLE IF EXISTS `account_data`;
CREATE TABLE `account_data` (
  `acct` int(30) NOT NULL,
  `uiconfig0` blob,
  `uiconfig1` blob,
  `uiconfig2` blob,
  `uiconfig3` blob,
  `uiconfig4` blob,
  `uiconfig5` blob,
  `uiconfig6` blob,
  `uiconfig7` blob,
  `uiconfig8` blob,
  PRIMARY KEY  (`acct`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of account_data
-- ----------------------------

-- ----------------------------
-- Table structure for `account_forced_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `account_forced_permissions`;
CREATE TABLE `account_forced_permissions` (
  `login` varchar(50) NOT NULL,
  `permissions` varchar(100) NOT NULL,
  PRIMARY KEY  (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of account_forced_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `arenateams`
-- ----------------------------
DROP TABLE IF EXISTS `arenateams`;
CREATE TABLE `arenateams` (
  `id` int(30) NOT NULL,
  `type` int(30) NOT NULL,
  `leader` int(30) NOT NULL,
  `name` varchar(150) NOT NULL,
  `emblemstyle` int(40) NOT NULL,
  `emblemcolour` bigint(40) NOT NULL,
  `borderstyle` int(40) NOT NULL,
  `bordercolour` bigint(40) NOT NULL,
  `backgroundcolour` bigint(40) NOT NULL,
  `rating` int(30) NOT NULL,
  `data` varchar(150) NOT NULL,
  `ranking` int(30) NOT NULL,
  `player_data1` varchar(60) NOT NULL,
  `player_data2` varchar(60) NOT NULL,
  `player_data3` varchar(60) NOT NULL,
  `player_data4` varchar(60) NOT NULL,
  `player_data5` varchar(60) NOT NULL,
  `player_data6` varchar(60) NOT NULL,
  `player_data7` varchar(60) NOT NULL,
  `player_data8` varchar(60) NOT NULL,
  `player_data9` varchar(60) NOT NULL,
  `player_data10` varchar(60) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of arenateams
-- ----------------------------

-- ----------------------------
-- Table structure for `auctions`
-- ----------------------------
DROP TABLE IF EXISTS `auctions`;
CREATE TABLE `auctions` (
  `auctionId` int(32) NOT NULL auto_increment,
  `auctionhouse` int(32) default NULL,
  `item` bigint(10) default NULL,
  `owner` bigint(10) default NULL,
  `startbid` int(32) default NULL,
  `buyout` int(32) default NULL,
  `time` int(32) default NULL,
  `bidder` bigint(10) default NULL,
  `bid` int(32) default NULL,
  `deposit` int(32) default NULL,
  PRIMARY KEY  (`auctionId`),
  KEY `b` (`auctionhouse`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of auctions
-- ----------------------------

-- ----------------------------
-- Table structure for `banned_char_log`
-- ----------------------------
DROP TABLE IF EXISTS `banned_char_log`;
CREATE TABLE `banned_char_log` (
  `banned_by` varchar(50) NOT NULL,
  `banned_player` varchar(50) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `banned_until` int(11) NOT NULL,
  `reason` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of banned_char_log
-- ----------------------------

-- ----------------------------
-- Table structure for `banned_names`
-- ----------------------------
DROP TABLE IF EXISTS `banned_names`;
CREATE TABLE `banned_names` (
  `name` varchar(30) collate utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of banned_names
-- ----------------------------

-- ----------------------------
-- Table structure for `calendar_events`
-- ----------------------------
DROP TABLE IF EXISTS `calendar_events`;
CREATE TABLE `calendar_events` (
  `entry` int(10) unsigned NOT NULL default '0',
  `creator` int(10) unsigned NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `type` tinyint(1) unsigned NOT NULL default '4',
  `dungeon` int(10) NOT NULL default '-1',
  `date` int(10) unsigned NOT NULL default '0',
  `flags` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of calendar_events
-- ----------------------------

-- ----------------------------
-- Table structure for `calendar_invites`
-- ----------------------------
DROP TABLE IF EXISTS `calendar_invites`;
CREATE TABLE `calendar_invites` (
  `id` bigint(20) unsigned NOT NULL default '0',
  `event` bigint(20) unsigned NOT NULL default '0',
  `invitee` int(10) unsigned NOT NULL default '0',
  `sender` int(10) unsigned NOT NULL default '0',
  `status` tinyint(1) unsigned NOT NULL default '0',
  `statustime` int(10) unsigned NOT NULL default '0',
  `rank` tinyint(1) unsigned NOT NULL default '0',
  `text` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of calendar_invites
-- ----------------------------

-- ----------------------------
-- Table structure for `characters`
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `guid` int(6) unsigned NOT NULL default '0',
  `acct` int(20) unsigned NOT NULL default '0',
  `name` varchar(21) NOT NULL default '',
  `race` smallint(3) NOT NULL,
  `class` smallint(3) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `custom_faction` int(30) NOT NULL default '0',
  `level` int(3) NOT NULL,
  `xp` int(30) NOT NULL,
  `active_cheats` int(10) unsigned NOT NULL default '0',
  `exploration_data` longtext NOT NULL,
  `watched_faction_index` bigint(40) NOT NULL,
  `selected_pvp_title` int(30) NOT NULL,
  `available_pvp_titles` bigint(10) unsigned NOT NULL default '0',
  `available_pvp_titles1` bigint(10) NOT NULL,
  `available_pvp_titles2` bigint(10) unsigned NOT NULL default '0',
  `gold` int(30) NOT NULL,
  `ammo_id` int(30) NOT NULL,
  `available_prof_points` int(30) NOT NULL,
  `current_hp` int(30) NOT NULL,
  `current_power` int(30) NOT NULL,
  `pvprank` int(30) NOT NULL,
  `bytes` int(30) NOT NULL,
  `bytes2` int(30) NOT NULL,
  `player_flags` int(30) NOT NULL,
  `player_bytes` int(30) NOT NULL,
  `positionX` float NOT NULL default '0',
  `positionY` float NOT NULL default '0',
  `positionZ` float NOT NULL default '0',
  `orientation` float NOT NULL default '0',
  `mapId` int(8) unsigned NOT NULL default '0',
  `zoneId` int(8) unsigned NOT NULL default '0',
  `taximask` longtext NOT NULL,
  `banned` int(40) unsigned NOT NULL default '0',
  `banReason` varchar(255) NOT NULL,
  `timestamp` int(30) default NULL,
  `online` int(11) default NULL,
  `bindpositionX` float NOT NULL default '0',
  `bindpositionY` float NOT NULL default '0',
  `bindpositionZ` float NOT NULL default '0',
  `bindmapId` int(8) unsigned NOT NULL default '0',
  `bindzoneId` int(8) unsigned NOT NULL default '0',
  `isResting` int(3) NOT NULL default '0',
  `restState` int(5) NOT NULL default '0',
  `restTime` int(5) NOT NULL default '0',
  `playedtime` text NOT NULL,
  `deathstate` int(5) NOT NULL default '0',
  `TalentResetTimes` int(5) NOT NULL default '0',
  `first_login` tinyint(1) NOT NULL default '0',
  `login_flags` int(10) unsigned NOT NULL default '0',
  `arenaPoints` int(10) NOT NULL,
  `totalstableslots` int(10) unsigned NOT NULL default '0',
  `instance_id` int(10) NOT NULL,
  `entrypointmap` int(10) NOT NULL,
  `entrypointx` float NOT NULL,
  `entrypointy` float NOT NULL,
  `entrypointz` float NOT NULL,
  `entrypointo` float NOT NULL,
  `entrypointinstance` int(10) NOT NULL,
  `taxi_path` int(10) NOT NULL,
  `taxi_lastnode` int(10) NOT NULL,
  `taxi_mountid` int(10) NOT NULL,
  `transporter` int(10) NOT NULL,
  `transporter_xdiff` float NOT NULL,
  `transporter_ydiff` float NOT NULL,
  `transporter_zdiff` float NOT NULL,
  `transporter_odiff` float NOT NULL,
  `actions1` longtext NOT NULL,
  `actions2` longtext NOT NULL,
  `auras` longtext NOT NULL,
  `finished_quests` longtext NOT NULL,
  `finisheddailies` longtext NOT NULL,
  `honorRolloverTime` int(30) NOT NULL default '0',
  `killsToday` int(10) NOT NULL default '0',
  `killsYesterday` int(10) NOT NULL default '0',
  `killsLifeTime` int(10) NOT NULL default '0',
  `honorToday` int(10) NOT NULL default '0',
  `honorYesterday` int(10) NOT NULL default '0',
  `honorPoints` int(10) NOT NULL default '0',
  `drunkValue` int(30) NOT NULL default '0',
  `glyphs1` longtext NOT NULL,
  `talents1` longtext NOT NULL,
  `glyphs2` longtext NOT NULL,
  `talents2` longtext NOT NULL,
  `numspecs` int(10) NOT NULL default '1',
  `currentspec` int(10) NOT NULL default '0',
  `talentpoints` longtext NOT NULL,
  `firsttalenttree` int(11) default NULL,
  `phase` int(10) unsigned NOT NULL default '1',
  `CanGainXp` int(10) unsigned NOT NULL default '1',
  `data` longtext,
  `resettalents` int(10) unsigned NOT NULL default '0',
  `rbg_daily` tinyint(1) NOT NULL default '0' COMMENT 'Boolean already done a daily rbg?',
  `dungeon_difficulty` smallint(1) unsigned NOT NULL default '0',
  `raid_difficulty` smallint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`guid`),
  KEY `acct` (`acct`),
  KEY `name` (`name`),
  KEY `b` (`banned`),
  KEY `c` (`online`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of characters
-- ----------------------------
INSERT INTO `characters` VALUES ('1', '1', 'awd', '1', '1', '0', '0', '1', '0', '0', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '', '', '1', '0', '', null, '1', '1', null, '0', '0', '0', '0');
INSERT INTO `characters` VALUES ('6', '1', 'Hexi', '2', '9', '0', '0', '1', '0', '0', '0,0,33554432,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '4008636142', '0', '0', '0', '0', '0', '0', '2', '63', '108', '0', '117834760', '16777469', '0', '8', '-618.5', '-4251.65', '38.72', '0', '0', '14', '4194304 0 0 0 0 0 0 0 0 0 0 0 ', '0', '', '1493029788', '0', '-618.51', '-4251.66', '38.71', '1', '14', '0', '1', '600', '0 0 0 ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '6603,0,0,686,0,0,687,0,0,28730,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59752,0,0,0,0,0,20857,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '', '', '', '7667825', '0', '0', '0', '0', '0', '0', '0', '0,0,0,0,0,0,', '', '0,0,0,0,0,0,', '', '1', '0', '0 0', null, '1', '1', '', '0', '0', '0', '0');
INSERT INTO `characters` VALUES ('2', '1', 'Kim', '1', '4', '1', '0', '80', '100', '0', '8388608,0,0,1610612736,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,65536,12,0,0,0,65536,0,0,2147483648,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '4008636142', '0', '0', '0', '0', '0', '0', '2', '7323', '0', '0', '118620422', '33554685', '32', '8', '-8852.36', '601.658', '92.1041', '0.879253', '0', '1519', '2 0 0 0 0 0 0 0 0 0 0 0 ', '0', '', '1535624133', '0', '-8946.42', '-131.35', '83.63', '0', '12', '1', '2', '9', '0 0 0 ', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '6603,0,0,1752,0,0,2098,0,0,2764,0,0,25046,0,0,2481,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59752,0,0,20857,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,26297,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,58984,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '', '', '', '7733489', '0', '0', '0', '0', '0', '0', '0', '0,0,0,0,0,0,', '', '0,0,0,0,0,0,', '', '1', '0', '71 71', '0', '1', '1', '', '0', '0', '0', '0');
INSERT INTO `characters` VALUES ('3', '1', 'Heisou', '1', '4', '0', '0', '80', '0', '0', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65536,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '4008636142', '0', '0', '0', '0', '0', '0', '2', '7451', '0', '0', '396037', '33554685', '32', '8', '-8873', '585.745', '92.7746', '3.82882', '0', '1519', '2 0 0 0 0 0 0 0 0 0 0 0 ', '0', '', '1535533520', '0', '-8946.42', '-131.35', '83.63', '0', '12', '1', '2', '74', '0 0 0 ', '0', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '6603,0,0,1752,0,0,2098,0,0,2764,0,0,25046,0,0,2481,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59752,0,0,20857,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,26297,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,58984,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '', '', '', '7733488', '0', '0', '0', '0', '0', '0', '0', '0,0,0,0,0,0,', '', '0,0,0,0,0,0,', '', '1', '0', '71 71', '0', '1', '1', '', '0', '0', '0', '0');
INSERT INTO `characters` VALUES ('4', '1', 'Rahel', '1', '1', '1', '35', '80', '0', '0', '0,0,0,536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,65536,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '4008636142', '0', '0', '0', '0', '0', '0', '2', '8139', '0', '0', '118620422', '33554685', '32', '8', '-8912.48', '554.633', '93.76', '0', '0', '1519', '2 0 0 0 0 0 0 0 0 0 0 0 ', '0', '', '1495743997', '0', '-8946.42', '-131.35', '83.63', '0', '12', '1', '2', '74', '0 0 0 ', '0', '0', '0', '0', '0', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '6603,0,0,78,0,0,26297,0,0,2481,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59752,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6603,0,0,78,0,0,28880,0,0,26297,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59752,0,0,4604,128,0,6603,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6603,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6603,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '2457,4294967295,1,0,', '', '', '7667856', '0', '0', '0', '0', '0', '0', '0', '0,0,0,0,0,0,', '', '0,0,0,0,0,0,', '', '1', '0', '71 71', '0', '1', '1', '', '0', '0', '0', '0');
INSERT INTO `characters` VALUES ('5', '2', 'Sfd', '1', '1', '1', '0', '80', '40', '0', '0,0,16777216,1610612736,262144,4194304,0,0,0,0,0,0,0,0,0,0,0,49152,1073741824,0,0,66048,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,268435456,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '4008636142', '0', '0', '0', '0', '1410042408', '0', '2', '8139', '0', '0', '118620422', '33554685', '262144', '8', '5797.79', '629.402', '647.406', '0.683325', '571', '2817', '2 0 0 0 0 0 0 0 0 0 0 0 ', '0', '', '1535624136', '1', '-8946.42', '-131.35', '83.63', '0', '12', '0', '2', '600', '0 0 0 ', '0', '0', '0', '0', '0', '0', '5', '0', '-8762.38', '848.01', '89.8765', '0.683325', '1', '0', '0', '0', '0', '0', '0', '0', '0', '6603,0,0,78,0,0,26297,0,0,2481,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59752,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6603,0,0,78,0,0,28880,0,0,26297,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59752,0,0,6603,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6603,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6603,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '2457,4294967295,1,0,', '783,', '', '7733489', '0', '0', '0', '0', '0', '0', '0', '0,0,0,0,0,0,', '', '0,0,0,0,0,0,', '', '1', '0', '71 71', '0', '1', '1', '', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `character_achievement`
-- ----------------------------
DROP TABLE IF EXISTS `character_achievement`;
CREATE TABLE `character_achievement` (
  `guid` int(10) unsigned NOT NULL default '0',
  `achievement` int(10) unsigned NOT NULL default '0',
  `date` int(10) unsigned default NULL,
  PRIMARY KEY  (`guid`,`achievement`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of character_achievement
-- ----------------------------
INSERT INTO `character_achievement` VALUES ('2', '6', '1492966812');
INSERT INTO `character_achievement` VALUES ('2', '7', '1492966812');
INSERT INTO `character_achievement` VALUES ('2', '8', '1492966812');
INSERT INTO `character_achievement` VALUES ('2', '13', '1492966813');
INSERT INTO `character_achievement` VALUES ('2', '10', '1492966812');
INSERT INTO `character_achievement` VALUES ('2', '11', '1492966812');
INSERT INTO `character_achievement` VALUES ('2', '12', '1492966812');
INSERT INTO `character_achievement` VALUES ('2', '457', '1492966813');
INSERT INTO `character_achievement` VALUES ('2', '9', '1492966812');
INSERT INTO `character_achievement` VALUES ('2', '458', '1492966813');
INSERT INTO `character_achievement` VALUES ('2', '1408', '1492966813');
INSERT INTO `character_achievement` VALUES ('2', '2716', '1492966813');
INSERT INTO `character_achievement` VALUES ('3', '6', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '7', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '8', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '457', '1493057626');
INSERT INTO `character_achievement` VALUES ('3', '10', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '11', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '12', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '9', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '13', '1493057625');
INSERT INTO `character_achievement` VALUES ('3', '458', '1493057626');
INSERT INTO `character_achievement` VALUES ('3', '1408', '1493057626');
INSERT INTO `character_achievement` VALUES ('3', '2716', '1493057626');
INSERT INTO `character_achievement` VALUES ('4', '2716', '1493060028');
INSERT INTO `character_achievement` VALUES ('4', '1408', '1493060028');
INSERT INTO `character_achievement` VALUES ('4', '459', '1493060028');
INSERT INTO `character_achievement` VALUES ('4', '13', '1493060027');
INSERT INTO `character_achievement` VALUES ('4', '12', '1493060027');
INSERT INTO `character_achievement` VALUES ('4', '11', '1493060027');
INSERT INTO `character_achievement` VALUES ('4', '10', '1493060027');
INSERT INTO `character_achievement` VALUES ('4', '457', '1493060028');
INSERT INTO `character_achievement` VALUES ('4', '9', '1493060027');
INSERT INTO `character_achievement` VALUES ('4', '8', '1493060027');
INSERT INTO `character_achievement` VALUES ('4', '7', '1493060027');
INSERT INTO `character_achievement` VALUES ('4', '6', '1493060027');
INSERT INTO `character_achievement` VALUES ('5', '6', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '7', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '8', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '9', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '10', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '11', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '12', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '13', '1493919696');
INSERT INTO `character_achievement` VALUES ('5', '457', '1493919697');
INSERT INTO `character_achievement` VALUES ('5', '459', '1493919697');
INSERT INTO `character_achievement` VALUES ('5', '1408', '1493919697');
INSERT INTO `character_achievement` VALUES ('5', '2716', '1493919697');
INSERT INTO `character_achievement` VALUES ('7', '6', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '7', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '8', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '9', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '457', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '10', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '11', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '12', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '13', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '458', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '1408', '1535533973');
INSERT INTO `character_achievement` VALUES ('7', '2716', '1535533973');

-- ----------------------------
-- Table structure for `character_achievement_progress`
-- ----------------------------
DROP TABLE IF EXISTS `character_achievement_progress`;
CREATE TABLE `character_achievement_progress` (
  `guid` int(10) unsigned NOT NULL default '0',
  `criteria` int(10) unsigned NOT NULL default '0',
  `counter` int(10) default NULL,
  `date` int(10) unsigned default NULL,
  PRIMARY KEY  (`guid`,`criteria`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of character_achievement_progress
-- ----------------------------
INSERT INTO `character_achievement_progress` VALUES ('5', '5529', '1', '1493920973');
INSERT INTO `character_achievement_progress` VALUES ('5', '5530', '1', '1493920973');
INSERT INTO `character_achievement_progress` VALUES ('7', '5529', '1', '1535533814');
INSERT INTO `character_achievement_progress` VALUES ('7', '5512', '1', '1535533814');
INSERT INTO `character_achievement_progress` VALUES ('7', '13305', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13303', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13301', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13300', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13299', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13298', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13297', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13294', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13292', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13291', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13290', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13288', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13287', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13286', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13284', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13283', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13281', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13280', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13279', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13278', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13277', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13276', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13275', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13274', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13273', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13272', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13271', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13270', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13269', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13268', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13266', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13265', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13264', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13263', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13262', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '12038', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11032', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11029', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11028', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11027', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11025', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11023', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11021', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11020', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11019', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11018', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11017', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11015', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11014', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11013', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11010', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11009', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11008', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13304', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11007', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11024', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11006', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13293', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11005', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11030', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11004', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11002', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11001', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11026', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11000', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13295', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7848', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7847', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7846', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7845', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7844', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7843', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7842', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7841', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7840', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7839', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11003', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7838', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7836', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7835', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7834', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7833', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7832', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7831', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7829', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7828', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7827', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7826', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7825', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7824', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7823', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7822', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7820', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7819', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7818', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7817', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11022', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7816', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7815', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11012', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7813', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7812', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7811', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7810', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7809', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7807', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7802', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7801', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7800', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11011', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7799', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7798', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7797', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7796', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11031', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7795', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '10999', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '11016', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7791', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7790', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7789', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7786', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7785', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7784', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7783', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7782', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7781', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7780', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7779', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7775', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7774', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7772', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7771', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7770', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13285', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7765', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7763', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7761', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7760', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13267', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '4962', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7777', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7776', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7764', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7830', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7766', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13289', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7837', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7773', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13282', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7808', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '4963', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '5593', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7778', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7787', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7814', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '455', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7792', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7762', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13302', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7788', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '13296', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7758', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7803', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7821', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '111', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '4964', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7759', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '4965', '2', '1535533739');
INSERT INTO `character_achievement_progress` VALUES ('7', '7804', '2', '1535533739');

-- ----------------------------
-- Table structure for `character_db_version`
-- ----------------------------
DROP TABLE IF EXISTS `character_db_version`;
CREATE TABLE `character_db_version` (
  `LastUpdate` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`LastUpdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of character_db_version
-- ----------------------------
INSERT INTO `character_db_version` VALUES ('2017-04-22_01_banned_char_log');

-- ----------------------------
-- Table structure for `charters`
-- ----------------------------
DROP TABLE IF EXISTS `charters`;
CREATE TABLE `charters` (
  `charterId` int(30) NOT NULL,
  `charterType` int(30) NOT NULL default '0',
  `leaderGuid` int(20) unsigned NOT NULL default '0',
  `guildName` varchar(32) NOT NULL default '',
  `itemGuid` bigint(40) unsigned NOT NULL default '0',
  `signer1` int(10) unsigned NOT NULL default '0',
  `signer2` int(10) unsigned NOT NULL default '0',
  `signer3` int(10) unsigned NOT NULL default '0',
  `signer4` int(10) unsigned NOT NULL default '0',
  `signer5` int(10) unsigned NOT NULL default '0',
  `signer6` int(10) unsigned NOT NULL default '0',
  `signer7` int(10) unsigned NOT NULL default '0',
  `signer8` int(10) unsigned NOT NULL default '0',
  `signer9` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`charterId`),
  UNIQUE KEY `leaderGuid` (`charterType`,`leaderGuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of charters
-- ----------------------------

-- ----------------------------
-- Table structure for `clientaddons`
-- ----------------------------
DROP TABLE IF EXISTS `clientaddons`;
CREATE TABLE `clientaddons` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `crc` bigint(50) default NULL,
  `banned` int(1) NOT NULL default '0',
  `showinlist` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `index` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of clientaddons
-- ----------------------------

-- ----------------------------
-- Table structure for `command_overrides`
-- ----------------------------
DROP TABLE IF EXISTS `command_overrides`;
CREATE TABLE `command_overrides` (
  `command_name` varchar(100) NOT NULL,
  `access_level` varchar(10) NOT NULL,
  PRIMARY KEY  (`command_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of command_overrides
-- ----------------------------

-- ----------------------------
-- Table structure for `corpses`
-- ----------------------------
DROP TABLE IF EXISTS `corpses`;
CREATE TABLE `corpses` (
  `guid` bigint(20) unsigned NOT NULL default '0',
  `positionX` float NOT NULL default '0',
  `positionY` float NOT NULL default '0',
  `positionZ` float NOT NULL default '0',
  `orientation` float NOT NULL default '0',
  `zoneId` int(11) NOT NULL default '38',
  `mapId` int(11) NOT NULL default '0',
  `instanceId` int(11) NOT NULL default '0',
  `data` longtext NOT NULL,
  PRIMARY KEY  (`guid`),
  KEY `b` (`instanceId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of corpses
-- ----------------------------

-- ----------------------------
-- Table structure for `equipmentsets`
-- ----------------------------
DROP TABLE IF EXISTS `equipmentsets`;
CREATE TABLE `equipmentsets` (
  `ownerguid` int(10) unsigned NOT NULL default '1',
  `setGUID` int(10) unsigned NOT NULL default '1',
  `setid` int(10) unsigned NOT NULL default '1',
  `setname` varchar(16) NOT NULL default '',
  `iconname` varchar(100) NOT NULL default '',
  `head` int(10) unsigned NOT NULL default '0',
  `neck` int(10) unsigned NOT NULL default '0',
  `shoulders` int(10) unsigned NOT NULL default '0',
  `body` int(10) unsigned NOT NULL default '0',
  `chest` int(10) unsigned NOT NULL default '0',
  `waist` int(10) unsigned NOT NULL default '0',
  `legs` int(10) unsigned NOT NULL default '0',
  `feet` int(10) unsigned NOT NULL default '0',
  `wrists` int(10) unsigned NOT NULL default '0',
  `hands` int(10) unsigned NOT NULL default '0',
  `finger1` int(10) unsigned NOT NULL default '0',
  `finger2` int(10) unsigned NOT NULL default '0',
  `trinket1` int(10) unsigned NOT NULL default '0',
  `trinket2` int(10) unsigned NOT NULL default '0',
  `back` int(10) unsigned NOT NULL default '0',
  `mainhand` int(10) unsigned NOT NULL default '0',
  `offhand` int(10) unsigned NOT NULL default '0',
  `ranged` int(10) unsigned NOT NULL default '0',
  `tabard` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ownerguid`,`setGUID`,`setid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of equipmentsets
-- ----------------------------

-- ----------------------------
-- Table structure for `event_save`
-- ----------------------------
DROP TABLE IF EXISTS `event_save`;
CREATE TABLE `event_save` (
  `event_entry` int(3) unsigned NOT NULL,
  `state` tinyint(3) unsigned NOT NULL default '0',
  `next_start` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`event_entry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of event_save
-- ----------------------------
INSERT INTO `event_save` VALUES ('60', '4', '0');
INSERT INTO `event_save` VALUES ('44', '1', '0');
INSERT INTO `event_save` VALUES ('29', '1', '0');
INSERT INTO `event_save` VALUES ('16', '1', '0');
INSERT INTO `event_save` VALUES ('4', '1', '0');
INSERT INTO `event_save` VALUES ('59', '3', '0');
INSERT INTO `event_save` VALUES ('58', '3', '0');
INSERT INTO `event_save` VALUES ('57', '3', '0');

-- ----------------------------
-- Table structure for `gm_survey`
-- ----------------------------
DROP TABLE IF EXISTS `gm_survey`;
CREATE TABLE `gm_survey` (
  `survey_id` int(10) unsigned NOT NULL,
  `guid` int(10) unsigned NOT NULL default '0',
  `main_survey` int(10) unsigned NOT NULL default '0',
  `comment` longtext NOT NULL,
  `create_time` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`survey_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='GM Survey';

-- ----------------------------
-- Records of gm_survey
-- ----------------------------

-- ----------------------------
-- Table structure for `gm_survey_answers`
-- ----------------------------
DROP TABLE IF EXISTS `gm_survey_answers`;
CREATE TABLE `gm_survey_answers` (
  `survey_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL default '0',
  `answer_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`survey_id`,`question_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='GM Survey';

-- ----------------------------
-- Records of gm_survey_answers
-- ----------------------------

-- ----------------------------
-- Table structure for `gm_tickets`
-- ----------------------------
DROP TABLE IF EXISTS `gm_tickets`;
CREATE TABLE `gm_tickets` (
  `ticketid` int(11) NOT NULL,
  `playerGuid` int(11) NOT NULL,
  `name` varchar(200) NOT NULL default '',
  `level` int(6) NOT NULL default '0',
  `map` int(11) NOT NULL default '0',
  `posX` float NOT NULL default '0',
  `posY` float NOT NULL default '0',
  `posZ` float NOT NULL default '0',
  `message` text NOT NULL,
  `timestamp` text,
  `deleted` int(10) unsigned NOT NULL default '0',
  `assignedto` int(11) NOT NULL default '0',
  `comment` text NOT NULL,
  UNIQUE KEY `guid` (`ticketid`),
  UNIQUE KEY `guid_2` (`ticketid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of gm_tickets
-- ----------------------------

-- ----------------------------
-- Table structure for `groups`
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `group_id` int(30) NOT NULL,
  `group_type` tinyint(2) NOT NULL,
  `subgroup_count` tinyint(2) NOT NULL,
  `loot_method` tinyint(2) NOT NULL,
  `loot_threshold` tinyint(2) NOT NULL,
  `difficulty` int(30) NOT NULL default '0',
  `raiddifficulty` int(30) NOT NULL default '0',
  `assistant_leader` int(30) NOT NULL default '0',
  `main_tank` int(30) NOT NULL default '0',
  `main_assist` int(30) NOT NULL default '0',
  `group1member1` int(50) NOT NULL,
  `group1member2` int(50) NOT NULL,
  `group1member3` int(50) NOT NULL,
  `group1member4` int(50) NOT NULL,
  `group1member5` int(50) NOT NULL,
  `group2member1` int(50) NOT NULL,
  `group2member2` int(50) NOT NULL,
  `group2member3` int(50) NOT NULL,
  `group2member4` int(50) NOT NULL,
  `group2member5` int(50) NOT NULL,
  `group3member1` int(50) NOT NULL,
  `group3member2` int(50) NOT NULL,
  `group3member3` int(50) NOT NULL,
  `group3member4` int(50) NOT NULL,
  `group3member5` int(50) NOT NULL,
  `group4member1` int(50) NOT NULL,
  `group4member2` int(50) NOT NULL,
  `group4member3` int(50) NOT NULL,
  `group4member4` int(50) NOT NULL,
  `group4member5` int(50) NOT NULL,
  `group5member1` int(50) NOT NULL,
  `group5member2` int(50) NOT NULL,
  `group5member3` int(50) NOT NULL,
  `group5member4` int(50) NOT NULL,
  `group5member5` int(50) NOT NULL,
  `group6member1` int(50) NOT NULL,
  `group6member2` int(50) NOT NULL,
  `group6member3` int(50) NOT NULL,
  `group6member4` int(50) NOT NULL,
  `group6member5` int(50) NOT NULL,
  `group7member1` int(50) NOT NULL,
  `group7member2` int(50) NOT NULL,
  `group7member3` int(50) NOT NULL,
  `group7member4` int(50) NOT NULL,
  `group7member5` int(50) NOT NULL,
  `group8member1` int(50) NOT NULL,
  `group8member2` int(50) NOT NULL,
  `group8member3` int(50) NOT NULL,
  `group8member4` int(50) NOT NULL,
  `group8member5` int(50) NOT NULL,
  `timestamp` int(30) NOT NULL,
  `instanceids` text NOT NULL,
  PRIMARY KEY  (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of groups
-- ----------------------------

-- ----------------------------
-- Table structure for `guilds`
-- ----------------------------
DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds` (
  `guildId` bigint(20) NOT NULL auto_increment,
  `guildName` varchar(32) NOT NULL default '',
  `leaderGuid` bigint(20) NOT NULL default '0',
  `emblemStyle` int(10) NOT NULL default '0',
  `emblemColor` int(10) NOT NULL default '0',
  `borderStyle` int(10) NOT NULL default '0',
  `borderColor` int(10) NOT NULL default '0',
  `backgroundColor` int(10) NOT NULL default '0',
  `guildInfo` varchar(300) NOT NULL default '',
  `motd` varchar(300) NOT NULL default '',
  `createdate` int(30) NOT NULL,
  `bankBalance` bigint(30) unsigned NOT NULL,
  PRIMARY KEY  (`guildId`),
  UNIQUE KEY `guildId` (`guildId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of guilds
-- ----------------------------

-- ----------------------------
-- Table structure for `guild_bankitems`
-- ----------------------------
DROP TABLE IF EXISTS `guild_bankitems`;
CREATE TABLE `guild_bankitems` (
  `guildId` int(30) NOT NULL,
  `tabId` int(30) NOT NULL,
  `slotId` int(30) NOT NULL,
  `itemGuid` int(30) NOT NULL,
  PRIMARY KEY  (`guildId`,`tabId`,`slotId`),
  KEY `a` (`guildId`),
  KEY `b` (`tabId`),
  KEY `c` (`slotId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of guild_bankitems
-- ----------------------------

-- ----------------------------
-- Table structure for `guild_banklogs`
-- ----------------------------
DROP TABLE IF EXISTS `guild_banklogs`;
CREATE TABLE `guild_banklogs` (
  `log_id` int(30) NOT NULL,
  `guildid` int(30) NOT NULL,
  `tabid` int(30) NOT NULL COMMENT 'tab 6 is money logs',
  `action` int(5) NOT NULL,
  `player_guid` int(30) NOT NULL,
  `item_entry` int(30) NOT NULL,
  `stack_count` int(30) NOT NULL,
  `timestamp` int(30) NOT NULL,
  PRIMARY KEY  (`log_id`,`guildid`),
  KEY `a` (`guildid`),
  KEY `b` (`tabid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of guild_banklogs
-- ----------------------------

-- ----------------------------
-- Table structure for `guild_banktabs`
-- ----------------------------
DROP TABLE IF EXISTS `guild_banktabs`;
CREATE TABLE `guild_banktabs` (
  `guildId` int(30) NOT NULL,
  `tabId` int(30) NOT NULL,
  `tabName` varchar(200) NOT NULL,
  `tabIcon` varchar(200) NOT NULL,
  `tabInfo` varchar(200) NOT NULL,
  PRIMARY KEY  (`guildId`,`tabId`),
  KEY `a` (`guildId`),
  KEY `b` (`tabId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of guild_banktabs
-- ----------------------------

-- ----------------------------
-- Table structure for `guild_data`
-- ----------------------------
DROP TABLE IF EXISTS `guild_data`;
CREATE TABLE `guild_data` (
  `guildid` int(30) NOT NULL,
  `playerid` int(30) NOT NULL,
  `guildRank` int(30) NOT NULL,
  `publicNote` varchar(300) NOT NULL,
  `officerNote` varchar(300) NOT NULL,
  `lastWithdrawReset` int(30) NOT NULL default '0',
  `withdrawlsSinceLastReset` int(30) NOT NULL default '0',
  `lastItemWithdrawReset0` int(30) NOT NULL default '0',
  `itemWithdrawlsSinceLastReset0` int(30) NOT NULL default '0',
  `lastItemWithdrawReset1` int(30) NOT NULL,
  `itemWithdrawlsSinceLastReset1` int(30) NOT NULL,
  `lastItemWithdrawReset2` int(30) NOT NULL,
  `itemWithdrawlsSinceLastReset2` int(30) NOT NULL,
  `lastItemWithdrawReset3` int(30) NOT NULL,
  `itemWithdrawlsSinceLastReset3` int(30) NOT NULL,
  `lastItemWithdrawReset4` int(30) NOT NULL,
  `itemWithdrawlsSinceLastReset4` int(30) NOT NULL,
  `lastItemWithdrawReset5` int(30) NOT NULL,
  `itemWithdrawlsSinceLastReset5` int(30) NOT NULL,
  KEY `a` (`guildid`),
  KEY `b` (`playerid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of guild_data
-- ----------------------------

-- ----------------------------
-- Table structure for `guild_logs`
-- ----------------------------
DROP TABLE IF EXISTS `guild_logs`;
CREATE TABLE `guild_logs` (
  `log_id` int(30) NOT NULL,
  `guildid` int(30) NOT NULL,
  `timestamp` int(30) NOT NULL,
  `event_type` int(30) NOT NULL,
  `misc1` int(30) NOT NULL,
  `misc2` int(30) NOT NULL,
  `misc3` int(30) NOT NULL,
  PRIMARY KEY  (`log_id`,`guildid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of guild_logs
-- ----------------------------

-- ----------------------------
-- Table structure for `guild_ranks`
-- ----------------------------
DROP TABLE IF EXISTS `guild_ranks`;
CREATE TABLE `guild_ranks` (
  `guildId` int(6) unsigned NOT NULL default '0',
  `rankId` int(1) NOT NULL default '0',
  `rankName` varchar(255) NOT NULL default '',
  `rankRights` int(3) unsigned NOT NULL default '0',
  `goldLimitPerDay` int(30) NOT NULL default '0',
  `bankTabFlags0` int(30) NOT NULL default '0',
  `itemStacksPerDay0` int(30) NOT NULL default '0',
  `bankTabFlags1` int(30) NOT NULL default '0',
  `itemStacksPerDay1` int(30) NOT NULL default '0',
  `bankTabFlags2` int(30) NOT NULL default '0',
  `itemStacksPerDay2` int(30) NOT NULL default '0',
  `bankTabFlags3` int(30) NOT NULL default '0',
  `itemStacksPerDay3` int(30) NOT NULL default '0',
  `bankTabFlags4` int(30) NOT NULL default '0',
  `itemStacksPerDay4` int(30) NOT NULL default '0',
  `bankTabFlags5` int(30) NOT NULL default '0',
  `itemStacksPerDay5` int(30) NOT NULL default '0',
  PRIMARY KEY  (`guildId`,`rankId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of guild_ranks
-- ----------------------------

-- ----------------------------
-- Table structure for `instanceids`
-- ----------------------------
DROP TABLE IF EXISTS `instanceids`;
CREATE TABLE `instanceids` (
  `playerguid` int(11) unsigned NOT NULL default '0',
  `mapid` int(11) unsigned NOT NULL default '0',
  `mode` int(11) unsigned NOT NULL default '0',
  `instanceid` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`playerguid`,`mapid`,`mode`),
  KEY `ix_instanceid` (`playerguid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Player / InstanceID - Reference Table';

-- ----------------------------
-- Records of instanceids
-- ----------------------------

-- ----------------------------
-- Table structure for `instances`
-- ----------------------------
DROP TABLE IF EXISTS `instances`;
CREATE TABLE `instances` (
  `id` int(30) NOT NULL,
  `mapid` int(30) NOT NULL,
  `creation` int(30) NOT NULL,
  `expiration` int(30) NOT NULL,
  `killed_npc_guids` text NOT NULL,
  `difficulty` int(30) NOT NULL,
  `creator_group` int(30) NOT NULL,
  `creator_guid` int(30) NOT NULL,
  `persistent` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `a` (`mapid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of instances
-- ----------------------------

-- ----------------------------
-- Table structure for `lag_reports`
-- ----------------------------
DROP TABLE IF EXISTS `lag_reports`;
CREATE TABLE `lag_reports` (
  `lag_id` int(10) unsigned NOT NULL auto_increment,
  `player` int(10) unsigned NOT NULL,
  `account` int(10) unsigned NOT NULL,
  `lag_type` smallint(2) unsigned NOT NULL,
  `map_id` int(5) unsigned default '0',
  `position_x` float default '0',
  `position_y` float default '0',
  `position_z` float default '0',
  `timestamp` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`lag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lag_reports
-- ----------------------------

-- ----------------------------
-- Table structure for `lfg_data`
-- ----------------------------
DROP TABLE IF EXISTS `lfg_data`;
CREATE TABLE `lfg_data` (
  `guid` bigint(10) NOT NULL,
  `dungeon` int(10) NOT NULL,
  `state` int(10) NOT NULL,
  PRIMARY KEY  (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of lfg_data
-- ----------------------------

-- ----------------------------
-- Table structure for `mailbox`
-- ----------------------------
DROP TABLE IF EXISTS `mailbox`;
CREATE TABLE `mailbox` (
  `message_id` int(30) NOT NULL default '0',
  `message_type` int(30) NOT NULL default '0',
  `player_guid` int(30) NOT NULL default '0',
  `sender_guid` bigint(30) unsigned NOT NULL default '0',
  `subject` varchar(255) NOT NULL default '',
  `body` longtext NOT NULL,
  `money` int(30) NOT NULL default '0',
  `attached_item_guids` varchar(200) NOT NULL default '',
  `cod` int(30) NOT NULL default '0',
  `stationary` bigint(20) unsigned default '0',
  `expiry_time` int(30) NOT NULL default '0',
  `delivery_time` int(30) NOT NULL default '0',
  `checked_flag` int(30) unsigned NOT NULL default '0',
  `deleted_flag` int(30) NOT NULL default '0',
  PRIMARY KEY  (`message_id`),
  KEY `b` (`player_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of mailbox
-- ----------------------------
INSERT INTO `mailbox` VALUES ('2', '3', '2', '16128', 'Level 80', 'Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us. \r\n\r\nAnd while the journey thus far has been no minor feat, the true battle lies ahead. \r\n\r\nFight on! \r\n\r\nRhonin', '0', '25,', '0', '0', '1495557874', '1492965874', '16', '0');
INSERT INTO `mailbox` VALUES ('4', '3', '6', '16128', 'Level 80', 'Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us. \r\n\r\nAnd while the journey thus far has been no minor feat, the true battle lies ahead. \r\n\r\nFight on! \r\n\r\nRhonin', '0', '31,', '0', '0', '1495621861', '1493029861', '16', '0');
INSERT INTO `mailbox` VALUES ('6', '3', '3', '16128', 'Level 80', 'Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us. \r\n\r\nAnd while the journey thus far has been no minor feat, the true battle lies ahead. \r\n\r\nFight on! \r\n\r\nRhonin', '0', '32,', '0', '0', '1495622851', '1493030851', '16', '0');
INSERT INTO `mailbox` VALUES ('8', '3', '3', '16128', 'Level 80', 'Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us. \r\n\r\nAnd while the journey thus far has been no minor feat, the true battle lies ahead. \r\n\r\nFight on! \r\n\r\nRhonin', '0', '33,', '0', '0', '1495649008', '1493057008', '16', '0');
INSERT INTO `mailbox` VALUES ('10', '3', '4', '16128', 'Level 80', 'Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us. \r\n\r\nAnd while the journey thus far has been no minor feat, the true battle lies ahead. \r\n\r\nFight on! \r\n\r\nRhonin', '0', '34,', '0', '0', '1495650596', '1493058596', '16', '0');
INSERT INTO `mailbox` VALUES ('12', '3', '5', '16128', 'Level 80', 'Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us. \r\n\r\nAnd while the journey thus far has been no minor feat, the true battle lies ahead. \r\n\r\nFight on! \r\n\r\nRhonin', '0', '35,', '0', '0', '1496511343', '1493919343', '16', '0');
INSERT INTO `mailbox` VALUES ('14', '3', '7', '16128', 'Level 80', 'Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us. \r\n\r\nAnd while the journey thus far has been no minor feat, the true battle lies ahead. \r\n\r\nFight on! \r\n\r\nRhonin', '0', '43,', '0', '0', '1538125550', '1535533550', '16', '0');

-- ----------------------------
-- Table structure for `playerbugreports`
-- ----------------------------
DROP TABLE IF EXISTS `playerbugreports`;
CREATE TABLE `playerbugreports` (
  `UID` int(10) unsigned NOT NULL,
  `AccountID` int(10) unsigned NOT NULL,
  `TimeStamp` int(10) unsigned NOT NULL,
  `Suggestion` int(10) unsigned NOT NULL,
  `Type` text NOT NULL,
  `Content` text NOT NULL,
  PRIMARY KEY  (`UID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of playerbugreports
-- ----------------------------

-- ----------------------------
-- Table structure for `playercooldowns`
-- ----------------------------
DROP TABLE IF EXISTS `playercooldowns`;
CREATE TABLE `playercooldowns` (
  `player_guid` int(30) NOT NULL,
  `cooldown_type` int(30) NOT NULL COMMENT '0 is spell, 1 is item, 2 is spell category',
  `cooldown_misc` int(30) NOT NULL COMMENT 'spellid/itemid/category',
  `cooldown_expire_time` int(30) NOT NULL COMMENT 'expiring time in unix epoch format',
  `cooldown_spellid` int(30) NOT NULL COMMENT 'spell that cast it',
  `cooldown_itemid` int(30) NOT NULL COMMENT 'item that cast it'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of playercooldowns
-- ----------------------------

-- ----------------------------
-- Table structure for `playerdeletedspells`
-- ----------------------------
DROP TABLE IF EXISTS `playerdeletedspells`;
CREATE TABLE `playerdeletedspells` (
  `GUID` int(10) unsigned NOT NULL,
  `SpellID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`GUID`,`SpellID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of playerdeletedspells
-- ----------------------------

-- ----------------------------
-- Table structure for `playeritems`
-- ----------------------------
DROP TABLE IF EXISTS `playeritems`;
CREATE TABLE `playeritems` (
  `ownerguid` int(10) unsigned NOT NULL default '0',
  `guid` bigint(10) NOT NULL auto_increment,
  `entry` int(10) unsigned NOT NULL default '0',
  `wrapped_item_id` int(30) NOT NULL default '0',
  `wrapped_creator` int(30) NOT NULL default '0',
  `creator` int(10) unsigned NOT NULL default '0',
  `count` int(10) unsigned NOT NULL default '0',
  `charges` int(10) NOT NULL default '0',
  `flags` int(10) unsigned NOT NULL default '0',
  `randomprop` int(10) unsigned NOT NULL default '0',
  `randomsuffix` int(10) NOT NULL,
  `itemtext` int(10) unsigned NOT NULL default '0',
  `durability` int(10) unsigned NOT NULL default '0',
  `containerslot` int(11) default '-1',
  `slot` int(10) NOT NULL default '0',
  `enchantments` longtext NOT NULL,
  `duration_expireson` int(10) unsigned NOT NULL default '0',
  `refund_purchasedon` int(10) unsigned NOT NULL default '0',
  `refund_costid` int(10) unsigned NOT NULL default '0',
  `text` text NOT NULL,
  PRIMARY KEY  (`guid`),
  KEY `ownerguid` (`ownerguid`),
  KEY `itemtext` (`itemtext`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of playeritems
-- ----------------------------
INSERT INTO `playeritems` VALUES ('2', '1', '49', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '3', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('2', '3', '48', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '6', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('2', '2', '47', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '7', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('2', '5', '2092', '0', '0', '0', '1', '0', '0', '0', '0', '0', '16', '-1', '15', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('2', '6', '50055', '0', '0', '0', '1', '0', '0', '0', '0', '0', '16', '-1', '16', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('2', '4', '28979', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '17', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('2', '7', '6948', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '-1', '23', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '8', '49', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '3', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '10', '48', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '6', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '9', '47', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '7', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '12', '2092', '0', '0', '0', '1', '0', '0', '0', '0', '0', '16', '-1', '15', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '13', '50055', '0', '0', '0', '1', '0', '0', '0', '0', '0', '16', '-1', '16', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '11', '28979', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '17', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '14', '6948', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '-1', '23', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('4', '15', '38', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '3', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('4', '16', '39', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '6', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('4', '17', '40', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '7', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('4', '18', '49778', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '15', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('4', '19', '6948', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '-1', '23', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('5', '20', '38', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '3', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('5', '21', '39', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '6', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('5', '22', '40', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '7', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('5', '23', '49778', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '15', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('5', '24', '6948', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '-1', '23', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('2', '25', '41426', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '-1', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('6', '26', '6129', '0', '0', '0', '1', '0', '0', '0', '0', '0', '35', '-1', '4', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('6', '27', '1396', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '6', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('6', '28', '59', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '7', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('6', '29', '35', '0', '0', '0', '1', '0', '0', '0', '0', '0', '25', '-1', '15', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('6', '30', '6948', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '-1', '23', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('6', '31', '41426', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '-1', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '32', '41426', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '-1', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('3', '33', '41426', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '-1', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('4', '34', '41426', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '-1', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('5', '35', '41426', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '-1', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '36', '49', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '3', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '38', '48', '0', '0', '0', '1', '0', '0', '0', '0', '0', '21', '-1', '6', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '37', '47', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '7', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '40', '2092', '0', '0', '0', '1', '0', '0', '0', '0', '0', '14', '-1', '15', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '41', '50055', '0', '0', '0', '1', '0', '0', '0', '0', '0', '14', '-1', '16', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '39', '28979', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '17', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '42', '6948', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '-1', '23', '', '0', '0', '0', '');
INSERT INTO `playeritems` VALUES ('7', '43', '41426', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '-1', '-1', '', '0', '0', '0', '');

-- ----------------------------
-- Table structure for `playerpets`
-- ----------------------------
DROP TABLE IF EXISTS `playerpets`;
CREATE TABLE `playerpets` (
  `ownerguid` bigint(20) NOT NULL default '0',
  `petnumber` int(11) NOT NULL default '0',
  `name` varchar(21) collate utf8_unicode_ci NOT NULL default '',
  `entry` int(10) unsigned NOT NULL default '0',
  `xp` int(11) NOT NULL default '0',
  `active` tinyint(1) NOT NULL default '0',
  `level` int(11) NOT NULL default '0',
  `actionbar` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `happinessupdate` int(11) NOT NULL default '0',
  `reset_time` int(10) unsigned NOT NULL default '0',
  `reset_cost` int(10) NOT NULL default '0',
  `spellid` int(10) unsigned NOT NULL default '0',
  `petstate` int(10) unsigned NOT NULL default '0',
  `alive` tinyint(1) NOT NULL default '1',
  `talentpoints` int(10) unsigned NOT NULL default '0',
  `current_power` int(10) unsigned NOT NULL default '1',
  `current_hp` int(10) unsigned NOT NULL default '1',
  `current_happiness` int(10) unsigned NOT NULL default '1000000',
  `renamable` int(10) unsigned NOT NULL default '1',
  `type` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`ownerguid`,`petnumber`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of playerpets
-- ----------------------------

-- ----------------------------
-- Table structure for `playerpetspells`
-- ----------------------------
DROP TABLE IF EXISTS `playerpetspells`;
CREATE TABLE `playerpetspells` (
  `ownerguid` bigint(20) NOT NULL default '0',
  `petnumber` int(4) NOT NULL default '0',
  `spellid` int(4) NOT NULL default '0',
  `flags` int(4) NOT NULL default '0',
  KEY `a` (`ownerguid`),
  KEY `b` (`petnumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of playerpetspells
-- ----------------------------

-- ----------------------------
-- Table structure for `playerreputations`
-- ----------------------------
DROP TABLE IF EXISTS `playerreputations`;
CREATE TABLE `playerreputations` (
  `guid` int(10) unsigned NOT NULL,
  `faction` int(10) unsigned NOT NULL,
  `flag` int(10) unsigned NOT NULL default '0',
  `basestanding` int(11) NOT NULL default '0',
  `standing` int(11) NOT NULL default '0',
  PRIMARY KEY  (`guid`,`faction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of playerreputations
-- ----------------------------
INSERT INTO `playerreputations` VALUES ('2', '1156', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1155', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1154', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1137', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1136', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1126', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1124', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '1119', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '1118', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1117', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1106', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1105', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1104', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1098', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1094', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1091', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1090', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1085', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '1082', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1077', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1073', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1068', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1067', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '1064', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '1052', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '1050', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1038', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1037', '136', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1031', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1015', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '1012', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1011', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '1005', '4', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('2', '990', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '989', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '978', '16', '-1200', '-1200');
INSERT INTO `playerreputations` VALUES ('2', '970', '0', '-2500', '-2500');
INSERT INTO `playerreputations` VALUES ('2', '967', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '952', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '949', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '948', '8', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '947', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '946', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '942', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '941', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '936', '28', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '935', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '934', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '933', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '932', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '930', '17', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('2', '922', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '911', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '910', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '909', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '892', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '891', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '890', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '889', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '809', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '749', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '730', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '729', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '609', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '589', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '577', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('2', '576', '2', '-3500', '-3500');
INSERT INTO `playerreputations` VALUES ('2', '574', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '571', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '570', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '569', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '551', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('2', '550', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('2', '549', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('2', '530', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '529', '0', '200', '200');
INSERT INTO `playerreputations` VALUES ('2', '510', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '509', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '471', '20', '150', '150');
INSERT INTO `playerreputations` VALUES ('2', '470', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('2', '469', '25', '3300', '3300');
INSERT INTO `playerreputations` VALUES ('2', '369', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('2', '349', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '289', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '270', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '169', '12', '500', '500');
INSERT INTO `playerreputations` VALUES ('2', '93', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('2', '92', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('2', '87', '2', '-6500', '-6500');
INSERT INTO `playerreputations` VALUES ('2', '86', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('2', '83', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('2', '81', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '76', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '72', '17', '4000', '4000');
INSERT INTO `playerreputations` VALUES ('2', '70', '2', '-10000', '-10000');
INSERT INTO `playerreputations` VALUES ('2', '69', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('2', '68', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '67', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('2', '59', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '54', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('2', '47', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('2', '46', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('2', '21', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('3', '1156', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1155', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1154', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1137', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1136', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1126', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1124', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '1119', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '1118', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1117', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1106', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1105', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1104', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1098', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1094', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1091', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1090', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1085', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '1082', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1077', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1073', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1068', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1067', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '1064', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '1052', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '1050', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1038', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1037', '136', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1031', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1015', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '1012', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1011', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '1005', '4', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('3', '990', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '989', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '978', '16', '-1200', '-1200');
INSERT INTO `playerreputations` VALUES ('3', '970', '0', '-2500', '-2500');
INSERT INTO `playerreputations` VALUES ('3', '967', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '952', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '949', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '948', '8', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '947', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '946', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '942', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '941', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '936', '28', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '935', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '934', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '933', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '932', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '930', '17', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('3', '922', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '911', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '910', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '909', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '892', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '891', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '890', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '889', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '809', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '749', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '730', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '729', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '609', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '589', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '577', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('3', '576', '2', '-3500', '-3500');
INSERT INTO `playerreputations` VALUES ('3', '574', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '571', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '570', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '569', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '551', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('3', '550', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('3', '549', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('3', '530', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '529', '0', '200', '200');
INSERT INTO `playerreputations` VALUES ('3', '510', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '509', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '471', '20', '150', '150');
INSERT INTO `playerreputations` VALUES ('3', '470', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('3', '469', '25', '3300', '3300');
INSERT INTO `playerreputations` VALUES ('3', '369', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('3', '349', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '289', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '270', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '169', '12', '500', '500');
INSERT INTO `playerreputations` VALUES ('3', '93', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('3', '92', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('3', '87', '2', '-6500', '-6500');
INSERT INTO `playerreputations` VALUES ('3', '86', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('3', '83', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('3', '81', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '76', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '72', '17', '4000', '4000');
INSERT INTO `playerreputations` VALUES ('3', '70', '2', '-10000', '-10000');
INSERT INTO `playerreputations` VALUES ('3', '69', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('3', '68', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '67', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('3', '59', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '54', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('3', '47', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('3', '46', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('3', '21', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('4', '21', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('4', '46', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '47', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('4', '54', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('4', '59', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '67', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '68', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '69', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('4', '70', '2', '-10000', '-10000');
INSERT INTO `playerreputations` VALUES ('4', '72', '17', '4000', '4000');
INSERT INTO `playerreputations` VALUES ('4', '76', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '81', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '83', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('4', '86', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('4', '87', '2', '-6500', '-6500');
INSERT INTO `playerreputations` VALUES ('4', '92', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('4', '93', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('4', '169', '12', '500', '500');
INSERT INTO `playerreputations` VALUES ('4', '270', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '289', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '349', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '369', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('4', '469', '25', '3300', '3300');
INSERT INTO `playerreputations` VALUES ('4', '470', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('4', '471', '20', '150', '150');
INSERT INTO `playerreputations` VALUES ('4', '509', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '510', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '529', '0', '200', '200');
INSERT INTO `playerreputations` VALUES ('4', '530', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '549', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('4', '550', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('4', '551', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('4', '569', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '570', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '571', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '574', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '576', '2', '-3500', '-3500');
INSERT INTO `playerreputations` VALUES ('4', '577', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('4', '589', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '609', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '729', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '730', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '749', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '809', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '889', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '890', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '891', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '892', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '909', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '910', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '911', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '922', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '930', '17', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('4', '932', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '933', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '934', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '935', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '936', '28', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '941', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '942', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '946', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '947', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '948', '8', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '949', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '952', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '967', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '970', '0', '-2500', '-2500');
INSERT INTO `playerreputations` VALUES ('4', '978', '16', '-1200', '-1200');
INSERT INTO `playerreputations` VALUES ('4', '989', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '990', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1005', '4', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('4', '1011', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1012', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1015', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '1031', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1037', '136', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1038', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1050', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1052', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '1064', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '1067', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '1068', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1073', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1077', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1082', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1085', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '1090', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1091', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1094', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1098', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1104', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1105', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1106', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1117', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1118', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1119', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '1124', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('4', '1126', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1136', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1137', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1154', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1155', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('4', '1156', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1156', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1155', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1154', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1137', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1136', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1126', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1124', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '1119', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '1118', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1117', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1106', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1105', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1104', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1098', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1094', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1091', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1090', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1085', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '1082', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1077', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1073', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1068', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1067', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '1064', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '1052', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '1050', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1038', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1037', '136', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1031', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1015', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '1012', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1011', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '1005', '4', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('5', '990', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '989', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '978', '16', '-1200', '-1200');
INSERT INTO `playerreputations` VALUES ('5', '970', '0', '-2500', '-2500');
INSERT INTO `playerreputations` VALUES ('5', '967', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '952', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '949', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '948', '8', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '947', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '946', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '942', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '941', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '936', '28', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '935', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '934', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '933', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '932', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '930', '17', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('5', '922', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '911', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '910', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '909', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '892', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '891', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '890', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '889', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '809', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '749', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '730', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '729', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '609', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '589', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '577', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('5', '576', '2', '-3500', '-3500');
INSERT INTO `playerreputations` VALUES ('5', '574', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '571', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '570', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '569', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '551', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('5', '550', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('5', '549', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('5', '530', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '529', '0', '200', '200');
INSERT INTO `playerreputations` VALUES ('5', '510', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '509', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '471', '20', '150', '150');
INSERT INTO `playerreputations` VALUES ('5', '470', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('5', '469', '25', '3300', '3300');
INSERT INTO `playerreputations` VALUES ('5', '369', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('5', '349', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '289', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '270', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '169', '12', '500', '500');
INSERT INTO `playerreputations` VALUES ('5', '93', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('5', '92', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('5', '87', '2', '-6500', '-6500');
INSERT INTO `playerreputations` VALUES ('5', '86', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('5', '83', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('5', '81', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '76', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '72', '17', '4000', '4082');
INSERT INTO `playerreputations` VALUES ('5', '70', '2', '-10000', '-10000');
INSERT INTO `playerreputations` VALUES ('5', '69', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('5', '68', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '67', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('5', '59', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '54', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('5', '47', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('5', '46', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('5', '21', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('6', '1156', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1155', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1154', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1137', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1136', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1126', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '1124', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1119', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '1118', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1117', '12', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1106', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1105', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1104', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1098', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1094', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '1091', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1090', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1085', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1082', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '1077', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1073', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1068', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '1067', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1064', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1052', '152', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1050', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '1038', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1037', '6', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1031', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1015', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '1012', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1011', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '1005', '4', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('6', '990', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '989', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '978', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '970', '0', '-2500', '-2500');
INSERT INTO `playerreputations` VALUES ('6', '967', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '952', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '949', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '948', '8', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '947', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '946', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '942', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '941', '16', '-500', '-500');
INSERT INTO `playerreputations` VALUES ('6', '936', '28', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '935', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '934', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '933', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '932', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '930', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '922', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '911', '17', '400', '400');
INSERT INTO `playerreputations` VALUES ('6', '910', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '909', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '892', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '891', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '890', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '889', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '809', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '749', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '730', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '729', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '609', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '589', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '577', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('6', '576', '2', '-3500', '-3500');
INSERT INTO `playerreputations` VALUES ('6', '574', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '571', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '570', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '569', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '551', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('6', '550', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('6', '549', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('6', '530', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('6', '529', '0', '200', '200');
INSERT INTO `playerreputations` VALUES ('6', '510', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '509', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '471', '22', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '470', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('6', '469', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '369', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('6', '349', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '289', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '270', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '169', '12', '500', '500');
INSERT INTO `playerreputations` VALUES ('6', '93', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('6', '92', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('6', '87', '2', '-6500', '-6500');
INSERT INTO `playerreputations` VALUES ('6', '86', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('6', '83', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('6', '81', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('6', '76', '17', '4000', '4000');
INSERT INTO `playerreputations` VALUES ('6', '72', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '70', '2', '-10000', '-10000');
INSERT INTO `playerreputations` VALUES ('6', '69', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '68', '17', '500', '500');
INSERT INTO `playerreputations` VALUES ('6', '67', '25', '3500', '3500');
INSERT INTO `playerreputations` VALUES ('6', '59', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '54', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '47', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('6', '46', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('6', '21', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('7', '21', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('7', '46', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '47', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('7', '54', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('7', '59', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '67', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '68', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '69', '17', '3100', '3100');
INSERT INTO `playerreputations` VALUES ('7', '70', '2', '-10000', '-10000');
INSERT INTO `playerreputations` VALUES ('7', '72', '17', '4000', '4000');
INSERT INTO `playerreputations` VALUES ('7', '76', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '81', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '83', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('7', '86', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('7', '87', '2', '-6500', '-6500');
INSERT INTO `playerreputations` VALUES ('7', '92', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('7', '93', '2', '2000', '2000');
INSERT INTO `playerreputations` VALUES ('7', '169', '12', '500', '500');
INSERT INTO `playerreputations` VALUES ('7', '270', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '289', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '349', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '369', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('7', '469', '25', '3300', '3300');
INSERT INTO `playerreputations` VALUES ('7', '470', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('7', '471', '20', '150', '150');
INSERT INTO `playerreputations` VALUES ('7', '509', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '510', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '529', '0', '200', '200');
INSERT INTO `playerreputations` VALUES ('7', '530', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '549', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('7', '550', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('7', '551', '4', '2999', '2999');
INSERT INTO `playerreputations` VALUES ('7', '569', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '570', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '571', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '574', '4', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '576', '2', '-3500', '-3500');
INSERT INTO `playerreputations` VALUES ('7', '577', '64', '500', '500');
INSERT INTO `playerreputations` VALUES ('7', '589', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '609', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '729', '2', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '730', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '749', '0', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '809', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '889', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '890', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '891', '24', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '892', '14', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '909', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '910', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '911', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '922', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '930', '17', '3000', '3000');
INSERT INTO `playerreputations` VALUES ('7', '932', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '933', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '934', '80', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '935', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '936', '28', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '941', '6', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '942', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '946', '16', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '947', '0', '-42000', '-42000');
INSERT INTO `playerreputations` VALUES ('7', '948', '8', '0', '0');
INSERT INTO `playerreputations` VALUES ('7', '949', '24', '0', '0');

-- ----------------------------
-- Table structure for `playerskills`
-- ----------------------------
DROP TABLE IF EXISTS `playerskills`;
CREATE TABLE `playerskills` (
  `GUID` int(10) unsigned NOT NULL,
  `SkillID` int(10) unsigned NOT NULL,
  `CurrentValue` int(10) unsigned NOT NULL,
  `MaximumValue` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`GUID`,`SkillID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of playerskills
-- ----------------------------
INSERT INTO `playerskills` VALUES ('2', '38', '1', '1');
INSERT INTO `playerskills` VALUES ('2', '95', '1', '400');
INSERT INTO `playerskills` VALUES ('2', '118', '1', '400');
INSERT INTO `playerskills` VALUES ('2', '162', '1', '400');
INSERT INTO `playerskills` VALUES ('2', '173', '1', '400');
INSERT INTO `playerskills` VALUES ('2', '176', '1', '400');
INSERT INTO `playerskills` VALUES ('2', '183', '1', '1');
INSERT INTO `playerskills` VALUES ('2', '253', '1', '1');
INSERT INTO `playerskills` VALUES ('2', '414', '1', '1');
INSERT INTO `playerskills` VALUES ('3', '414', '1', '1');
INSERT INTO `playerskills` VALUES ('3', '253', '1', '1');
INSERT INTO `playerskills` VALUES ('3', '183', '1', '1');
INSERT INTO `playerskills` VALUES ('3', '176', '1', '400');
INSERT INTO `playerskills` VALUES ('3', '173', '1', '400');
INSERT INTO `playerskills` VALUES ('3', '162', '1', '400');
INSERT INTO `playerskills` VALUES ('3', '118', '1', '400');
INSERT INTO `playerskills` VALUES ('3', '95', '1', '400');
INSERT INTO `playerskills` VALUES ('3', '38', '1', '1');
INSERT INTO `playerskills` VALUES ('4', '44', '1', '400');
INSERT INTO `playerskills` VALUES ('4', '54', '1', '400');
INSERT INTO `playerskills` VALUES ('4', '55', '1', '400');
INSERT INTO `playerskills` VALUES ('4', '95', '1', '400');
INSERT INTO `playerskills` VALUES ('4', '162', '1', '400');
INSERT INTO `playerskills` VALUES ('4', '183', '1', '1');
INSERT INTO `playerskills` VALUES ('4', '413', '1', '1');
INSERT INTO `playerskills` VALUES ('4', '414', '1', '1');
INSERT INTO `playerskills` VALUES ('4', '415', '1', '1');
INSERT INTO `playerskills` VALUES ('4', '433', '1', '1');
INSERT INTO `playerskills` VALUES ('4', '754', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '754', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '433', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '415', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '414', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '413', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '229', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '226', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '183', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '173', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '162', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '136', '1', '400');
INSERT INTO `playerskills` VALUES ('2', '415', '1', '1');
INSERT INTO `playerskills` VALUES ('2', '754', '1', '1');
INSERT INTO `playerskills` VALUES ('6', '415', '1', '1');
INSERT INTO `playerskills` VALUES ('6', '354', '1', '1');
INSERT INTO `playerskills` VALUES ('6', '228', '1', '5');
INSERT INTO `playerskills` VALUES ('6', '183', '1', '1');
INSERT INTO `playerskills` VALUES ('6', '173', '1', '5');
INSERT INTO `playerskills` VALUES ('6', '162', '1', '5');
INSERT INTO `playerskills` VALUES ('6', '136', '1', '5');
INSERT INTO `playerskills` VALUES ('6', '125', '1', '1');
INSERT INTO `playerskills` VALUES ('6', '95', '1', '5');
INSERT INTO `playerskills` VALUES ('6', '593', '1', '1');
INSERT INTO `playerskills` VALUES ('3', '415', '1', '1');
INSERT INTO `playerskills` VALUES ('3', '754', '1', '1');
INSERT INTO `playerskills` VALUES ('4', '43', '1', '400');
INSERT INTO `playerskills` VALUES ('4', '26', '1', '1');
INSERT INTO `playerskills` VALUES ('5', '95', '3', '400');
INSERT INTO `playerskills` VALUES ('5', '55', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '54', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '44', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '43', '1', '400');
INSERT INTO `playerskills` VALUES ('5', '26', '1', '1');
INSERT INTO `playerskills` VALUES ('7', '414', '1', '1');
INSERT INTO `playerskills` VALUES ('7', '253', '1', '1');
INSERT INTO `playerskills` VALUES ('7', '183', '1', '1');
INSERT INTO `playerskills` VALUES ('7', '176', '1', '400');
INSERT INTO `playerskills` VALUES ('7', '173', '1', '400');
INSERT INTO `playerskills` VALUES ('7', '162', '1', '400');
INSERT INTO `playerskills` VALUES ('7', '118', '1', '400');
INSERT INTO `playerskills` VALUES ('7', '95', '3', '400');
INSERT INTO `playerskills` VALUES ('7', '38', '1', '1');
INSERT INTO `playerskills` VALUES ('7', '415', '1', '1');
INSERT INTO `playerskills` VALUES ('7', '754', '1', '1');

-- ----------------------------
-- Table structure for `playerspells`
-- ----------------------------
DROP TABLE IF EXISTS `playerspells`;
CREATE TABLE `playerspells` (
  `GUID` int(10) unsigned NOT NULL,
  `SpellID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`GUID`,`SpellID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of playerspells
-- ----------------------------
INSERT INTO `playerspells` VALUES ('2', '81');
INSERT INTO `playerspells` VALUES ('2', '203');
INSERT INTO `playerspells` VALUES ('2', '204');
INSERT INTO `playerspells` VALUES ('2', '522');
INSERT INTO `playerspells` VALUES ('2', '668');
INSERT INTO `playerspells` VALUES ('2', '669');
INSERT INTO `playerspells` VALUES ('2', '670');
INSERT INTO `playerspells` VALUES ('2', '671');
INSERT INTO `playerspells` VALUES ('2', '672');
INSERT INTO `playerspells` VALUES ('2', '674');
INSERT INTO `playerspells` VALUES ('2', '813');
INSERT INTO `playerspells` VALUES ('2', '1180');
INSERT INTO `playerspells` VALUES ('2', '1752');
INSERT INTO `playerspells` VALUES ('2', '2098');
INSERT INTO `playerspells` VALUES ('2', '2382');
INSERT INTO `playerspells` VALUES ('2', '2479');
INSERT INTO `playerspells` VALUES ('2', '2567');
INSERT INTO `playerspells` VALUES ('2', '2764');
INSERT INTO `playerspells` VALUES ('2', '3050');
INSERT INTO `playerspells` VALUES ('2', '3127');
INSERT INTO `playerspells` VALUES ('2', '3365');
INSERT INTO `playerspells` VALUES ('2', '6233');
INSERT INTO `playerspells` VALUES ('2', '6246');
INSERT INTO `playerspells` VALUES ('2', '6247');
INSERT INTO `playerspells` VALUES ('2', '6477');
INSERT INTO `playerspells` VALUES ('2', '6478');
INSERT INTO `playerspells` VALUES ('2', '6603');
INSERT INTO `playerspells` VALUES ('2', '7266');
INSERT INTO `playerspells` VALUES ('2', '7267');
INSERT INTO `playerspells` VALUES ('2', '7341');
INSERT INTO `playerspells` VALUES ('2', '7355');
INSERT INTO `playerspells` VALUES ('2', '8386');
INSERT INTO `playerspells` VALUES ('2', '9077');
INSERT INTO `playerspells` VALUES ('2', '9078');
INSERT INTO `playerspells` VALUES ('2', '9125');
INSERT INTO `playerspells` VALUES ('2', '16092');
INSERT INTO `playerspells` VALUES ('2', '17737');
INSERT INTO `playerspells` VALUES ('2', '20597');
INSERT INTO `playerspells` VALUES ('2', '20598');
INSERT INTO `playerspells` VALUES ('2', '20599');
INSERT INTO `playerspells` VALUES ('2', '20864');
INSERT INTO `playerspells` VALUES ('2', '21184');
INSERT INTO `playerspells` VALUES ('2', '21651');
INSERT INTO `playerspells` VALUES ('2', '21652');
INSERT INTO `playerspells` VALUES ('2', '22027');
INSERT INTO `playerspells` VALUES ('2', '22810');
INSERT INTO `playerspells` VALUES ('2', '29932');
INSERT INTO `playerspells` VALUES ('2', '58985');
INSERT INTO `playerspells` VALUES ('2', '59752');
INSERT INTO `playerspells` VALUES ('3', '81');
INSERT INTO `playerspells` VALUES ('3', '203');
INSERT INTO `playerspells` VALUES ('3', '204');
INSERT INTO `playerspells` VALUES ('3', '522');
INSERT INTO `playerspells` VALUES ('3', '668');
INSERT INTO `playerspells` VALUES ('3', '669');
INSERT INTO `playerspells` VALUES ('3', '670');
INSERT INTO `playerspells` VALUES ('3', '671');
INSERT INTO `playerspells` VALUES ('3', '672');
INSERT INTO `playerspells` VALUES ('3', '674');
INSERT INTO `playerspells` VALUES ('3', '813');
INSERT INTO `playerspells` VALUES ('3', '1180');
INSERT INTO `playerspells` VALUES ('3', '1752');
INSERT INTO `playerspells` VALUES ('3', '2098');
INSERT INTO `playerspells` VALUES ('3', '2382');
INSERT INTO `playerspells` VALUES ('3', '2479');
INSERT INTO `playerspells` VALUES ('3', '2567');
INSERT INTO `playerspells` VALUES ('3', '2764');
INSERT INTO `playerspells` VALUES ('3', '3050');
INSERT INTO `playerspells` VALUES ('3', '3127');
INSERT INTO `playerspells` VALUES ('3', '3365');
INSERT INTO `playerspells` VALUES ('3', '6233');
INSERT INTO `playerspells` VALUES ('3', '6246');
INSERT INTO `playerspells` VALUES ('3', '6247');
INSERT INTO `playerspells` VALUES ('3', '6477');
INSERT INTO `playerspells` VALUES ('3', '6478');
INSERT INTO `playerspells` VALUES ('3', '6603');
INSERT INTO `playerspells` VALUES ('3', '7266');
INSERT INTO `playerspells` VALUES ('3', '7267');
INSERT INTO `playerspells` VALUES ('3', '7341');
INSERT INTO `playerspells` VALUES ('3', '7355');
INSERT INTO `playerspells` VALUES ('3', '8386');
INSERT INTO `playerspells` VALUES ('3', '9077');
INSERT INTO `playerspells` VALUES ('3', '9078');
INSERT INTO `playerspells` VALUES ('3', '9125');
INSERT INTO `playerspells` VALUES ('3', '16092');
INSERT INTO `playerspells` VALUES ('3', '17737');
INSERT INTO `playerspells` VALUES ('3', '20597');
INSERT INTO `playerspells` VALUES ('3', '20598');
INSERT INTO `playerspells` VALUES ('3', '20599');
INSERT INTO `playerspells` VALUES ('3', '20864');
INSERT INTO `playerspells` VALUES ('3', '21184');
INSERT INTO `playerspells` VALUES ('3', '21651');
INSERT INTO `playerspells` VALUES ('3', '21652');
INSERT INTO `playerspells` VALUES ('3', '22027');
INSERT INTO `playerspells` VALUES ('3', '22810');
INSERT INTO `playerspells` VALUES ('3', '29932');
INSERT INTO `playerspells` VALUES ('3', '58985');
INSERT INTO `playerspells` VALUES ('3', '59752');
INSERT INTO `playerspells` VALUES ('4', '78');
INSERT INTO `playerspells` VALUES ('4', '81');
INSERT INTO `playerspells` VALUES ('4', '107');
INSERT INTO `playerspells` VALUES ('4', '196');
INSERT INTO `playerspells` VALUES ('4', '198');
INSERT INTO `playerspells` VALUES ('4', '201');
INSERT INTO `playerspells` VALUES ('4', '202');
INSERT INTO `playerspells` VALUES ('4', '203');
INSERT INTO `playerspells` VALUES ('4', '204');
INSERT INTO `playerspells` VALUES ('4', '522');
INSERT INTO `playerspells` VALUES ('4', '668');
INSERT INTO `playerspells` VALUES ('4', '669');
INSERT INTO `playerspells` VALUES ('4', '670');
INSERT INTO `playerspells` VALUES ('4', '671');
INSERT INTO `playerspells` VALUES ('4', '672');
INSERT INTO `playerspells` VALUES ('4', '813');
INSERT INTO `playerspells` VALUES ('4', '2382');
INSERT INTO `playerspells` VALUES ('4', '2457');
INSERT INTO `playerspells` VALUES ('4', '2479');
INSERT INTO `playerspells` VALUES ('4', '3050');
INSERT INTO `playerspells` VALUES ('4', '3127');
INSERT INTO `playerspells` VALUES ('4', '3365');
INSERT INTO `playerspells` VALUES ('4', '5301');
INSERT INTO `playerspells` VALUES ('4', '6233');
INSERT INTO `playerspells` VALUES ('4', '6246');
INSERT INTO `playerspells` VALUES ('4', '6247');
INSERT INTO `playerspells` VALUES ('4', '6477');
INSERT INTO `playerspells` VALUES ('4', '6478');
INSERT INTO `playerspells` VALUES ('4', '6603');
INSERT INTO `playerspells` VALUES ('4', '7266');
INSERT INTO `playerspells` VALUES ('4', '7267');
INSERT INTO `playerspells` VALUES ('4', '7341');
INSERT INTO `playerspells` VALUES ('4', '7355');
INSERT INTO `playerspells` VALUES ('4', '8386');
INSERT INTO `playerspells` VALUES ('4', '8737');
INSERT INTO `playerspells` VALUES ('4', '9077');
INSERT INTO `playerspells` VALUES ('4', '9078');
INSERT INTO `playerspells` VALUES ('4', '9116');
INSERT INTO `playerspells` VALUES ('4', '9125');
INSERT INTO `playerspells` VALUES ('4', '17737');
INSERT INTO `playerspells` VALUES ('4', '20597');
INSERT INTO `playerspells` VALUES ('4', '20598');
INSERT INTO `playerspells` VALUES ('4', '20599');
INSERT INTO `playerspells` VALUES ('4', '20864');
INSERT INTO `playerspells` VALUES ('4', '21651');
INSERT INTO `playerspells` VALUES ('4', '21652');
INSERT INTO `playerspells` VALUES ('4', '22027');
INSERT INTO `playerspells` VALUES ('4', '22810');
INSERT INTO `playerspells` VALUES ('4', '29932');
INSERT INTO `playerspells` VALUES ('4', '58985');
INSERT INTO `playerspells` VALUES ('4', '59752');
INSERT INTO `playerspells` VALUES ('5', '78');
INSERT INTO `playerspells` VALUES ('5', '81');
INSERT INTO `playerspells` VALUES ('5', '107');
INSERT INTO `playerspells` VALUES ('5', '196');
INSERT INTO `playerspells` VALUES ('5', '198');
INSERT INTO `playerspells` VALUES ('5', '200');
INSERT INTO `playerspells` VALUES ('5', '201');
INSERT INTO `playerspells` VALUES ('5', '202');
INSERT INTO `playerspells` VALUES ('5', '203');
INSERT INTO `playerspells` VALUES ('5', '204');
INSERT INTO `playerspells` VALUES ('5', '227');
INSERT INTO `playerspells` VALUES ('5', '522');
INSERT INTO `playerspells` VALUES ('5', '668');
INSERT INTO `playerspells` VALUES ('5', '669');
INSERT INTO `playerspells` VALUES ('5', '670');
INSERT INTO `playerspells` VALUES ('5', '671');
INSERT INTO `playerspells` VALUES ('5', '672');
INSERT INTO `playerspells` VALUES ('5', '813');
INSERT INTO `playerspells` VALUES ('5', '1180');
INSERT INTO `playerspells` VALUES ('5', '2382');
INSERT INTO `playerspells` VALUES ('5', '2457');
INSERT INTO `playerspells` VALUES ('5', '2479');
INSERT INTO `playerspells` VALUES ('5', '3018');
INSERT INTO `playerspells` VALUES ('5', '3050');
INSERT INTO `playerspells` VALUES ('5', '3127');
INSERT INTO `playerspells` VALUES ('5', '3365');
INSERT INTO `playerspells` VALUES ('5', '5011');
INSERT INTO `playerspells` VALUES ('5', '5301');
INSERT INTO `playerspells` VALUES ('5', '6233');
INSERT INTO `playerspells` VALUES ('5', '6246');
INSERT INTO `playerspells` VALUES ('5', '6247');
INSERT INTO `playerspells` VALUES ('5', '6477');
INSERT INTO `playerspells` VALUES ('5', '6478');
INSERT INTO `playerspells` VALUES ('5', '6603');
INSERT INTO `playerspells` VALUES ('5', '7266');
INSERT INTO `playerspells` VALUES ('5', '7267');
INSERT INTO `playerspells` VALUES ('5', '7341');
INSERT INTO `playerspells` VALUES ('5', '7355');
INSERT INTO `playerspells` VALUES ('5', '8386');
INSERT INTO `playerspells` VALUES ('5', '8737');
INSERT INTO `playerspells` VALUES ('5', '9077');
INSERT INTO `playerspells` VALUES ('5', '9078');
INSERT INTO `playerspells` VALUES ('5', '9116');
INSERT INTO `playerspells` VALUES ('5', '9125');
INSERT INTO `playerspells` VALUES ('5', '17737');
INSERT INTO `playerspells` VALUES ('5', '20597');
INSERT INTO `playerspells` VALUES ('5', '20598');
INSERT INTO `playerspells` VALUES ('5', '20599');
INSERT INTO `playerspells` VALUES ('5', '20864');
INSERT INTO `playerspells` VALUES ('5', '21651');
INSERT INTO `playerspells` VALUES ('5', '21652');
INSERT INTO `playerspells` VALUES ('5', '22027');
INSERT INTO `playerspells` VALUES ('5', '22810');
INSERT INTO `playerspells` VALUES ('5', '29932');
INSERT INTO `playerspells` VALUES ('5', '58985');
INSERT INTO `playerspells` VALUES ('5', '59752');
INSERT INTO `playerspells` VALUES ('6', '81');
INSERT INTO `playerspells` VALUES ('6', '203');
INSERT INTO `playerspells` VALUES ('6', '204');
INSERT INTO `playerspells` VALUES ('6', '227');
INSERT INTO `playerspells` VALUES ('6', '522');
INSERT INTO `playerspells` VALUES ('6', '668');
INSERT INTO `playerspells` VALUES ('6', '669');
INSERT INTO `playerspells` VALUES ('6', '670');
INSERT INTO `playerspells` VALUES ('6', '671');
INSERT INTO `playerspells` VALUES ('6', '672');
INSERT INTO `playerspells` VALUES ('6', '686');
INSERT INTO `playerspells` VALUES ('6', '687');
INSERT INTO `playerspells` VALUES ('6', '813');
INSERT INTO `playerspells` VALUES ('6', '1180');
INSERT INTO `playerspells` VALUES ('6', '2382');
INSERT INTO `playerspells` VALUES ('6', '2479');
INSERT INTO `playerspells` VALUES ('6', '3050');
INSERT INTO `playerspells` VALUES ('6', '3127');
INSERT INTO `playerspells` VALUES ('6', '3365');
INSERT INTO `playerspells` VALUES ('6', '5009');
INSERT INTO `playerspells` VALUES ('6', '5019');
INSERT INTO `playerspells` VALUES ('6', '6233');
INSERT INTO `playerspells` VALUES ('6', '6246');
INSERT INTO `playerspells` VALUES ('6', '6247');
INSERT INTO `playerspells` VALUES ('6', '6477');
INSERT INTO `playerspells` VALUES ('6', '6478');
INSERT INTO `playerspells` VALUES ('6', '6603');
INSERT INTO `playerspells` VALUES ('6', '7266');
INSERT INTO `playerspells` VALUES ('6', '7267');
INSERT INTO `playerspells` VALUES ('6', '7341');
INSERT INTO `playerspells` VALUES ('6', '7355');
INSERT INTO `playerspells` VALUES ('6', '8386');
INSERT INTO `playerspells` VALUES ('6', '9078');
INSERT INTO `playerspells` VALUES ('6', '9125');
INSERT INTO `playerspells` VALUES ('6', '17737');
INSERT INTO `playerspells` VALUES ('6', '20573');
INSERT INTO `playerspells` VALUES ('6', '20574');
INSERT INTO `playerspells` VALUES ('6', '21651');
INSERT INTO `playerspells` VALUES ('6', '21652');
INSERT INTO `playerspells` VALUES ('6', '22027');
INSERT INTO `playerspells` VALUES ('6', '22810');
INSERT INTO `playerspells` VALUES ('6', '29932');
INSERT INTO `playerspells` VALUES ('6', '33702');
INSERT INTO `playerspells` VALUES ('6', '54562');
INSERT INTO `playerspells` VALUES ('7', '81');
INSERT INTO `playerspells` VALUES ('7', '203');
INSERT INTO `playerspells` VALUES ('7', '204');
INSERT INTO `playerspells` VALUES ('7', '522');
INSERT INTO `playerspells` VALUES ('7', '668');
INSERT INTO `playerspells` VALUES ('7', '669');
INSERT INTO `playerspells` VALUES ('7', '670');
INSERT INTO `playerspells` VALUES ('7', '671');
INSERT INTO `playerspells` VALUES ('7', '672');
INSERT INTO `playerspells` VALUES ('7', '674');
INSERT INTO `playerspells` VALUES ('7', '813');
INSERT INTO `playerspells` VALUES ('7', '1180');
INSERT INTO `playerspells` VALUES ('7', '1752');
INSERT INTO `playerspells` VALUES ('7', '2098');
INSERT INTO `playerspells` VALUES ('7', '2382');
INSERT INTO `playerspells` VALUES ('7', '2479');
INSERT INTO `playerspells` VALUES ('7', '2567');
INSERT INTO `playerspells` VALUES ('7', '2764');
INSERT INTO `playerspells` VALUES ('7', '3050');
INSERT INTO `playerspells` VALUES ('7', '3127');
INSERT INTO `playerspells` VALUES ('7', '3365');
INSERT INTO `playerspells` VALUES ('7', '6233');
INSERT INTO `playerspells` VALUES ('7', '6246');
INSERT INTO `playerspells` VALUES ('7', '6247');
INSERT INTO `playerspells` VALUES ('7', '6477');
INSERT INTO `playerspells` VALUES ('7', '6478');
INSERT INTO `playerspells` VALUES ('7', '6603');
INSERT INTO `playerspells` VALUES ('7', '7266');
INSERT INTO `playerspells` VALUES ('7', '7267');
INSERT INTO `playerspells` VALUES ('7', '7341');
INSERT INTO `playerspells` VALUES ('7', '7355');
INSERT INTO `playerspells` VALUES ('7', '8386');
INSERT INTO `playerspells` VALUES ('7', '9077');
INSERT INTO `playerspells` VALUES ('7', '9078');
INSERT INTO `playerspells` VALUES ('7', '9125');
INSERT INTO `playerspells` VALUES ('7', '16092');
INSERT INTO `playerspells` VALUES ('7', '17737');
INSERT INTO `playerspells` VALUES ('7', '20597');
INSERT INTO `playerspells` VALUES ('7', '20598');
INSERT INTO `playerspells` VALUES ('7', '20599');
INSERT INTO `playerspells` VALUES ('7', '20864');
INSERT INTO `playerspells` VALUES ('7', '21184');
INSERT INTO `playerspells` VALUES ('7', '21651');
INSERT INTO `playerspells` VALUES ('7', '21652');
INSERT INTO `playerspells` VALUES ('7', '22027');
INSERT INTO `playerspells` VALUES ('7', '22810');
INSERT INTO `playerspells` VALUES ('7', '29932');
INSERT INTO `playerspells` VALUES ('7', '58985');
INSERT INTO `playerspells` VALUES ('7', '59752');

-- ----------------------------
-- Table structure for `playersummons`
-- ----------------------------
DROP TABLE IF EXISTS `playersummons`;
CREATE TABLE `playersummons` (
  `ownerguid` int(11) unsigned NOT NULL default '0',
  `entry` int(11) unsigned NOT NULL default '0',
  `name` varchar(64) NOT NULL,
  KEY `a` (`ownerguid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of playersummons
-- ----------------------------

-- ----------------------------
-- Table structure for `playersummonspells`
-- ----------------------------
DROP TABLE IF EXISTS `playersummonspells`;
CREATE TABLE `playersummonspells` (
  `ownerguid` bigint(20) NOT NULL default '0',
  `entryid` int(4) NOT NULL default '0',
  `spellid` int(4) NOT NULL default '0',
  KEY `a` (`ownerguid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of playersummonspells
-- ----------------------------
INSERT INTO `playersummonspells` VALUES ('6', '1863', '7814');
INSERT INTO `playersummonspells` VALUES ('6', '1860', '3716');
INSERT INTO `playersummonspells` VALUES ('6', '417', '19505');
INSERT INTO `playersummonspells` VALUES ('6', '416', '3110');

-- ----------------------------
-- Table structure for `questlog`
-- ----------------------------
DROP TABLE IF EXISTS `questlog`;
CREATE TABLE `questlog` (
  `player_guid` bigint(20) unsigned NOT NULL default '0',
  `quest_id` bigint(20) unsigned NOT NULL default '0',
  `slot` int(20) unsigned NOT NULL default '0',
  `expirytime` int(20) unsigned NOT NULL default '0',
  `explored_area1` bigint(20) unsigned NOT NULL default '0',
  `explored_area2` bigint(20) unsigned NOT NULL default '0',
  `explored_area3` bigint(20) unsigned NOT NULL default '0',
  `explored_area4` bigint(20) unsigned NOT NULL default '0',
  `mob_kill1` bigint(20) NOT NULL default '0',
  `mob_kill2` bigint(20) NOT NULL default '0',
  `mob_kill3` bigint(20) NOT NULL default '0',
  `mob_kill4` bigint(20) NOT NULL default '0',
  `completed` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`player_guid`,`quest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of questlog
-- ----------------------------

-- ----------------------------
-- Table structure for `server_settings`
-- ----------------------------
DROP TABLE IF EXISTS `server_settings`;
CREATE TABLE `server_settings` (
  `setting_id` varchar(200) NOT NULL,
  `setting_value` int(50) NOT NULL,
  PRIMARY KEY  (`setting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of server_settings
-- ----------------------------
INSERT INTO `server_settings` VALUES ('last_arena_update_time', '1535448743');
INSERT INTO `server_settings` VALUES ('last_daily_update_time', '0');

-- ----------------------------
-- Table structure for `social_friends`
-- ----------------------------
DROP TABLE IF EXISTS `social_friends`;
CREATE TABLE `social_friends` (
  `character_guid` int(30) NOT NULL,
  `friend_guid` int(30) NOT NULL,
  `note` varchar(100) NOT NULL,
  PRIMARY KEY  (`character_guid`,`friend_guid`),
  KEY `a` (`character_guid`),
  KEY `b` (`friend_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_friends
-- ----------------------------

-- ----------------------------
-- Table structure for `social_ignores`
-- ----------------------------
DROP TABLE IF EXISTS `social_ignores`;
CREATE TABLE `social_ignores` (
  `character_guid` int(30) NOT NULL,
  `ignore_guid` int(30) NOT NULL,
  PRIMARY KEY  (`character_guid`,`ignore_guid`),
  KEY `a` (`character_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of social_ignores
-- ----------------------------

-- ----------------------------
-- Table structure for `tutorials`
-- ----------------------------
DROP TABLE IF EXISTS `tutorials`;
CREATE TABLE `tutorials` (
  `playerId` bigint(20) unsigned NOT NULL default '0',
  `tut0` bigint(20) unsigned NOT NULL default '0',
  `tut1` bigint(20) unsigned NOT NULL default '0',
  `tut2` bigint(20) unsigned NOT NULL default '0',
  `tut3` bigint(20) unsigned NOT NULL default '0',
  `tut4` bigint(20) unsigned NOT NULL default '0',
  `tut5` bigint(20) unsigned NOT NULL default '0',
  `tut6` bigint(20) unsigned NOT NULL default '0',
  `tut7` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`playerId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tutorials
-- ----------------------------
INSERT INTO `tutorials` VALUES ('2', '3779657767', '8389120', '0', '0', '0', '0', '0', '0');
INSERT INTO `tutorials` VALUES ('3', '1614807047', '512', '0', '0', '0', '0', '0', '0');
INSERT INTO `tutorials` VALUES ('4', '1614872583', '8389120', '0', '0', '0', '0', '0', '0');
INSERT INTO `tutorials` VALUES ('5', '3762880567', '8389250', '0', '0', '0', '0', '0', '0');
INSERT INTO `tutorials` VALUES ('6', '4194311', '512', '0', '0', '0', '0', '0', '0');
INSERT INTO `tutorials` VALUES ('7', '1631584279', '8389120', '0', '0', '0', '0', '0', '0');
