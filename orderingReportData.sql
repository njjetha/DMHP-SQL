CREATE table ReportData as
	SELECT * FROM DMHP.Reportdata_restructured order by ReportId asc,
    StateId asc,DistrictId asc,VisitType asc,Gender asc;



SET SQL_SAFE_UPDATES=0;
-- update DMHP.ReportData SET FacilityType=2 where MncHospitalId is not NULL;
update DMHP.ReportData SET TalukaId=MncHospitalId where TalukaId=0;
-- update DMHP.ReportData SET FacilityType=3 where PhcId !=0;
-- update DMHP.ReportData SET FacilityType=4 where ChcId !=0;
SET SQL_SAFE_UPDATES=1;

Alter Table DMHP.ReportData DROP column MncHospitalId;
-- Alter Table DMHP.ReportData DROP column PhcId;
-- Alter Table DMHP.ReportData DROP column ChcId;


SET SQL_SAFE_UPDATES=0;
update DMHP.ReportData SET TalukaId=274 where ReportId=80682 and TalukaId=0;
update DMHP.ReportData SET TalukaId=180 where ReportId=80882 and TalukaId=0;
--update DMHP.ReportData SET FacilityType=1 where TalukaId=274 or TalukaId=180;
SET SQL_SAFE_UPDATES=1;

DROP TABLE DMHP.Reportdata_restructured;



SET SQL_SAFE_UPDATES=0;
update DMHP.ReportData SET FacilityTypeId=1 where FacilityId in (select distinct FacilityId from tbl_facility where FacilityTypeId=1);
update DMHP.ReportData SET FacilityTypeId=2 where FacilityId in (select distinct FacilityId from tbl_facility where FacilityTypeId=2);
update DMHP.ReportData SET FacilityTypeId=3 where FacilityId in (select distinct FacilityId from tbl_facility where FacilityTypeId=3);
update DMHP.ReportData SET FacilityTypeId=8 where FacilityId is NULL;
SET SQL_SAFE_UPDATES=1;
