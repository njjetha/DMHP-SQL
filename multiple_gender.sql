CREATE DEFINER=`root`@`localhost` PROCEDURE `newReportdata`(IN gender_string VARCHAR(400),IN disease varchar(100),IN visit_type varchar(100),year_ INT(30))
BEGIN
      -- SET @gender_string_filter := CONCAT("'",replace(gender_string,",","','"),"'");
      SET @visit_type_filter := CONCAT("'",replace(visit_type,",","','"),"'");
	  SET @disease_filter := CONCAT(replace(disease,",","+"));
	 SET @s:=concat("select ReportId,year(ReportingMonthyear) as YEAR,",disease,",Gender,VisitType,",@disease_filter," as Total_cases 
		from ReportData where (Gender in (",gender_string,")) 
					and (VisitType in (",@visit_type_filter,") OR ",@visit_type_filter,"='')
						and year(ReportingMonthyear)=",year_);
         
         
         
         
	PREPARE stmt FROM @s;
    EXECUTE stmt ;
    DEALLOCATE PREPARE stmt;
    
    
END
