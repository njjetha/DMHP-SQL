CREATE DEFINER=`root`@`localhost` PROCEDURE `newReportdata`(IN gender_string VARCHAR(400),IN disease varchar(100),IN visit_type varchar(100),year_ INT(30))
BEGIN

		IF(gender_string='') THEN
			SET @gender_string_filter=CONCAT("Gender LIKE '%'");
		ELSE
			SET @gender_string_filter=CONCAT("Gender in (",gender_string,")");
		END IF;
      -- SET @gender_string_filter := CONCAT("'",replace(gender_string,",","','"),"'");
      SET @visit_type_filter := CONCAT("'",replace(visit_type,",","','"),"'");
	  SET @disease_filter := CONCAT(replace(disease,",","+"));
	 SET @s:=concat("select ReportId,year(ReportingMonthyear) as YEAR,",disease,",Gender,VisitType,",@disease_filter," as Total_cases 
		from ReportData where ",@gender_string_filter,
					" and (VisitType in (",@visit_type_filter,") OR ",@visit_type_filter,"='')
						and year(ReportingMonthyear)=",year_);
         
         
         
         
	PREPARE stmt FROM @s;
    EXECUTE stmt ;
    DEALLOCATE PREPARE stmt;
    
    
END


set @year_ = 2017;
call DMHP.newReportdata("", 'SMD,CMD', 'new', @year_);



---------------------------------------------------------------------------------------------------------------------------------------------------



CREATE DEFINER=`root`@`localhost` PROCEDURE `newReportdata`(IN gender_string VARCHAR(400),IN disease varchar(100),IN visit_type varchar(100),year_ INT(30))
BEGIN

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
        
      -- SET @gender_string_filter := CONCAT("'",replace(gender_string,",","','"),"'");
     --  SET @visit_type_filter := CONCAT("'",replace(visit_type,",","','"),"'");
	  SET @disease_filter := CONCAT(replace(disease,",","+"));
	 SET @s:=concat("select ReportId,year(ReportingMonthyear) as YEAR,",disease,",Gender,VisitType,",@disease_filter," as Total_cases 
		from ReportData where ",@gender_string_filter,
					" and ",@visit_type_filter," and year(ReportingMonthyear)=",year_);
         
         
         
         
	PREPARE stmt FROM @s;
    EXECUTE stmt ;
    DEALLOCATE PREPARE stmt;
    
    
END

set @year_ = 2017;
call DMHP.newReportdata("'M','N'", 'SMD,CMD',"'new','old','N'", @year_);




