-- MySQL dump 10.16  Distrib 10.1.32-MariaDB, for Linux (x86_64)
--
-- Host: mariadb    Database: craft
-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB-1~bionic

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
-- Table structure for table `ut_assetindexdata`
--

DROP TABLE IF EXISTS `ut_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `ut_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `ut_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `ut_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_assets`
--

DROP TABLE IF EXISTS `ut_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `ut_assets_folderId_idx` (`folderId`),
  KEY `ut_assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `ut_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `ut_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `ut_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_assettransformindex`
--

DROP TABLE IF EXISTS `ut_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_assettransforms`
--

DROP TABLE IF EXISTS `ut_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `ut_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_categories`
--

DROP TABLE IF EXISTS `ut_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_categories_groupId_idx` (`groupId`),
  CONSTRAINT `ut_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_categorygroups`
--

DROP TABLE IF EXISTS `ut_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `ut_categorygroups_handle_unq_idx` (`handle`),
  KEY `ut_categorygroups_structureId_idx` (`structureId`),
  KEY `ut_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `ut_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `ut_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_categorygroups_sites`
--

DROP TABLE IF EXISTS `ut_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `ut_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `ut_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_content`
--

DROP TABLE IF EXISTS `ut_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_homeHeader` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `ut_content_siteId_idx` (`siteId`),
  KEY `ut_content_title_idx` (`title`),
  CONSTRAINT `ut_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_craftidtokens`
--

DROP TABLE IF EXISTS `ut_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `ut_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_deprecationerrors`
--

DROP TABLE IF EXISTS `ut_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_elementindexsettings`
--

DROP TABLE IF EXISTS `ut_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_elements`
--

DROP TABLE IF EXISTS `ut_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `ut_elements_type_idx` (`type`),
  KEY `ut_elements_enabled_idx` (`enabled`),
  KEY `ut_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `ut_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_elements_sites`
--

DROP TABLE IF EXISTS `ut_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `ut_elements_sites_siteId_idx` (`siteId`),
  KEY `ut_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `ut_elements_sites_enabled_idx` (`enabled`),
  KEY `ut_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `ut_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_entries`
--

DROP TABLE IF EXISTS `ut_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_entries_postDate_idx` (`postDate`),
  KEY `ut_entries_expiryDate_idx` (`expiryDate`),
  KEY `ut_entries_authorId_idx` (`authorId`),
  KEY `ut_entries_sectionId_idx` (`sectionId`),
  KEY `ut_entries_typeId_idx` (`typeId`),
  CONSTRAINT `ut_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `ut_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_entrydrafts`
--

DROP TABLE IF EXISTS `ut_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `ut_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `ut_entrydrafts_siteId_idx` (`siteId`),
  KEY `ut_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `ut_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `ut_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_entrytypes`
--

DROP TABLE IF EXISTS `ut_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `ut_entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `ut_entrytypes_sectionId_idx` (`sectionId`),
  KEY `ut_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `ut_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_entryversions`
--

DROP TABLE IF EXISTS `ut_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_entryversions_sectionId_idx` (`sectionId`),
  KEY `ut_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `ut_entryversions_siteId_idx` (`siteId`),
  KEY `ut_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `ut_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `ut_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `ut_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldgroups`
--

DROP TABLE IF EXISTS `ut_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldlayoutfields`
--

DROP TABLE IF EXISTS `ut_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `ut_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `ut_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `ut_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `ut_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `ut_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldlayouts`
--

DROP TABLE IF EXISTS `ut_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldlayouttabs`
--

DROP TABLE IF EXISTS `ut_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `ut_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `ut_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fields`
--

DROP TABLE IF EXISTS `ut_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `ut_fields_groupId_idx` (`groupId`),
  KEY `ut_fields_context_idx` (`context`),
  CONSTRAINT `ut_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_globalsets`
--

DROP TABLE IF EXISTS `ut_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `ut_globalsets_handle_unq_idx` (`handle`),
  KEY `ut_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `ut_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_info`
--

DROP TABLE IF EXISTS `ut_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_matrixblocks`
--

DROP TABLE IF EXISTS `ut_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `ut_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `ut_matrixblocks_typeId_idx` (`typeId`),
  KEY `ut_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `ut_matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `ut_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `ut_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_matrixblocktypes`
--

DROP TABLE IF EXISTS `ut_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `ut_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `ut_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `ut_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `ut_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_migrations`
--

DROP TABLE IF EXISTS `ut_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_migrations_pluginId_idx` (`pluginId`),
  KEY `ut_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `ut_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `ut_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_plugins`
--

DROP TABLE IF EXISTS `ut_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_plugins_handle_unq_idx` (`handle`),
  KEY `ut_plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_queue`
--

DROP TABLE IF EXISTS `ut_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `ut_queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `ut_queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_relations`
--

DROP TABLE IF EXISTS `ut_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `ut_relations_sourceId_idx` (`sourceId`),
  KEY `ut_relations_targetId_idx` (`targetId`),
  KEY `ut_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `ut_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_resourcepaths`
--

DROP TABLE IF EXISTS `ut_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_routes`
--

DROP TABLE IF EXISTS `ut_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_routes_uriPattern_idx` (`uriPattern`),
  KEY `ut_routes_siteId_idx` (`siteId`),
  CONSTRAINT `ut_routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_searchindex`
--

DROP TABLE IF EXISTS `ut_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `ut_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sections`
--

DROP TABLE IF EXISTS `ut_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `ut_sections_name_unq_idx` (`name`),
  KEY `ut_sections_structureId_idx` (`structureId`),
  CONSTRAINT `ut_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `ut_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sections_sites`
--

DROP TABLE IF EXISTS `ut_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `ut_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `ut_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_seomatic_metabundles`
--

DROP TABLE IF EXISTS `ut_seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(64) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text,
  `metaSiteVars` text,
  `metaSitemapVars` text,
  `metaContainers` text,
  `redirectsContainer` text,
  `frontendTemplatesContainer` text,
  `metaBundleSettings` text,
  PRIMARY KEY (`id`),
  KEY `ut_seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `ut_seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `ut_seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `ut_seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `ut_seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sequences`
--

DROP TABLE IF EXISTS `ut_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sessions`
--

DROP TABLE IF EXISTS `ut_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_sessions_uid_idx` (`uid`),
  KEY `ut_sessions_token_idx` (`token`),
  KEY `ut_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `ut_sessions_userId_idx` (`userId`),
  CONSTRAINT `ut_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_shunnedmessages`
--

DROP TABLE IF EXISTS `ut_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `ut_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sitegroups`
--

DROP TABLE IF EXISTS `ut_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sites`
--

DROP TABLE IF EXISTS `ut_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_sites_handle_unq_idx` (`handle`),
  KEY `ut_sites_sortOrder_idx` (`sortOrder`),
  KEY `ut_sites_groupId_fk` (`groupId`),
  CONSTRAINT `ut_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_structureelements`
--

DROP TABLE IF EXISTS `ut_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `ut_structureelements_root_idx` (`root`),
  KEY `ut_structureelements_lft_idx` (`lft`),
  KEY `ut_structureelements_rgt_idx` (`rgt`),
  KEY `ut_structureelements_level_idx` (`level`),
  KEY `ut_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `ut_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `ut_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_structures`
--

DROP TABLE IF EXISTS `ut_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_systemmessages`
--

DROP TABLE IF EXISTS `ut_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `ut_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_systemsettings`
--

DROP TABLE IF EXISTS `ut_systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_taggroups`
--

DROP TABLE IF EXISTS `ut_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `ut_taggroups_handle_unq_idx` (`handle`),
  KEY `ut_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `ut_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_tags`
--

DROP TABLE IF EXISTS `ut_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_tags_groupId_idx` (`groupId`),
  CONSTRAINT `ut_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_templatecacheelements`
--

DROP TABLE IF EXISTS `ut_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `ut_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `ut_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `ut_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `ut_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_templatecachequeries`
--

DROP TABLE IF EXISTS `ut_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ut_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `ut_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `ut_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `ut_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_templatecaches`
--

DROP TABLE IF EXISTS `ut_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ut_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `ut_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `ut_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `ut_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_tokens`
--

DROP TABLE IF EXISTS `ut_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_tokens_token_unq_idx` (`token`),
  KEY `ut_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_usergroups`
--

DROP TABLE IF EXISTS `ut_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `ut_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_usergroups_users`
--

DROP TABLE IF EXISTS `ut_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `ut_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `ut_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpermissions`
--

DROP TABLE IF EXISTS `ut_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `ut_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `ut_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `ut_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `ut_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpermissions_users`
--

DROP TABLE IF EXISTS `ut_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `ut_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `ut_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `ut_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpreferences`
--

DROP TABLE IF EXISTS `ut_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `ut_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_users`
--

DROP TABLE IF EXISTS `ut_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_users_uid_idx` (`uid`),
  KEY `ut_users_verificationCode_idx` (`verificationCode`),
  KEY `ut_users_email_idx` (`email`),
  KEY `ut_users_username_idx` (`username`),
  KEY `ut_users_photoId_fk` (`photoId`),
  CONSTRAINT `ut_users_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `ut_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_volumefolders`
--

DROP TABLE IF EXISTS `ut_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `ut_volumefolders_parentId_idx` (`parentId`),
  KEY `ut_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `ut_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `ut_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `ut_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_volumes`
--

DROP TABLE IF EXISTS `ut_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_volumes_name_unq_idx` (`name`),
  UNIQUE KEY `ut_volumes_handle_unq_idx` (`handle`),
  KEY `ut_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `ut_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_widgets`
--

DROP TABLE IF EXISTS `ut_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_widgets_userId_idx` (`userId`),
  CONSTRAINT `ut_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'craft'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-13 21:39:36
-- MySQL dump 10.16  Distrib 10.1.32-MariaDB, for Linux (x86_64)
--
-- Host: mariadb    Database: craft
-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB-1~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `ut_assets`
--

LOCK TABLES `ut_assets` WRITE;
/*!40000 ALTER TABLE `ut_assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_assets` VALUES (3,1,1,'P8210090.jpg','image',2942,2498,396808,NULL,'2018-11-13 21:29:47','2018-11-13 21:29:48','2018-11-13 21:29:48','6c477759-a747-44c8-8fa4-432059a09352'),(4,1,1,'P8210032-2.jpg','image',1119,1144,127856,NULL,'2018-11-13 21:39:22','2018-11-13 21:39:22','2018-11-13 21:39:22','ced4e0ca-4b6a-4907-aa72-c26e16165848');
/*!40000 ALTER TABLE `ut_assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_assettransforms`
--

LOCK TABLES `ut_assettransforms` WRITE;
/*!40000 ALTER TABLE `ut_assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_categories`
--

LOCK TABLES `ut_categories` WRITE;
/*!40000 ALTER TABLE `ut_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_categorygroups`
--

LOCK TABLES `ut_categorygroups` WRITE;
/*!40000 ALTER TABLE `ut_categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_categorygroups_sites`
--

LOCK TABLES `ut_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `ut_categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_content`
--

LOCK TABLES `ut_content` WRITE;
/*!40000 ALTER TABLE `ut_content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_content` VALUES (1,1,1,NULL,'2018-11-13 20:24:20','2018-11-13 20:24:20','1736f9a4-7cf6-4380-ba03-145761733311',NULL),(2,2,1,'home','2018-11-13 20:33:10','2018-11-13 21:38:17','4fc752f3-9e7c-45b4-9fd2-00d3c2992088','<p>HELLO WORLD?</p>'),(3,3,1,'P8210090','2018-11-13 21:29:47','2018-11-13 21:29:47','795a3215-7e21-475e-9a87-b90b9c3e0030',NULL),(4,4,1,'P8210032 2','2018-11-13 21:39:22','2018-11-13 21:39:22','0522bf13-25de-4c13-b6f9-f2700973df74',NULL);
/*!40000 ALTER TABLE `ut_content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_craftidtokens`
--

LOCK TABLES `ut_craftidtokens` WRITE;
/*!40000 ALTER TABLE `ut_craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_deprecationerrors`
--

LOCK TABLES `ut_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `ut_deprecationerrors` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_deprecationerrors` VALUES (1,'includeCssFile','/var/www/html/vendor/twig/twig/lib/Twig/Parser.php:168','2018-11-13 21:37:03','/var/www/html/vendor/twig/twig/lib/Twig/Parser.php',168,'{% includeCssFile %} is now deprecated. Use {% do view.registerCssFile(\"/url/to/file.css\") %} instead.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/twig/tokenparsers/RegisterResourceTokenParser.php\",\"line\":85,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"includeCssFile\\\", \\\"{% includeCssFile %} is now deprecated. Use {% do view.registerC...\\\"\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\tokenparsers\\\\RegisterResourceTokenParser\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Parser.php\",\"line\":168,\"class\":\"craft\\\\web\\\\twig\\\\tokenparsers\\\\RegisterResourceTokenParser\",\"method\":\"parse\",\"args\":\"Twig_Token\"},{\"objectClass\":\"Twig_Parser\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Parser.php\",\"line\":81,\"class\":\"Twig_Parser\",\"method\":\"subparse\",\"args\":\"null, false\"},{\"objectClass\":\"Twig_Parser\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":533,\"class\":\"Twig_Parser\",\"method\":\"parse\",\"args\":\"Twig_TokenStream\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":565,\"class\":\"Twig_Environment\",\"method\":\"parse\",\"args\":\"Twig_TokenStream\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/twig/Environment.php\",\"line\":59,\"class\":\"Twig_Environment\",\"method\":\"compileSource\",\"args\":\"Twig_Source\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":368,\"class\":\"craft\\\\web\\\\twig\\\\Environment\",\"method\":\"compileSource\",\"args\":\"Twig_Source\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/twig/Environment.php\",\"line\":40,\"class\":\"Twig_Environment\",\"method\":\"loadTemplate\",\"args\":\"\\\"index.html\\\", null\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"craft\\\\web\\\\twig\\\\Environment\",\"method\":\"loadTemplate\",\"args\":\"\\\"index.html\\\"\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/View.php\",\"line\":331,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/View.php\",\"line\":378,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Controller.php\",\"line\":156,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Controller.php\",\"line\":104,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Application.php\",\"line\":282,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Application.php\",\"line\":271,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null}]','2018-11-13 21:37:03','2018-11-13 21:37:03','eadfb8fe-ab2d-449b-8910-1abb8bdd6b76'),(8,'ElementQuery::last()','/var/www/html/templates/index.html:2','2018-11-13 20:47:21','/var/www/html/templates/index.html',2,'The last() function used to query for elements is now deprecated. Use inReverse().one() instead.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":1416,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::last()\\\", \\\"The last() function used to query for elements is now deprecated...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\AssetQuery\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Extension/Core.php\",\"line\":1619,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"last\",\"args\":null},{\"objectClass\":null,\"file\":\"/var/www/html/vendor/craftcms/cms/src/helpers/Template.php\",\"line\":73,\"class\":null,\"method\":\"twig_get_attribute\",\"args\":\"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\AssetQuery, \\\"last\\\", ...\"},{\"objectClass\":null,\"file\":\"/var/www/html/storage/runtime/compiled_templates/79/793e91b33f7a35f37cb6b0fa773fe81c4e5657fb1ae1d284dd7dd0e141f42e8f.php\",\"line\":25,\"class\":\"craft\\\\helpers\\\\Template\",\"method\":\"attribute\",\"args\":\"craft\\\\web\\\\twig\\\\Environment, Twig_Source, craft\\\\elements\\\\db\\\\AssetQuery, \\\"last\\\", ...\"},{\"objectClass\":\"__TwigTemplate_0ba3f925187ba0be95fac07c17d0840d61e70814070265a68c497ff0932e7622\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Template.php\",\"line\":390,\"class\":\"__TwigTemplate_0ba3f925187ba0be95fac07c17d0840d61e70814070265a68c497ff0932e7622\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_0ba3f925187ba0be95fac07c17d0840d61e70814070265a68c497ff0932e7622\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":49,\"class\":\"Twig_Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_0ba3f925187ba0be95fac07c17d0840d61e70814070265a68c497ff0932e7622\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Template.php\",\"line\":367,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"SORT_ASC\\\" => 4, ...], []\"},{\"objectClass\":\"__TwigTemplate_0ba3f925187ba0be95fac07c17d0840d61e70814070265a68c497ff0932e7622\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":31,\"class\":\"Twig_Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_0ba3f925187ba0be95fac07c17d0840d61e70814070265a68c497ff0932e7622\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Template.php\",\"line\":375,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_0ba3f925187ba0be95fac07c17d0840d61e70814070265a68c497ff0932e7622\",\"file\":\"/var/www/html/vendor/twig/twig/lib/Twig/Environment.php\",\"line\":289,\"class\":\"Twig_Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/View.php\",\"line\":331,\"class\":\"Twig_Environment\",\"method\":\"render\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/View.php\",\"line\":378,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Controller.php\",\"line\":156,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"index.html\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Controller.php\",\"line\":104,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Application.php\",\"line\":282,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"index.html\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/craftcms/cms/src/web/Application.php\",\"line\":271,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/var/www/html/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null}]','2018-11-13 20:47:21','2018-11-13 20:47:21','4c91ea0a-74a0-4d90-8061-cda642b39926');
/*!40000 ALTER TABLE `ut_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_elementindexsettings`
--

LOCK TABLES `ut_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `ut_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_elements`
--

LOCK TABLES `ut_elements` WRITE;
/*!40000 ALTER TABLE `ut_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2018-11-13 20:24:20','2018-11-13 20:24:20','b0ac5a48-275f-4fca-b4ca-948824405e89'),(2,1,'craft\\elements\\Entry',1,0,'2018-11-13 20:33:10','2018-11-13 21:38:17','59259c09-ac3f-4995-8814-b91d24812f19'),(3,2,'craft\\elements\\Asset',1,0,'2018-11-13 21:29:47','2018-11-13 21:29:47','22d567f8-b4b2-478c-9108-e94e1da2476e'),(4,2,'craft\\elements\\Asset',1,0,'2018-11-13 21:39:22','2018-11-13 21:39:22','9088423d-eb4e-4f55-980d-87a2c0da60e5');
/*!40000 ALTER TABLE `ut_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_elements_sites`
--

LOCK TABLES `ut_elements_sites` WRITE;
/*!40000 ALTER TABLE `ut_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2018-11-13 20:24:20','2018-11-13 20:24:20','9bbe1dbe-5b50-4b9a-9f9f-90c3a1b73988'),(2,2,1,'home','__home__',1,'2018-11-13 20:33:10','2018-11-13 21:38:17','f87c5787-4fdc-4c32-a507-51bf09a499a2'),(3,3,1,NULL,NULL,1,'2018-11-13 21:29:47','2018-11-13 21:29:47','fbf6b522-eb19-4cd1-aa03-6219476e6a3f'),(4,4,1,NULL,NULL,1,'2018-11-13 21:39:22','2018-11-13 21:39:22','f149a74c-03e3-4e95-ae22-cf632d63ef0e');
/*!40000 ALTER TABLE `ut_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_entries`
--

LOCK TABLES `ut_entries` WRITE;
/*!40000 ALTER TABLE `ut_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_entries` VALUES (2,1,1,NULL,'2018-11-13 20:33:00',NULL,'2018-11-13 20:33:10','2018-11-13 21:38:17','217658a1-ad7b-45e9-86d3-112eea4f910c');
/*!40000 ALTER TABLE `ut_entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_entrydrafts`
--

LOCK TABLES `ut_entrydrafts` WRITE;
/*!40000 ALTER TABLE `ut_entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_entrytypes`
--

LOCK TABLES `ut_entrytypes` WRITE;
/*!40000 ALTER TABLE `ut_entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_entrytypes` VALUES (1,1,1,'home','home',0,NULL,'{section.name|raw}',1,'2018-11-13 20:33:10','2018-11-13 20:44:49','bcd6d022-cb21-4fa5-94ff-297e6150e421');
/*!40000 ALTER TABLE `ut_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_entryversions`
--

LOCK TABLES `ut_entryversions` WRITE;
/*!40000 ALTER TABLE `ut_entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_entryversions` VALUES (1,2,1,1,1,1,'Revision from Nov 13, 2018, 12:41:54 PM','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"home\",\"slug\":\"home\",\"postDate\":1542141180,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"2\":[]}}','2018-11-13 20:42:19','2018-11-13 20:42:19','6eb53b49-c645-4388-9da1-df2a5aeff78e'),(2,2,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"home\",\"slug\":\"home\",\"postDate\":1542141180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":\"<p>HELLO WORLD!</p>\",\"2\":[\"3\"]}}','2018-11-13 20:42:19','2018-11-13 20:42:19','9265c9de-e305-464d-a108-423f638b5bac'),(3,2,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"home\",\"slug\":\"home\",\"postDate\":1542141180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":\"<p>HELLO WORLD?</p>\",\"2\":[\"3\"]}}','2018-11-13 21:38:17','2018-11-13 21:38:17','e750dc1a-7ea1-4641-905a-3c146beb0c0c');
/*!40000 ALTER TABLE `ut_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldgroups`
--

LOCK TABLES `ut_fieldgroups` WRITE;
/*!40000 ALTER TABLE `ut_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldgroups` VALUES (1,'Common','2018-11-13 20:24:20','2018-11-13 20:24:20','8e1e3ea4-7013-42e8-8747-4a8a0deb1268'),(2,'Home','2018-11-13 20:33:16','2018-11-13 20:33:16','5d1ffed4-7650-4d33-99d1-b4de737dae8a');
/*!40000 ALTER TABLE `ut_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldlayoutfields`
--

LOCK TABLES `ut_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `ut_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldlayoutfields` VALUES (5,1,3,1,0,1,'2018-11-13 20:44:49','2018-11-13 20:44:49','daf122d4-2612-482e-9662-f4d957d8f3b1'),(6,1,3,2,0,2,'2018-11-13 20:44:49','2018-11-13 20:44:49','96634d24-d9c4-48dc-8ab6-c2aa69fd6a81');
/*!40000 ALTER TABLE `ut_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldlayouts`
--

LOCK TABLES `ut_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `ut_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldlayouts` VALUES (1,'craft\\elements\\Entry','2018-11-13 20:33:10','2018-11-13 20:44:49','cfd8bcc1-9650-401c-86c3-e27ca4f6ef37'),(2,'craft\\elements\\Asset','2018-11-13 20:34:10','2018-11-13 21:30:24','39dd1cea-1807-4a7d-9bef-e907e2b51c36');
/*!40000 ALTER TABLE `ut_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldlayouttabs`
--

LOCK TABLES `ut_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `ut_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldlayouttabs` VALUES (3,1,'Home',1,'2018-11-13 20:44:49','2018-11-13 20:44:49','e0c199c7-a583-4e0f-8230-0422e0972e7a');
/*!40000 ALTER TABLE `ut_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fields`
--

LOCK TABLES `ut_fields` WRITE;
/*!40000 ALTER TABLE `ut_fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fields` VALUES (1,2,'Home Header','homeHeader','global','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-11-13 20:33:44','2018-11-13 20:33:44','db35a1eb-135c-484f-8de5-9ea783a10606'),(2,2,'Home Hero Image','homeHeroImage','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-11-13 20:35:39','2018-11-13 20:35:39','d15072ab-4121-4291-8589-4b074b449970');
/*!40000 ALTER TABLE `ut_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_globalsets`
--

LOCK TABLES `ut_globalsets` WRITE;
/*!40000 ALTER TABLE `ut_globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_info`
--

LOCK TABLES `ut_info` WRITE;
/*!40000 ALTER TABLE `ut_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_info` VALUES (1,'3.0.31','3.0.94',0,'America/Los_Angeles','Craft Docker Test',1,0,'9zELH58lNUNt','2018-11-13 20:24:20','2018-11-13 20:35:39','ad10dc2f-a0a4-4b1e-8f59-67ce80d9e084');
/*!40000 ALTER TABLE `ut_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_matrixblocks`
--

LOCK TABLES `ut_matrixblocks` WRITE;
/*!40000 ALTER TABLE `ut_matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_matrixblocktypes`
--

LOCK TABLES `ut_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `ut_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_migrations`
--

LOCK TABLES `ut_migrations` WRITE;
/*!40000 ALTER TABLE `ut_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_migrations` VALUES (1,NULL,'app','Install','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','68987d19-93ab-4ebb-a508-bbfead0d73a0'),(2,NULL,'app','m150403_183908_migrations_table_changes','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','e05c6c7c-0662-4a2f-971a-ad13dd89e21d'),(3,NULL,'app','m150403_184247_plugins_table_changes','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','74165536-dbe2-4b3a-b896-b4453e42a141'),(4,NULL,'app','m150403_184533_field_version','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','df12f303-5d53-40ff-8d2b-a4c89b9b3001'),(5,NULL,'app','m150403_184729_type_columns','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','30a149df-ca5f-427a-b817-af657de297b5'),(6,NULL,'app','m150403_185142_volumes','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','90891d88-b17c-4bc7-b27c-deb75cd5d7b0'),(7,NULL,'app','m150428_231346_userpreferences','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','44e5fbbd-43e2-4226-9547-01ca53e71a78'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','5ee0ee3b-b30c-4e1a-bbf7-43f9570c146b'),(9,NULL,'app','m150617_213829_update_email_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','13008d6c-8548-493d-8761-b7bea4b0977d'),(10,NULL,'app','m150721_124739_templatecachequeries','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','9f218193-e307-46ab-81a0-f9fa6bf1fada'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','83d4a54c-7889-44ba-92a5-af298249034e'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','c645c920-960b-4df6-bfa7-1827bed1a404'),(13,NULL,'app','m151002_095935_volume_cache_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','a9177439-24f4-4afb-95de-c2cf9a5f05ac'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','8e12548f-20c0-439f-833e-38b2451f412c'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','9a4854e1-dd7f-4aaa-bece-843123e1b190'),(16,NULL,'app','m151209_000000_move_logo','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','fb2e0384-4f6a-453c-95c3-35f3425819b5'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','34886d74-d2f9-4a57-a2fe-f7c873f822d1'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','9a1b810b-d6e2-471a-bfd8-3002daf06e33'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','d1418fbe-49e6-457b-a6a8-165f8b2b48de'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','62d8294c-e0fd-43de-b005-9ebc273ed122'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','2a3ffb9f-26f8-4367-8660-fc03fa8b0c25'),(22,NULL,'app','m160727_194637_column_cleanup','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','bd683a1b-a0ab-4524-897e-2a25b8ac0be7'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','db1dc63e-bf77-41e1-b915-e8cc94805327'),(24,NULL,'app','m160807_144858_sites','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','4033f905-c54f-40a6-aff4-af609acbb638'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','a0376ade-121f-4e69-ae48-013ac5db5245'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','95933895-49c2-4dc0-9c24-777a5eddf1cc'),(27,NULL,'app','m160912_230520_require_entry_type_id','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','13f644f2-09a5-4e88-9dba-3833bb745e84'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','d117af85-46b5-4c60-9449-50bfeba91c54'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','d2dd1cd1-6980-408e-93ca-223e3a1969b1'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','2ad815fe-cff0-4d04-bcc1-12df7643e4b7'),(31,NULL,'app','m160925_113941_route_uri_parts','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','cf438a33-efbe-4321-8fd5-3df74ec43b9e'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','b8ad102b-96a9-4ee3-8270-bc6f461b28ae'),(33,NULL,'app','m161007_130653_update_email_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','b6214d57-3f43-4cba-97e8-b981cb101344'),(34,NULL,'app','m161013_175052_newParentId','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','eb5c2111-fdd9-4267-bf49-98f72d17e134'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','03c680d2-77d0-4037-abf0-93d7e37ab324'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','edb2c6d7-ad67-4e4e-b2fa-505a23752180'),(37,NULL,'app','m161025_000000_fix_char_columns','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','6d15ac90-c021-45fb-9539-8a8d8a492157'),(38,NULL,'app','m161029_124145_email_message_languages','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','31b0ce53-c0a0-42e1-9903-f2e2bb43bc95'),(39,NULL,'app','m161108_000000_new_version_format','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','070b8c2a-9650-4579-b171-e4c9ce812a89'),(40,NULL,'app','m161109_000000_index_shuffle','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','2a10a6ca-279e-4334-aa7e-5338e302e36d'),(41,NULL,'app','m161122_185500_no_craft_app','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','b2deaf79-3f04-464f-82d4-79d1d1f08462'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','325b3721-a934-4491-aff5-d8ca3baa68d5'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','51a7f949-877f-4718-8157-9e399a3add2d'),(44,NULL,'app','m170114_161144_udates_permission','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','8c0dc295-b420-49fd-8d01-198cf9632dd3'),(45,NULL,'app','m170120_000000_schema_cleanup','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','cc258b60-af80-46d9-837a-d9ad4262865c'),(46,NULL,'app','m170126_000000_assets_focal_point','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','8d284b8d-b9ca-406e-b7ed-5ecb51b7dbda'),(47,NULL,'app','m170206_142126_system_name','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','21447689-eb9c-4366-87d5-443185d155e6'),(48,NULL,'app','m170217_044740_category_branch_limits','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','488c1d19-005e-4dc6-8232-a709f8e3b12c'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','05286f17-0b61-40c3-b7fa-37006fa60369'),(50,NULL,'app','m170223_224012_plain_text_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','8ca79899-1516-42e1-80ab-57d117ac94c5'),(51,NULL,'app','m170227_120814_focal_point_percentage','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','96690ddf-0082-4328-a07f-2e54cb9c45b4'),(52,NULL,'app','m170228_171113_system_messages','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','18af638f-86d8-40f5-841e-444cc2b632bc'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','d05fb588-eff2-41bd-a4b8-0bfbbd1da882'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','7646e79b-97ef-492b-9023-f5a88e4765f5'),(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','73746a32-0a31-4f77-af43-a2bf1583e1fa'),(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','3279247d-99b4-48de-824e-05df7b77c094'),(57,NULL,'app','m170612_000000_route_index_shuffle','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','e0246e90-3769-4cfa-aedc-46c0b114ebb4'),(58,NULL,'app','m170621_195237_format_plugin_handles','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','e1558c5f-d4ce-4d38-a01c-05b86088d306'),(59,NULL,'app','m170630_161028_deprecation_changes','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','f0bc4b8d-1d80-4429-94e2-6de326a0e0fc'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','976823c4-afc5-40e0-b8b3-1d2d3f0ecfdd'),(61,NULL,'app','m170704_134916_sites_tables','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','00bae9c2-d359-47ba-bd2d-0527eb2595d1'),(62,NULL,'app','m170706_183216_rename_sequences','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','6d12eb02-5a62-4425-b02a-ab2352c5953b'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','f2c2557a-709e-4a7b-b33e-de916e0facb2'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','6816dafe-4d3f-49e6-9224-8d35df1fbf29'),(65,NULL,'app','m170810_201318_create_queue_table','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','e6e29ee8-4095-4457-a3ab-bf6fafffef9d'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','95a5af1c-5f60-49d8-a9e8-09cc2ad48210'),(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','6bf89168-640e-4577-91c8-b7694b7c1947'),(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','e768ec4e-5f54-47f0-991c-31f9697ae196'),(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','360862c6-dd6e-4cb4-a59f-15527ea107a5'),(70,NULL,'app','m171011_214115_site_groups','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','29b5c49f-f34e-4ca0-9045-013f78a2d08c'),(71,NULL,'app','m171012_151440_primary_site','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','12bf223b-3c51-440d-b476-133122c2f581'),(72,NULL,'app','m171013_142500_transform_interlace','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','151720b5-1385-4287-ac0b-c0d749f06804'),(73,NULL,'app','m171016_092553_drop_position_select','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','f359b227-54cf-41ad-a73d-41d588b44abb'),(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','4c748565-e033-4c3d-a7b1-b1fdea7cd9ab'),(75,NULL,'app','m171107_000000_assign_group_permissions','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','5e13ece4-494c-4fda-898f-7150d43683a4'),(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','c105150f-da35-40bd-b26f-39d868d5c369'),(77,NULL,'app','m171126_105927_disabled_plugins','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','235e4859-34c0-4a4e-ad5e-5ec944b3b021'),(78,NULL,'app','m171130_214407_craftidtokens_table','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','7f6a0040-09cb-4da2-91e3-bad5f4bfe78b'),(79,NULL,'app','m171202_004225_update_email_settings','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','7d8e7d73-dea7-40cf-89cd-b7b08d4f28e9'),(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','25a853ee-02b5-4de0-b570-a1a2557bc642'),(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','d5e464ef-772f-4de9-989a-0fb4b41b3788'),(82,NULL,'app','m171218_143135_longtext_query_column','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','ff42ebcd-9576-4364-a87d-353eebbc749c'),(83,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','cd711b13-3758-46e0-a83d-6aa60e3cfb43'),(84,NULL,'app','m180113_153740_drop_users_archived_column','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','5fea969a-ac2e-472e-9dc5-256e2ce3313b'),(85,NULL,'app','m180122_213433_propagate_entries_setting','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','8f07ee85-d2b6-496d-ba0a-fde112167cbb'),(86,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','388444a7-9fb9-4f65-9c9e-c36a51ca7564'),(87,NULL,'app','m180128_235202_set_tag_slugs','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','4dada742-adb2-457c-95b3-e5cb0ec64759'),(88,NULL,'app','m180202_185551_fix_focal_points','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','928f1d2b-deb0-48a0-9768-fa405d1f4277'),(89,NULL,'app','m180217_172123_tiny_ints','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','be247502-00eb-4c95-8646-74e4fc561667'),(90,NULL,'app','m180321_233505_small_ints','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','05b39610-1567-4038-b6b5-e848fef151aa'),(91,NULL,'app','m180328_115523_new_license_key_statuses','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','d39ececf-b512-4bd3-a227-14c2d488dfb6'),(92,NULL,'app','m180404_182320_edition_changes','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','fd1b6dae-1957-44e8-9081-8a3e8dc09b6a'),(93,NULL,'app','m180411_102218_fix_db_routes','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','0ea60932-e51c-42a1-9e17-66c72af73962'),(94,NULL,'app','m180416_205628_resourcepaths_table','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','1551dee4-8a1d-48b3-a022-74b58461cddb'),(95,NULL,'app','m180418_205713_widget_cleanup','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','77de9573-5e91-4122-914f-467ab837c7f4'),(96,NULL,'app','m180824_193422_case_sensitivity_fixes','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','1eb078a7-168a-486d-b113-bfb56d52d910'),(97,NULL,'app','m180901_151639_fix_matrixcontent_tables','2018-11-13 20:24:21','2018-11-13 20:24:21','2018-11-13 20:24:21','51d15c53-3342-4cda-8626-0ab02648c9fc'),(98,2,'plugin','m180430_204710_remove_old_plugins','2018-11-13 20:25:17','2018-11-13 20:25:17','2018-11-13 20:25:17','4bbd6235-dda7-4dcd-a394-fef65067a4ba'),(99,2,'plugin','Install','2018-11-13 20:25:17','2018-11-13 20:25:17','2018-11-13 20:25:17','158c5a4d-515d-4f5d-b2cc-505a18af0574'),(100,3,'plugin','Install','2018-11-13 20:25:18','2018-11-13 20:25:18','2018-11-13 20:25:18','ed1c237d-2d28-4de1-8609-5943168527e7'),(101,3,'plugin','m180314_002755_field_type','2018-11-13 20:25:18','2018-11-13 20:25:18','2018-11-13 20:25:18','2b54e88b-769c-4c87-ac44-71bf5da16674'),(102,3,'plugin','m180314_002756_base_install','2018-11-13 20:25:18','2018-11-13 20:25:18','2018-11-13 20:25:18','559ee759-1dc1-4173-8cab-70ae513dee78'),(103,3,'plugin','m180502_202319_remove_field_metabundles','2018-11-13 20:25:18','2018-11-13 20:25:18','2018-11-13 20:25:18','f8cfb5d4-5e4d-4fb7-97f5-b2dccf281911'),(104,3,'plugin','m180711_024947_commerce_products','2018-11-13 20:25:18','2018-11-13 20:25:18','2018-11-13 20:25:18','161966aa-98f8-41cb-bacb-0f783e68de10'),(105,NULL,'app','m181112_203955_sequences_table','2018-11-13 20:26:31','2018-11-13 20:26:31','2018-11-13 20:26:31','cad52724-9086-4244-aa79-eacfc1c4aaf0');
/*!40000 ALTER TABLE `ut_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_plugins`
--

LOCK TABLES `ut_plugins` WRITE;
/*!40000 ALTER TABLE `ut_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_plugins` VALUES (1,'element-api','2.5.4','1.0.0',NULL,'unknown',1,NULL,'2018-11-13 20:25:17','2018-11-13 20:25:17','2018-11-13 21:33:42','3e38ff0e-03b6-433e-b305-2a29ee509952'),(2,'redactor','2.1.6','2.0.0',NULL,'unknown',1,NULL,'2018-11-13 20:25:17','2018-11-13 20:25:17','2018-11-13 21:33:42','d5659612-5c2a-415d-b61e-bb2370918eb7'),(3,'seomatic','3.1.29','3.0.6',NULL,'invalid',1,NULL,'2018-11-13 20:25:18','2018-11-13 20:25:18','2018-11-13 21:33:42','deec676a-bc14-4e7e-9559-270298b7a8f4');
/*!40000 ALTER TABLE `ut_plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_queue`
--

LOCK TABLES `ut_queue` WRITE;
/*!40000 ALTER TABLE `ut_queue` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_queue` VALUES (8,'O:41:\"nystudio107\\seomatic\\jobs\\GenerateSitemap\":6:{s:7:\"groupId\";s:1:\"1\";s:4:\"type\";s:7:\"section\";s:6:\"handle\";s:4:\"home\";s:6:\"siteId\";i:1;s:11:\"description\";N;s:30:\"\0craft\\queue\\BaseJob\0_progress\";i:0;}','Generating home sitemap',1542141739,300,0,1024,NULL,NULL,0,1,1,'2018-11-13 20:42:20','Argument 1 passed to craft\\helpers\\UrlHelper::isAbsoluteUrl() must be of the type string, null given, called in /var/www/html/vendor/nystudio107/craft-seomatic/src/helpers/UrlHelper.php on line 68'),(12,'O:41:\"nystudio107\\seomatic\\jobs\\GenerateSitemap\":6:{s:7:\"groupId\";s:1:\"1\";s:4:\"type\";s:7:\"section\";s:6:\"handle\";s:4:\"home\";s:6:\"siteId\";i:1;s:11:\"description\";N;s:30:\"\0craft\\queue\\BaseJob\0_progress\";i:0;}','Generating home sitemap',1542141889,300,0,1024,NULL,NULL,0,1,1,'2018-11-13 20:44:50','Argument 1 passed to craft\\helpers\\UrlHelper::isAbsoluteUrl() must be of the type string, null given, called in /var/www/html/vendor/nystudio107/craft-seomatic/src/helpers/UrlHelper.php on line 68'),(14,'O:41:\"nystudio107\\seomatic\\jobs\\GenerateSitemap\":6:{s:7:\"groupId\";s:1:\"1\";s:4:\"type\";s:7:\"section\";s:6:\"handle\";s:4:\"home\";s:6:\"siteId\";i:1;s:11:\"description\";N;s:30:\"\0craft\\queue\\BaseJob\0_progress\";i:0;}','Generating home sitemap',1542141954,300,0,1024,NULL,NULL,0,1,1,'2018-11-13 20:45:54','Argument 1 passed to craft\\helpers\\UrlHelper::isAbsoluteUrl() must be of the type string, null given, called in /var/www/html/vendor/nystudio107/craft-seomatic/src/helpers/UrlHelper.php on line 68');
/*!40000 ALTER TABLE `ut_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_relations`
--

LOCK TABLES `ut_relations` WRITE;
/*!40000 ALTER TABLE `ut_relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_relations` VALUES (2,2,2,NULL,3,1,'2018-11-13 21:38:17','2018-11-13 21:38:17','f36bd518-941f-48c6-b332-179e77bc31bf');
/*!40000 ALTER TABLE `ut_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_resourcepaths`
--

LOCK TABLES `ut_resourcepaths` WRITE;
/*!40000 ALTER TABLE `ut_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_resourcepaths` VALUES ('19c193c9','@lib/fabric'),('1f6b65','@craft/web/assets/fields/dist'),('20277166','@craft/web/assets/utilities/dist'),('280dd910','@craft/web/assets/tablesettings/dist'),('297771de','@lib/fileupload'),('2b46457f','@vendor/craftcms/redactor/lib/redactor'),('319f7020','@lib/picturefill'),('34bd466b','@lib/prismjs'),('363b4ce2','@lib/jquery-touch-events'),('372f6f59','@nystudio107/seomatic/assetbundles/seomatic/dist'),('3f3a5071','@lib/d3'),('5072415b','@lib/timepicker'),('561cd8ff','@craft/redactor/assets/field/dist'),('57d2940c','@craft/web/assets/updater/dist'),('5e11d253','@craft/web/assets/recententries/dist'),('60ab903d','@craft/web/assets/updateswidget/dist'),('65e15da4','@lib/selectize'),('6f8d192e','@lib/xregexp'),('73ae79d1','@craft/web/assets/pluginstore/dist'),('7ad549ac','@craft/web/assets/cp/dist'),('81517dbb','@craft/web/assets/dashboard/dist'),('851f8d5f','@lib'),('92a5e752','@lib/element-resize-detector'),('9696f80f','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),('9e9b9ed7','@craft/web/assets/matrixsettings/dist'),('a1c302e9','@vendor/craftcms/redactor/lib/redactor-plugins/video'),('a1f7bfbb','@craft/web/assets/editentry/dist'),('acbabbda','@lib/velocity'),('b09d1432','@lib/jquery.payment'),('bd354ca7','@bower/jquery/dist'),('c7076634','@craft/web/assets/craftsupport/dist'),('c8747f7','@lib/garnishjs'),('cd904138','@craft/web/assets/dbbackup/dist'),('cf01d1f9','@craft/web/assets/login/dist'),('e213207f','@lib/jquery-ui'),('f8125b70','@craft/web/assets/feed/dist');
/*!40000 ALTER TABLE `ut_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_routes`
--

LOCK TABLES `ut_routes` WRITE;
/*!40000 ALTER TABLE `ut_routes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_routes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_searchindex`
--

LOCK TABLES `ut_searchindex` WRITE;
/*!40000 ALTER TABLE `ut_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' tech ninebarcreative com '),(1,'slug',0,1,''),(2,'slug',0,1,' home '),(2,'title',0,1,' home '),(2,'field',1,1,' hello world '),(2,'field',2,1,' p8210090 '),(3,'filename',0,1,' p8210090 jpg '),(3,'extension',0,1,' jpg '),(3,'kind',0,1,' image '),(3,'slug',0,1,''),(3,'title',0,1,' p8210090 '),(4,'filename',0,1,' p8210032 2 jpg '),(4,'extension',0,1,' jpg '),(4,'kind',0,1,' image '),(4,'slug',0,1,''),(4,'title',0,1,' p8210032 2 ');
/*!40000 ALTER TABLE `ut_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sections`
--

LOCK TABLES `ut_sections` WRITE;
/*!40000 ALTER TABLE `ut_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sections` VALUES (1,NULL,'home','home','single',1,1,'2018-11-13 20:33:10','2018-11-13 20:44:49','6853aaa8-90c8-496a-8376-9a79f37ad404');
/*!40000 ALTER TABLE `ut_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sections_sites`
--

LOCK TABLES `ut_sections_sites` WRITE;
/*!40000 ALTER TABLE `ut_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sections_sites` VALUES (1,1,1,1,'__home__','index.html',1,'2018-11-13 20:33:10','2018-11-13 20:44:49','0cfd2827-e023-44e9-a9b2-5e2bd1f0ac0d');
/*!40000 ALTER TABLE `ut_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_seomatic_metabundles`
--

LOCK TABLES `ut_seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `ut_seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_seomatic_metabundles` VALUES (1,'2018-11-13 20:25:18','2018-11-13 20:25:18','c4e1e72f-729f-4c64-af93-1e26008c63d9','1.0.39','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','',1,'[]','2018-11-13 20:25:18','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft Docker Test\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"no-referrer-when-downgrade\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ siteUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ url(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not craft.app.request.isLivePreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not craft.app.request.isLivePreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dl\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not craft.app.request.isLivePreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"required name={seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraftCMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(2,'2018-11-13 20:33:10','2018-11-13 21:38:17','056c1444-3533-433c-9b2f-1eb5a0846860','1.0.27','section',1,'home','home','single','index.twig',1,'{\"1\":{\"id\":1,\"sectionId\":null,\"siteId\":\"1\",\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"home\",\"template\":\"index.twig\",\"language\":\"en\"}}','2018-11-13 21:38:17','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft Docker Test\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"required name={seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
/*!40000 ALTER TABLE `ut_seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sequences`
--

LOCK TABLES `ut_sequences` WRITE;
/*!40000 ALTER TABLE `ut_sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_shunnedmessages`
--

LOCK TABLES `ut_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `ut_shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sitegroups`
--

LOCK TABLES `ut_sitegroups` WRITE;
/*!40000 ALTER TABLE `ut_sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sitegroups` VALUES (1,'Craft Docker Test','2018-11-13 20:24:20','2018-11-13 20:24:20','42d7f6c5-1c01-41fc-9bb1-ca70e357ead9');
/*!40000 ALTER TABLE `ut_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sites`
--

LOCK TABLES `ut_sites` WRITE;
/*!40000 ALTER TABLE `ut_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sites` VALUES (1,1,1,'Craft Docker Test','default','en',1,'@web/',1,'2018-11-13 20:24:20','2018-11-13 20:24:20','87b3b133-7fe8-4f71-838e-432ef39a747d');
/*!40000 ALTER TABLE `ut_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_structureelements`
--

LOCK TABLES `ut_structureelements` WRITE;
/*!40000 ALTER TABLE `ut_structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_structures`
--

LOCK TABLES `ut_structures` WRITE;
/*!40000 ALTER TABLE `ut_structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_systemmessages`
--

LOCK TABLES `ut_systemmessages` WRITE;
/*!40000 ALTER TABLE `ut_systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_systemsettings`
--

LOCK TABLES `ut_systemsettings` WRITE;
/*!40000 ALTER TABLE `ut_systemsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_systemsettings` VALUES (1,'email','{\"fromEmail\":\"tech@ninebarcreative.com\",\"fromName\":\"Craft Docker Test\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"}','2018-11-13 20:24:21','2018-11-13 20:24:21','58325aaf-7109-4007-b39f-8fce4523b202');
/*!40000 ALTER TABLE `ut_systemsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_taggroups`
--

LOCK TABLES `ut_taggroups` WRITE;
/*!40000 ALTER TABLE `ut_taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_tags`
--

LOCK TABLES `ut_tags` WRITE;
/*!40000 ALTER TABLE `ut_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_templatecachequeries`
--

LOCK TABLES `ut_templatecachequeries` WRITE;
/*!40000 ALTER TABLE `ut_templatecachequeries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_tokens`
--

LOCK TABLES `ut_tokens` WRITE;
/*!40000 ALTER TABLE `ut_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_usergroups`
--

LOCK TABLES `ut_usergroups` WRITE;
/*!40000 ALTER TABLE `ut_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_usergroups_users`
--

LOCK TABLES `ut_usergroups_users` WRITE;
/*!40000 ALTER TABLE `ut_usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpermissions`
--

LOCK TABLES `ut_userpermissions` WRITE;
/*!40000 ALTER TABLE `ut_userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpermissions_usergroups`
--

LOCK TABLES `ut_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `ut_userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpermissions_users`
--

LOCK TABLES `ut_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `ut_userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpreferences`
--

LOCK TABLES `ut_userpreferences` WRITE;
/*!40000 ALTER TABLE `ut_userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_userpreferences` VALUES (1,'{\"language\":\"en\"}');
/*!40000 ALTER TABLE `ut_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_users`
--

LOCK TABLES `ut_users` WRITE;
/*!40000 ALTER TABLE `ut_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_users` VALUES (1,'admin',NULL,NULL,NULL,'tech@ninebarcreative.com','$2y$13$deJ7f04b6UOeEKi1Rp4m6.o3NM/Kf7ETz0WM82/77QwAb1DLNW8/a',1,0,0,0,'2018-11-13 21:39:06','172.19.0.1',NULL,NULL,'2018-11-13 21:27:53',NULL,1,NULL,NULL,NULL,0,'2018-11-13 20:24:20','2018-11-13 20:24:20','2018-11-13 21:39:06','7c9eed04-cd4d-4a69-8281-9fce3c8bc383');
/*!40000 ALTER TABLE `ut_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_volumefolders`
--

LOCK TABLES `ut_volumefolders` WRITE;
/*!40000 ALTER TABLE `ut_volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_volumefolders` VALUES (1,NULL,1,'Assets','','2018-11-13 20:34:10','2018-11-13 20:34:10','e6af7591-3ec7-4111-8ac6-e7ab9a96653c'),(2,NULL,NULL,'Temporary source',NULL,'2018-11-13 20:34:30','2018-11-13 20:34:30','181a6c23-85cf-4875-9821-6bd7d74352bd'),(3,2,NULL,'user_1','user_1/','2018-11-13 20:34:30','2018-11-13 20:34:30','585a24a2-bcfe-4d21-8d8c-2ea645689b4e');
/*!40000 ALTER TABLE `ut_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_volumes`
--

LOCK TABLES `ut_volumes` WRITE;
/*!40000 ALTER TABLE `ut_volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_volumes` VALUES (1,2,'Assets','assets','craft\\volumes\\Local',1,'@web/assets','{\"path\":\"@webroot/assets\"}',1,'2018-11-13 20:34:10','2018-11-13 21:30:24','8afcfb26-f952-44d5-85af-72265d4737ca');
/*!40000 ALTER TABLE `ut_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_widgets`
--

LOCK TABLES `ut_widgets` WRITE;
/*!40000 ALTER TABLE `ut_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-11-13 20:26:39','2018-11-13 20:26:39','6d9709c3-859d-4c74-9f0f-6a981a10119c'),(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-11-13 20:26:39','2018-11-13 20:26:39','7ee71e1e-215d-48c4-a00e-590e7d5590a1'),(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2018-11-13 20:26:39','2018-11-13 20:26:39','37ed2c1a-7ead-46ca-9149-23031bfb9b8b'),(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-11-13 20:26:39','2018-11-13 20:26:39','c214c215-96fb-43f8-b6f7-d62e3ad2928d');
/*!40000 ALTER TABLE `ut_widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'craft'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-13 21:39:36
