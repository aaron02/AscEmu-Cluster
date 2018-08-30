SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `worldmap_info`
-- ----------------------------
DROP TABLE IF EXISTS `worldmap_info`;
CREATE TABLE `worldmap_info` (
  `entry` int(10) unsigned NOT NULL default '0',
  `screenid` int(10) unsigned default '0',
  `type` int(10) unsigned default '0',
  `maxplayers` int(10) unsigned default '0',
  `minlevel` int(10) unsigned default '1',
  `minlevel_heroic` int(10) unsigned NOT NULL default '0',
  `repopx` float default '0',
  `repopy` float default '0',
  `repopz` float default '0',
  `repopentry` int(10) unsigned default '0',
  `area_name` varchar(100) character set utf8 collate utf8_unicode_ci default '0',
  `flags` int(10) unsigned NOT NULL default '0',
  `cooldown` int(10) unsigned NOT NULL default '0',
  `lvl_mod_a` int(10) unsigned NOT NULL default '0',
  `required_quest_A` int(10) unsigned NOT NULL default '0',
  `required_quest_H` int(10) unsigned NOT NULL default '0',
  `required_item` int(10) unsigned NOT NULL default '0',
  `heroic_keyid_1` int(30) NOT NULL default '0',
  `heroic_keyid_2` int(30) NOT NULL default '0',
  `viewingDistance` float NOT NULL default '80',
  `required_checkpoint` int(30) NOT NULL default '0',
  `cluster_loads_map` tinyint(1) default NULL,
  PRIMARY KEY  (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='World System';

-- ----------------------------
-- Records of worldmap_info
-- ----------------------------
INSERT INTO `worldmap_info` VALUES ('0', '4', '0', '0', '1', '0', '0', '0', '0', '0', 'Eastern Kingdoms', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('1', '3', '0', '0', '1', '0', '0', '0', '0', '0', 'Kalimdor', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('13', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Testing', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('25', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Scott Test', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('30', '104', '3', '80', '51', '0', '0', '0', '0', '0', 'Alterac Valley', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('33', '204', '2', '5', '10', '0', '-230.989', '1571.57', '76.8909', '0', 'Shadowfang Keep', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('34', '194', '2', '5', '15', '0', '-8762.38', '848.01', '89.8765', '0', 'Stormwind Stockade', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('35', '23', '0', '0', '1', '0', '-8762.48', '848.049', '87.94', '0', '<unused>StormwindPrison', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('36', '142', '2', '5', '10', '0', '-11207.8', '1681.15', '24.6245', '0', 'Deadmines', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('37', '25', '0', '0', '1', '0', '0', '0', '0', '0', 'Azshara Crater', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('42', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Collin\'s Test', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('43', '143', '2', '5', '10', '0', '-751.131', '-2209.24', '21.5403', '1', 'Wailing Caverns', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('44', '42', '2', '0', '1', '0', '2892.41', '-811.241', '160.333', '0', '<unused> Monastery', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('47', '188', '2', '5', '15', '0', '-4459.45', '-1660.21', '86.1095', '1', 'Razorfen Kraul', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('48', '196', '2', '5', '19', '0', '4249.12', '748.387', '-23.0632', '1', 'Blackfathom Deeps', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('70', '144', '2', '5', '30', '0', '-6060.18', '-2955', '266.91', '0', 'Uldaman', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('90', '193', '2', '5', '15', '0', '-5162.66', '931.599', '260.554', '0', 'Gnomeregan', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('109', '191', '2', '5', '35', '0', '-10170.1', '-3995.97', '-109.194', '0', 'Sunken Temple', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('129', '145', '2', '5', '25', '0', '-4662.88', '-2535.87', '86.9671', '1', 'Razorfen Downs', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('169', '0', '1', '40', '1', '0', '0', '0', '0', '0', 'Emerald Dream', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('189', '190', '2', '5', '20', '0', '2892.24', '-811.264', '160.333', '0', 'Scarlet Monastery', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('209', '146', '2', '5', '35', '0', '-6790.58', '-2891.28', '15.1063', '1', 'Zul\'Farrak', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('229', '189', '2', '10', '45', '0', '-7522.53', '-1233.04', '287.243', '0', 'Blackrock Spire', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('230', '103', '2', '5', '40', '0', '-7178.09', '-928.639', '170.206', '0', 'Blackrock Depths', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('249', '61', '1', '25', '80', '0', '-4753.31', '-3752.42', '53.4317', '1', 'Onyxia\'s Lair', '115', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('269', '212', '4', '5', '66', '70', '-8750.83', '-4193.51', '-210.158', '1', 'Opening of the Dark Portal', '11', '0', '0', '10284', '10284', '0', '30635', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('289', '102', '2', '5', '45', '0', '1274.78', '-2552.56', '85.3994', '0', 'Scholomance', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('309', '161', '1', '20', '50', '0', '-11916.1', '-1224.58', '64.1502', '0', 'Zul\'Gurub', '3', '259200', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('329', '101', '2', '5', '45', '0', '3392.32', '-3378.48', '112.01', '0', 'Stratholme', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('349', '81', '2', '5', '30', '0', '-1432.7', '2924.98', '85.491', '1', 'Maraudon', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('369', '205', '0', '0', '1', '0', '-8349.22', '517.348', '91.8', '0', 'Deeprun Tram', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('389', '195', '2', '5', '8', '0', '1816.76', '-4423.37', '-10.4478', '1', 'Ragefire Chasm', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('409', '192', '1', '40', '50', '0', '-7510.56', '-1036.7', '180.912', '0', 'Molten Core', '3', '604800', '0', '7848', '7848', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('429', '82', '2', '5', '45', '0', '-3908.03', '1130', '161.214', '1', 'Dire Maul', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('449', '181', '0', '0', '1', '0', '0', '0', '0', '0', 'Alliance PVP Barracks', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('450', '182', '0', '0', '1', '0', '0', '0', '0', '0', 'Horde PVP Barracks', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('451', '21', '0', '0', '1', '0', '0', '0', '0', '0', 'Development Land', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('469', '141', '1', '40', '60', '0', '-7663.41', '-1218.67', '287.798', '0', 'Blackwing Lair', '3', '604800', '0', '7761', '7761', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('489', '122', '3', '20', '10', '0', '0', '0', '0', '0', 'Warsong Gulch', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('509', '184', '1', '20', '50', '0', '-8114.46', '1526.37', '6.1904', '1', 'Ruins of Ahn\'Qiraj', '3', '259200', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('529', '183', '3', '30', '20', '0', '0', '0', '0', '0', 'Arathi Basin', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('530', '198', '0', '0', '58', '0', '0', '0', '0', '0', 'Outland', '9', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('531', '185', '1', '40', '50', '0', '-8111.72', '1526.79', '129.861', '1', 'Ahn\'Qiraj Temple', '3', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('532', '200', '1', '10', '68', '0', '-11110.4', '-2004.07', '49.3307', '0', 'Karazhan', '43', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('533', '197', '1', '25', '80', '0', '0', '0', '0', '0', 'Naxxramas', '115', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('534', '212', '1', '25', '70', '0', '-8178.51', '-4182.05', '-168.4', '1', 'The Battle for Mount Hyjal', '75', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('540', '199', '4', '5', '55', '70', '-306.758', '3064.44', '-3.73108', '530', 'Hellfire Citadel: The Shattered Halls', '13', '0', '0', '0', '0', '0', '30637', '30622', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('542', '199', '4', '5', '55', '70', '-295.419', '3151.99', '31.7029', '530', 'Hellfire Citadel: The Blood Furnace', '13', '0', '0', '0', '0', '0', '30637', '30622', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('543', '199', '4', '5', '55', '70', '-360.05', '3067.9', '-15.0364', '530', 'Hellfire Citadel: Ramparts', '13', '0', '0', '0', '0', '0', '30637', '30622', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('544', '208', '1', '25', '65', '0', '-330.234', '3106.64', '-116.502', '530', 'Magtheridon\'s Lair', '75', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('545', '207', '4', '5', '55', '70', '764.219', '6915.08', '-80.5606', '530', 'Coilfang: The Steamvault', '13', '0', '0', '0', '0', '0', '30623', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('546', '207', '4', '5', '55', '70', '764.628', '6768.07', '-72.0662', '530', 'Coilfang: The Underbog', '13', '0', '0', '0', '0', '0', '30623', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('547', '207', '4', '5', '55', '70', '742.158', '7011.33', '-73.0743', '530', 'Coilfang: The Slave Pens', '13', '0', '0', '0', '0', '0', '30623', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('548', '207', '1', '25', '70', '0', '775.786', '6865.24', '-65.9414', '530', 'Coilfang: Serpentshrine Cavern', '75', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('550', '206', '1', '25', '70', '0', '0', '0', '0', '0', 'Tempest Keep', '75', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('552', '206', '4', '5', '65', '70', '0', '0', '0', '0', 'Tempest Keep: The Arcatraz', '13', '0', '0', '0', '0', '0', '30634', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('553', '206', '4', '5', '67', '70', '0', '0', '0', '0', 'Tempest Keep: The Botanica', '13', '0', '0', '0', '0', '0', '30634', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('554', '206', '4', '5', '67', '70', '0', '0', '0', '0', 'Tempest Keep: The Mechanar', '13', '0', '0', '0', '0', '0', '30634', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('555', '201', '4', '5', '65', '70', '-3640.69', '4943.16', '-101.047', '530', 'Auchindoun: Shadow Labyrinth', '13', '0', '0', '0', '0', '0', '30633', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('556', '201', '4', '5', '55', '70', '-3361.86', '4665.59', '-101.048', '530', 'Auchindoun: Sethekk Halls', '13', '0', '0', '0', '0', '0', '30633', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('557', '201', '4', '5', '55', '70', '-3089.52', '4942.76', '-101.048', '530', 'Auchindoun: Mana-Tombs', '13', '0', '0', '0', '0', '0', '30633', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('558', '201', '4', '5', '55', '70', '-3363.44', '5156.46', '-101.048', '530', 'Auchindoun: Auchenai Crypts', '13', '0', '0', '0', '0', '0', '30633', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('559', '219', '3', '10', '10', '0', '0', '0', '0', '0', 'Nagrand Arena', '5', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('560', '212', '4', '5', '66', '70', '-8309.81', '-4061.51', '207.924', '1', 'The Escape From Durnholde', '13', '0', '0', '0', '0', '0', '30635', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('562', '218', '3', '10', '10', '0', '0', '0', '0', '0', 'Blade\'s Edge Arena', '5', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('564', '215', '1', '25', '70', '0', '-3644.53', '317.294', '36.1671', '530', 'Black Temple', '75', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('565', '213', '1', '25', '65', '0', '3525.45', '5144.15', '2.46332', '530', 'Gruul\'s Lair', '75', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('566', '210', '3', '30', '61', '0', '0', '0', '0', '0', 'Eye of the Storm', '9', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('568', '214', '1', '10', '70', '0', '6851.02', '-7989.71', '192.37', '530', 'Zul\'Aman', '43', '259200', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('571', '216', '0', '0', '68', '0', '0', '0', '0', '0', 'Northrend', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('572', '217', '3', '10', '10', '0', '0', '0', '0', '0', 'Ruins of Lordaeron', '5', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('573', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'ExteriorTest', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('574', '220', '4', '5', '68', '80', '1211.76', '-4868.42', '218.28', '571', 'Utgarde Keep', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('575', '221', '4', '5', '75', '80', '1232.41', '-4860.95', '41.2482', '571', 'Utgarde Pinnacle', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('576', '226', '4', '5', '66', '80', '3899.93', '6985.44', '69.488', '571', 'The Nexus', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('578', '227', '4', '5', '75', '80', '3865.92', '6983.94', '106.32', '571', 'The Oculus', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('580', '225', '1', '25', '70', '0', '12551.8', '-6774.57', '15.07', '530', 'The Sunwell', '75', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('582', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Rut\'theran to Auberdine', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('584', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Menethil to Theramore', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('585', '224', '4', '5', '65', '70', '12881.9', '-7343.09', '65.48', '530', 'Magister\'s Terrace', '13', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('586', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Exodar to Auberdine', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('587', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Feathermoon Ferry', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('588', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Menethil to Auberdine', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('589', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Orgrimmar to Grom\'Gol', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('590', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Grom\'Gol to Undercity', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('591', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Undercity to Orgrimmar', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('592', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Borean Tundra Test', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('593', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Booty Bay to Ratchet', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('594', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Howling Fjord Sister Mercy (Quest)', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('595', '222', '4', '5', '75', '80', '-8756.09', '-4457.42', '-205.872', '1', 'The Culling of Stratholme', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('596', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Naglfar', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('597', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Craig Test', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('598', '4', '2', '0', '1', '0', '0', '0', '0', '0', 'Sunwell Fix (Unused)', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('599', '230', '4', '5', '72', '80', '8921.79', '-966.806', '1039.26', '571', 'Halls of Stone', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('600', '228', '4', '5', '69', '80', '4774.58', '-2023.05', '229.379', '571', 'Drak\'Tharon Keep', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('601', '229', '4', '5', '67', '80', '3672.22', '2171.28', '35.8489', '571', 'Azjol-Nerub', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('602', '231', '4', '5', '75', '80', '9185.09', '-1386.79', '1108', '571', 'Halls of Lightning', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('603', '244', '1', '25', '80', '0', '9359.37', '-1115.18', '1245.15', '571', 'Ulduar', '115', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('604', '237', '4', '5', '71', '80', '6708.73', '-4654.9', '450.988', '571', 'Gundrak', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('605', '21', '0', '0', '1', '0', '0', '0', '0', '0', 'Development Land (non-weighted textures)', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('606', '21', '0', '0', '1', '0', '0', '0', '0', '0', 'QA and DVD', '0', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('607', '238', '3', '30', '71', '0', '0', '0', '0', '0', 'Strand of the Ancients', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('608', '235', '4', '5', '70', '80', '5689.49', '498.047', '159.91', '571', 'Violet Hold', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('609', '233', '0', '0', '1', '0', '0', '0', '0', '0', 'Ebon Hold', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('610', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Tirisfal to Vengeance Landing', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('612', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Menethil to Valgarde', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('613', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Orgrimmar to Warsong Hold', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('614', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Stormwind to Valiance Keep', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('615', '239', '1', '25', '80', '0', '3438.15', '260.401', '-113.289', '571', 'The Obsidian Sanctum', '115', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('616', '236', '1', '25', '80', '0', '3869.98', '6984.33', '152.042', '571', 'The Eye of Eternity', '115', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('617', '242', '3', '10', '10', '0', '0', '0', '0', '0', 'Dalaran Sewers', '5', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('618', '240', '3', '10', '10', '0', '0', '0', '0', '0', 'The Ring of Valor', '5', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('619', '234', '4', '5', '68', '80', '3641.46', '2032.06', '2.1876', '571', 'Ahn\'kahet: The Old Kingdom', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('620', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Moa\'ki to Unu\'pe', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('621', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Moa\'ki to Kamagua', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('622', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Orgrim\'s Hammer', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('623', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: The Skybreaker', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('624', '243', '1', '25', '80', '0', '5488.12', '2840.33', '419.966', '571', 'Vault of Archavon', '115', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('628', '245', '3', '80', '71', '0', '0', '0', '0', '0', 'Isle of Conquest', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('631', '250', '1', '25', '80', '80', '5776.92', '2065.93', '636.064', '571', 'Icecrown Citadel', '499', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('632', '249', '4', '5', '80', '80', '5670.79', '2003.63', '798.182', '571', 'The Forge of Souls', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('641', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Alliance Airship BG', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('642', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: HordeAirshipBG', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('647', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Orgrimmar to Thunder Bluff', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('649', '246', '1', '25', '80', '80', '8515.29', '736.137', '558.566', '571', 'Trial of the Crusader', '499', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('650', '247', '4', '5', '80', '80', '8571.43', '792.221', '558.557', '571', 'Trial of the Champion', '21', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('658', '252', '4', '5', '75', '80', '5592.06', '2010.27', '798.181', '571', 'Pit of Saron', '21', '0', '0', '24499', '24511', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('668', '253', '4', '5', '75', '80', '5628.88', '1973.29', '803.021', '571', 'Halls of Reflection', '21', '0', '0', '24710', '24712', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('672', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: The Skybreaker (Icecrown Citadel Raid)', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('673', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Orgrim\'s Hammer (Icecrown Citadel Raid)', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('712', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: The Skybreaker (IC Dungeon)', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('713', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: Orgrim\'s Hammer (IC Dungeon)', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('718', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Transport: The Mighty Wind (Icecrown Citadel Raid)', '17', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('723', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'Stormwind', '1', '0', '0', '0', '0', '0', '0', '0', '500', '0', '1');
INSERT INTO `worldmap_info` VALUES ('724', '254', '1', '25', '80', '80', '3438.15', '260.401', '-113.289', '571', 'The Ruby Sanctum', '499', '604800', '0', '0', '0', '0', '0', '0', '500', '0', '1');
