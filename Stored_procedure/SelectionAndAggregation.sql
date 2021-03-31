CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectionAndAggregation`(IN group_by varchar(250),IN visit_type varchar(50),IN gender_string varchar(50),IN disease varchar(500))
BEGIN
	
    DECLARE display VARCHAR(250);
    DECLARE agg VARCHAR(500);
    
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
    
    IF(FIND_IN_SET('ReportId',group_by))THEN
		SET @display=CONCAT("ReportId");
	END IF;
    
    
    IF(FIND_IN_SET('DistricId',group_by))THEN
		SET @display=CONCAT(@display,",DistrictId");
	END IF;
    
    IF(FIND_IN_SET('TalukaId',group_by))THEN
		SET @display=CONCAT(@display,",TalukaId");
	END IF;
    
    
    
    
	If(FIND_IN_SET('SMD',disease))THEN
		SET @agg:=CONCAT("SUM(SMD)");
	END IF;
    
    IF(FIND_IN_SET('CMD',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(CMD)");
	END IF;
    
    IF(FIND_IN_SET('SuicideAttempts',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(SuicideAttempts)");
	END IF;
    
    IF(FIND_IN_SET('Epilepsy',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(Epilepsy)");
	END IF;    
    
    IF(FIND_IN_SET('AlcoholSubstanceAbuse',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(AlcoholSubstanceAbuse)");
	END IF;    
        
    IF(FIND_IN_SET('Dementia',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(Dementia)");
	END IF;    
    
     IF(FIND_IN_SET('DevelopmentalDisorders',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(DevelopmentalDisorders)");
	END IF;    
       
     IF(FIND_IN_SET('BehaviouralDisorders',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(BehaviouralDisorders)");
	END IF;    
       
     IF(FIND_IN_SET('EmotionalDisorders',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(EmotionalDisorders)");
	END IF;    
       
    IF(FIND_IN_SET('PsychiatricDisorders',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(PsychiatricDisorders)");
	END IF;    
    
     IF(FIND_IN_SET('Others',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(Others)");
	END IF;    
       
     IF(FIND_IN_SET('Referred',disease))THEN
		SET @agg:=CONCAT(@agg,",SUM(Referred)");
	END IF;    
       
    
    SET @s=CONCAT("select ",@display,",",@agg," from ReportData where ",@gender_string_filter," and ",@visit_type_filter," group 
				by ",@display);
    
    PREPARE stmt FROM @s;
    EXECUTE stmt ;
    DEALLOCATE PREPARE stmt;

END
