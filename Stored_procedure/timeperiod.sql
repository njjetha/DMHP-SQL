CREATE DEFINER=`root`@`localhost` PROCEDURE `timeperiod`(IN start_date date,IN end_date date,IN group_by varchar(100),
						IN gender_string varchar(256),IN visit_type varchar(100),disease varchar(500))
BEGIN

	DECLARE display VARCHAR(150);
   -- SET start_date=CONCAT("'",start_date,"'");
    -- SET end_date=CONCAT("'",end_date,"'");
    
	IF(gender_string='') THEN
		SET @gender_string_filter=CONCAT("Gender LIKE '%'");
	ELSE
		SET @gender_string_filter=CONCAT("Gender in (",gender_string,")");
	END IF; 
    
    
	IF(visit_type='')THEN
		SET @visit_type_filter=CONCAT("VisitType LIKE '%'");
	ELSE 
		SET @visit_type_filter=CONCAT("VisitType in (",visit_type,")");
	END IF;
    
    
    if(FIND_IN_SET('SMD',disease))THEN
		SET @display:=CONCAT("SUM(SMD)");
	END IF;
    
    IF(FIND_IN_SET('CMD',disease))THEN
		SET @display:=CONCAT(@display,",SUM(CMD)");
	END IF;
	-- SET @s:=CONCAT("SELECT * from ReportData where ReportingMonthyear >=",start_date,
		-- 			" and ReportingMonthyear <=",end_date);
    
    SET @s :=concat("SELECT ReportingMonthyear,",@display," from ReportData 
				where ",@gender_string_filter," and ",@visit_type_filter," and ReportingMonthyear 
                BETWEEN '",start_date,"' and '",end_date,"' group by ReportingMonthyear");
    
    
    
	PREPARE stmt FROM @s;
    EXECUTE stmt ;
    DEALLOCATE PREPARE stmt;
END
