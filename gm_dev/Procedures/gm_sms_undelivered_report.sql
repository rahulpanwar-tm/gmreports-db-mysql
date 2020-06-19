-- --------------------------------------------------------
-- Host:                         192.168.1.122
-- Server version:               10.1.12-MariaDB - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for procedure gm_reports.gm_sms_undelivered_report
DROP PROCEDURE IF EXISTS `gm_sms_undelivered_report`;
DELIMITER //
CREATE  PROCEDURE `gm_sms_undelivered_report`(IN `in_start_date` varchar(50), IN `in_end_date` varchar(50)















, IN `in_account_id` VARCHAR(50))
    COMMENT 'gm_sms_undelivered_report_new'
BEGIN
  -- **********************************************************************
  -- Procedure: gm_sms_undelivered_report_new
  -- Author: Parul Shrivastava
  -- Date: Nov 1, 2019
  
  -- Inputs: in_start_date,in_end_date
  -- Output: This procedure is returns the undelivered sms report on the basis
  -- of the final time and sms status 
  -- Description: Procedure returns the sms undelivered report genarted 
  -- **********************************************************************

	 -- Declaring the variables 
 	 DECLARE date_duration VARCHAR(50);
 	 DECLARE start_date VARCHAR(50);

    SET start_date:= CAST(in_start_date AS date);
   

	 -- preparing the billing dates 
    SET date_duration= LAST_DAY(CONVERT( in_start_date, DATE ));
    SET @temp_date = DATE_SUB(in_start_date,INTERVAL DAYOFMONTH(in_start_date)-1 DAY);
	 -- select concat(@temp_date ,' - ',date_duration);
	
	-- preparing the reports data from the different table on the basis of the SMS type and time 
   SELECT 
	report_metadata.ICCID as ICCID,
	report_metadata.MSISDN as MSISDN,
	report_metadata.IMSI as IMSI,
 --  report_metadata.MNO_ACCOUNTID as SUPPLIER_ACCOUNT_ID ,
-- 	concat(@temp_date ,' - ',date_duration) AS BILLING_CYCLE_DATE,
	 gm_country_code_mapping.country_Code AS SUPPLIER_ACCOUNT_ID ,
   '5' AS BILLING_CYCLE_DATE,
	cdr_sms_details.SMS_TYPE AS CALL_DIRECTION,
	-- report_metadata.WHOLE_SALE_NAME AS PLAN,
	wholesale_plan_history.NEW_VALUE AS PLAN,
   cdr_sms_details.SENT_TIME AS ORIGINATION_DATE,
   /*cdr_sms_details.ORIGINATION_GT AS SERVING_SWITCH,
	cdr_sms_details.SOURCE AS ORIGINATION_ADDRESS ,
   cdr_sms_details.DESTINATION AS DESTINATION_ADDRESS,
	cdr_sms_details.SUBSCRIBER_IMSI AS OPERATOR_NETWORK,*/
	 case when cdr_sms_details.SMS_TYPE='MO' then cdr_sms_details.ORIGINATION_GT
	when cdr_sms_details.SMS_TYPE='MT' then cdr_sms_details.DESTINATION_GT 
	else cdr_sms_details.ORIGINATION_GT end AS SERVING_SWITCH,
	case when cdr_sms_details.SMS_TYPE='MO' then cdr_sms_details.SOURCE
	when cdr_sms_details.SMS_TYPE='MT' then cdr_sms_details.DESTINATION
	else cdr_sms_details.SOURCE end  AS ORIGINATION_ADDRESS ,
   case when cdr_sms_details.SMS_TYPE='MO' then cdr_sms_details.DESTINATION
	when cdr_sms_details.SMS_TYPE='MT' then cdr_sms_details.SOURCE
	else cdr_sms_details.DESTINATION end AS DESTINATION_ADDRESS,
    -- cdr_sms_details.DESTINATION_GT,
	  case when cdr_sms_details.SMS_TYPE='MO' then cdr_sms_details.ORIGINATION_GT
	when cdr_sms_details.SMS_TYPE='MT' then cdr_sms_details.DESTINATION_GT
	else cdr_sms_details.DESTINATION end  AS OPERATOR_NETWORK,
   cdr_sms_details.REASON AS CALL_TERMINATIONS_REASON
	FROM (report_metadata
	INNER JOIN cdr_sms_details
	ON report_metadata.MSISDN = cdr_sms_details.SOURCE 
	OR report_metadata.MSISDN = cdr_sms_details.DESTINATION
	left join gm_country_code_mapping on report_metadata.ACCOUNT_COUNTRIE=gm_country_code_mapping.account
	left join wholesale_plan_history on wholesale_plan_history.IMSI=report_metadata.IMSI
	and (cdr_sms_details.FINAL_TIME between  wholesale_plan_history.CREATE_DATE and wholesale_plan_history.CREATE_DATE))	
   WHERE date(cdr_sms_details.FINAL_TIME)=start_date
   and cdr_sms_details.SMS_STATUS ='Failed'
   and report_metadata.MNO_ACCOUNTID=in_account_id
   GROUP BY IMSI,MSISDN ,CALL_DIRECTION ,  ORIGINATION_DATE ;
   
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
