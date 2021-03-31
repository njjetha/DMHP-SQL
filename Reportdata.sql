CREATE TABLE DMHP.Reportdata as
	SELECT ReportId,StateId,DistrictId,TalukaId,ReportingMonthyear,'old'as Visit_Type,'M' as Gender,
		old_smd_male as smd,old_cmd_male as cmd ,old_alcohal_male as alcohal, 
			old_male_suicidecases as suicidecases from DMHP.tbl_reportdata
        
						UNION ALL
	SELECT ReportId,StateId,DistrictId,TalukaId,ReportingMonthyear,'old'as Visit_Type,'F' as Gender,
		old_smd_female as smd,old_cmd_female as cmd ,old_alcohal_female as alcohal, 
			old_female_suicidecases as suicidecases from DMHP.tbl_reportdata
        
						UNION ALL
        
	SELECT ReportId,StateId,DistrictId,TalukaId,ReportingMonthyear,'new'as Visit_Type,'M' as Gender,
		new_smd_male as smd,new_cmd_male as cmd ,new_alcohal_male as alcohal, 
			new_male_suicidecases as suicidecases from DMHP.tbl_reportdata
        
						UNION ALL
	SELECT ReportId,StateId,DistrictId,TalukaId,ReportingMonthyear,'new'as Visit_Type,'F' as Gender,
		new_smd_female as smd,new_cmd_female as cmd ,new_alcohal_female as alcohal, 
			new_female_suicidecases as suicidecases from DMHP.tbl_reportdata;