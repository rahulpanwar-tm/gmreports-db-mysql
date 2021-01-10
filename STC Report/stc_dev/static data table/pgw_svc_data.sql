-- --------------------------------------------------------
-- Host:                         192.168.1.231
-- Server version:               5.7.27 - MySQL Community Server (GPL)
-- Server OS:                    linux-glibc2.12
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table stc_report.pgw_svc_data
DROP TABLE IF EXISTS `pgw_svc_data`;
CREATE TABLE IF NOT EXISTS `pgw_svc_data` (
  `SERVED_IMSI` varchar(256) NOT NULL,
  `CHARGING_ID` bigint(20) NOT NULL,
  `TIME_OF_REPORT` datetime DEFAULT NULL,
  `AF_CHARGING_ID` bigint(20) DEFAULT NULL,
  `CHARGING_RULEBASE_NAME` varchar(256) DEFAULT NULL,
  `DOWNLINK_BYTES` bigint(20) DEFAULT NULL,
  `DOWNLINK_PACKETS` bigint(20) DEFAULT NULL,
  `UPLINK_BYTES` bigint(20) DEFAULT NULL,
  `UPLINK_PACKETS` bigint(20) DEFAULT NULL,
  `LOCAL_SEQUENCE_NUMBER` bigint(20) DEFAULT NULL,
  `QOS_CLASS_ID` bigint(20) DEFAULT NULL,
  `QOS_UPLINK_MBR` bigint(20) DEFAULT NULL,
  `QOS_DOWNLINK_MBR` bigint(20) DEFAULT NULL,
  `QOS_UPLINK_GBR` bigint(20) DEFAULT NULL,
  `QOS_DOWNLINK_GBR` bigint(20) DEFAULT NULL,
  `QOS_BEARER_ID` varchar(256) DEFAULT NULL,
  `ARP_PRIORITY_LEVEL` bigint(20) DEFAULT NULL,
  `ARP_P_EMPTION_CAPABILITY` bigint(20) DEFAULT NULL,
  `ARP_P_EMPTION_VULNERABILITY` bigint(20) DEFAULT NULL,
  `QOS_APN_UPLINK_AMBR` bigint(20) DEFAULT NULL,
  `QOS_APN_DOWNLINK_AMBR` bigint(20) DEFAULT NULL,
  `RATING_GROUP_QUOTA_ID` bigint(20) DEFAULT NULL,
  `CHANGE_TIME` datetime DEFAULT NULL,
  `SERVICE_DATA_FLOW_ID` varchar(50) DEFAULT NULL,
  `SERVICE_SPECIFIC_INFO` varchar(256) DEFAULT NULL,
  `SGSN_ADDRESS` varchar(256) DEFAULT NULL,
  `SERVING_NODE_ADDRESS` varchar(256) DEFAULT NULL,
  `TIME_OF_FIRST_USAGE` datetime DEFAULT NULL,
  `TIME_OF_LAST_USAGE` datetime DEFAULT NULL,
  `DURATION_SEC` bigint(20) DEFAULT NULL,
  `CHANGE_CONDITION` bigint(20) DEFAULT NULL,
  `USER_LOCATION_INFO` varchar(256) DEFAULT NULL,
  KEY `SERVED_IMSI` (`SERVED_IMSI`(255)),
  KEY `CHARGING_ID` (`CHARGING_ID`),
  KEY `SERVICE_DATA_FLOW_ID` (`SERVICE_DATA_FLOW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
