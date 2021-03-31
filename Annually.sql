CREATE DEFINER=`root`@`localhost` PROCEDURE `Annually`(disease varchar(20),year_ INT,district varchar(20))
BEGIN

declare cases varchar(30);
declare district_ varchar(30);


IF disease='Alcohal' THEN
	SET @cases="sum(new_alcohal_male+
						new_alcohal_female+
							old_alcohal_male+
								old_alcohal_female)";
							
END IF;

IF disease='Suicide' THEN
	SET @cases="sum(old_male_suicidecases+
						old_female_suicidecases+
							new_male_suicidecases+
								new_female_suicidecases)";
END IF;


IF disease='SMD' THEN
	SET @cases="sum(old_smd_male+
					old_smd_female+
						new_smd_female+
							new_smd_male)";
	END IF;


IF district='' THEN
	SET @district_="%";
ELSE
	SET @district_=district;
END IF;

-- SET @year_="2020";

SET @s=CONCAT("select d.District as Districtid ,
	year(c.ReportingMonthyear),",
	@cases, 
	" as total_cases
   from DMHP.tbl_reportdata c , DMHP.Districts d  where d.DistrictId = c.Districtid and year(c.ReportingMonthyear)=",@year_,
    "  and d.District LIKE '",@district_,"' group by year(c.ReportingMonthyear) ,d.District order by total_cases");
    
    
    
PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END
