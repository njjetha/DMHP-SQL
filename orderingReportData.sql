CREATE table ReportData as
	SELECT * FROM DMHP.Reportdata_restructured order by ReportId asc,
    StateId asc,DistrictId asc,VisitType asc,Gender asc;



SET SQL_SAFE_UPDATES=0;
update DMHP.ReportData SET FacilityType=2 where MncHospitalId is not NULL;
update DMHP.ReportData SET TalukaId=MncHospitalId where TalukaId=0;
update DMHP.ReportData SET FacilityType=3 where PhcId !=0;
update DMHP.ReportData SET FacilityType=4 where ChcId !=0;
SET SQL_SAFE_UPDATES=1;

Alter Table DMHP.ReportData DROP column MncHospitalId;
Alter Table DMHP.ReportData DROP column PhcId;
Alter Table DMHP.ReportData DROP column ChcId;


SET SQL_SAFE_UPDATES=0;
update DMHP.ReportData SET TalukaId=274 where ReportId=80682 and TalukaId=0;
update DMHP.ReportData SET TalukaId=180 where ReportId=80882 and TalukaId=0;
update DMHP.ReportData SET FacilityType=1 where TalukaId=274 or TalukaId=180;
SET SQL_SAFE_UPDATES=1;

DROP TABLE DMHP.Reportdata_restructured;


SET SQL_SAFE_UPDATES=0;
update DMHP.ReportData SET ConsultType='OP' where ConsultType='IP';
update DMHP.ReportData SET ConsultType='IP' where Gender='N' and VisitType='N';
SET SQL_SAFE_UPDATES=1;
