CREATE DEFINER=`root`@`localhost` PROCEDURE `timeperiodbymonth`(
				IN display varchar(250),IN disease varchar(500),
				IN start_date date,IN end_date date,IN visit_type varchar(50),IN gender_string varchar(50),
				IN group_by varchar(250))
BEGIN

	DECLARE display_string VARCHAR(250);
    DECLARE agg VARCHAR(500);
    DECLARE group_by_string VARCHAR(500);
    
    SET @display_string=NULL;
    SET @group_by_string=NULL;
    SET @agg=NULL;
    
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
    
    
-- This particular if-else set will tell what to display at output of mysql..    
       
    IF(FIND_IN_SET('ReportId',display))THEN
		SET @display_string=CONCAT("ReportId");
	END IF;
        
    IF(FIND_IN_SET('DistrictId',display))THEN
		IF(@display_string is NULL)THEN
			SET @display_string=CONCAT("DistrictId");
		ELSE
			SET @display_string=CONCAT(@display_string,",DistrictId");
		END IF;
	END IF;
    
    IF(FIND_IN_SET('TalukaId',display))THEN
		IF(@display_string is NULL)THEN
			SET @display_string=CONCAT("TalukaId");
		ELSE
			SET @display_string=CONCAT(@display_string,",TalukaId");
		END IF;
	END IF;
    
    

-- This particular if-else set will find on what column group by need to be performed 


    IF(FIND_IN_SET('ReportId',group_by))THEN
		SET @group_by_string=CONCAT("ReportId");
	END IF;
    
    IF(FIND_IN_SET('DistrictId',group_by))THEN
		IF(@group_by_string is NULL)THEN
			SET @group_by_string=CONCAT("DistrictId");
		ELSE
			SET @group_by_string=CONCAT(@group_by_string,",DistrictId");
		END IF;
	END IF;
    
    IF(FIND_IN_SET('TalukaId',group_by))THEN
		IF(@group_by_string is NULL)THEN
			SET @group_by_string=CONCAT("TalukaId");
		ELSE
			SET @group_by_string=CONCAT(@group_by_string,",TalukaId");
		END IF;
	END IF;

    
    
    
    
    
	If(FIND_IN_SET('SMD',disease))THEN
		SET @agg:=CONCAT("SUM(SMD)");
	END IF;
    
    IF(FIND_IN_SET('CMD',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(CMD)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(CMD)");
		END IF;
	END IF;
    
    IF(FIND_IN_SET('SuicideAttempts',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(SuicideAttempts)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(SuicideAttempts)");
		END IF;
	END IF;
    
    IF(FIND_IN_SET('Epilepsy',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(Epilepsy)");
		ELSE
		SET @agg:=CONCAT(@agg,",SUM(Epilepsy)");
        END IF;
	END IF;    
    
    IF(FIND_IN_SET('AlcoholSubstanceAbuse',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(AlcoholSubstanceAbuse)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(AlcoholSubstanceAbuse)");
        END IF;
	END IF;    
        
    IF(FIND_IN_SET('Dementia',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(Dementia)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(Dementia)");
		END IF;
	END IF;    
    
     IF(FIND_IN_SET('DevelopmentalDisorders',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(DevelopmentalDisorders)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(DevelopmentalDisorders)");
		END IF;
	END IF;    
       
     IF(FIND_IN_SET('BehaviouralDisorders',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(BehaviouralDisorders)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(BehaviouralDisorders)");
		END IF;
	END IF;    
       
     IF(FIND_IN_SET('EmotionalDisorders',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(EmotionalDisorders)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(EmotionalDisorders)");
		END IF;
	END IF;    
       
    IF(FIND_IN_SET('PsychiatricDisorders',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(PsychiatricDisorders)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(PsychiatricDisorders)");
		END IF;
	END IF;    
    
     IF(FIND_IN_SET('Others',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(Others)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(Others)");
		END IF;
	END IF;    
       
     IF(FIND_IN_SET('Referred',disease))THEN
		IF(@agg is NULL) THEN
			SET @agg:=CONCAT("SUM(Referred)");
		ELSE
			SET @agg:=CONCAT(@agg,",SUM(Referred)");
		END IF;
	END IF;    
       
       
	SET @disease_filter := CONCAT(replace(disease,",","+"));
    
    SET @s=CONCAT("select ",@display_string,",",@agg,",sum(",@disease_filter,") as TotalCases from ReportData where ",@gender_string_filter," and ",@visit_type_filter," and ReportingMonthyear 
                BETWEEN '",start_date,"' and '",end_date,"' group by ",@group_by_string,",ReportingMonthyear");
    
    PREPARE stmt FROM @s;
    EXECUTE stmt ;
    DEALLOCATE PREPARE stmt;



END
-- call DMHP.timeperiodbymonth('ReportId', 'SMD,CMD,SuicideAttempts,Referred', '2017-03-01', '2017-09-01', "'new'", "'M'", 'ReportId');

