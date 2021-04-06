select (dm.SUBJECT_ID) as subject_id, (dm.HADM_ID) as hadm_id ,cast(admittime as date) as Time_of_Admit, cast(dischtime as date) as Time_of_Discharge, 
case 
when dm.Admission_Type = 'NEWBORN' then 1 
when dm.Admission_Type = 'URGENT' then 2 
when dm.Admission_Type = 'ELECTIVE' then 3 
when dm.Admission_Type = 'EMERGENCY' then 4 
end adm_type , 
case 
when dm.Marital_Status = 'SINGLE' then 1 
when dm.Marital_Status = 'DIVORCED' then 2 
when dm.Marital_Status = 'LIFE PARTNER' then 3 
when dm.Marital_Status = 'WIDOWED' then 4 
when dm.Marital_Status = 'MARRIED' then 5 
when dm.Marital_Status = 'SEPARATED' then 6 
when dm.Marital_Status = 'UNKNOWN (DEFAULT)' then 7 
else 7 
end Marital_Status, 
case 
when dm.Insurance = 'Government' then 1 
when dm.Insurance = 'Medicaid' then 2 
when dm.Insurance = 'Medicare' then 3 
when dm.Insurance = 'Private' then 4 
when dm.Insurance= 'Self Pay' then 5 
end insurance_type, 
case 
when dm.Admission_Location = 'PHYS REFERRAL/NORMAL DELI' then 0 
when dm.Admission_Location = 'TRANSFER FROM OTHER HEALT' then 1 
when dm.Admission_Location = 'TRANSFER FROM SKILLED NUR' then 2 
when dm.Admission_Location ='TRANSFER FROM HOSP/EXTRAM' then 3 
when dm.Admission_Location ='TRSF WITHIN THIS FACILITY' then 4 
when dm.Admission_Location = '** INFO NOT AVAILABLE **' then 5 
when dm.Admission_Location ='CLINIC REFERRAL/PREMATURE' then 6 
when dm.Admission_Location ='HMO REFERRAL/SICK' then 7 
when dm.Admission_Location ='EMERGENCY ROOM ADMIT' then 8 
end adm_location, 
case 
when dm.Religion = 'METHODIST' then 1 
when dm.Religion = 'HINDU' then 2
when dm.Religion = 'EPISCOPALIAN' then 3 
when dm.Religion = 'MUSLIM' then 4 
when dm.Religion = 'PROTESTANT QUAKER' then 5 
when dm.Religion = 'UNITARIAN-UNIVERSALIST' then 6 
when dm.Religion = 'CHRISTIAN SCIENTIST' then 7 
when dm.Religion = 'GREEK ORTHODOX' then 8 
when dm.Religion= 'CATHOLIC' then 9 
when dm.Religion = 'HEBREW' then 10 
when dm.Religion = 'UNOBTAINABLE' then 11 
when dm.Religion = 'JEHOVAH''S WITNESS' then 12 
when dm.Religion = 'JEWISH' then 13 
when dm.Religion = 'ROMANIAN EAST. ORTH' then 14 
when dm.Religion = 'OTHER'then 15 
when dm.Religion = '7TH DAY ADVENTIST' then 16 
when dm.Religion = 'BUDDHIST' then 17 
when dm.Religion = 'BAPTIST' then 18 
when dm.Religion = 'NOT SPECIFIED' then 19 
when dm.Religion = 'LUTHERAN' then 20 
else 19 
end religion_type, 
case when dm.Ethnicity ='ASIAN - CAMBODIAN' then 1 
when dm.Ethnicity ='ASIAN - THAI' then 1
when dm.Ethnicity ='AMERICAN INDIAN/ALASKA NATIVE' then 5
when dm.Ethnicity ='MULTI RACE ETHNICITY' then 5 
when dm.Ethnicity ='HISPANIC/LATINO - HONDURAN' then 2 
when dm.Ethnicity ='HISPANIC/LATINO - COLOMBIAN' then 2 
when dm.Ethnicity ='ASIAN - ASIAN INDIAN' then 1
when dm.Ethnicity ='HISPANIC/LATINO - DOMINICAN' then 2 
when dm.Ethnicity='UNKNOWN/NOT SPECIFIED' then 5 
when dm.Ethnicity= 'SOUTH AMERICAN' then 5 
when dm.Ethnicity ='HISPANIC/LATINO - PUERTO RICAN' then 2 
when dm.Ethnicity= 'AMERICAN INDIAN/ALASKA NATIVE FEDERALLY RECOGNIZED TRIBE' then 5 
when dm.Ethnicity ='BLACK/HAITIAN' then 4 
when dm.Ethnicity ='HISPANIC OR LATINO' then 2 
when dm.Ethnicity ='HISPANIC/LATINO - SALVADORAN' then 2 
when dm.Ethnicity='ASIAN' then 1
when dm.Ethnicity ='NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER' then 5 
when dm.Ethnicity ='WHITE - BRAZILIAN' then 3 
when dm.Ethnicity = 'WHITE' then 3 
when dm.Ethnicity='HISPANIC/LATINO - MEXICAN' then 2 
when dm.Ethnicity ='WHITE - OTHER EUROPEAN' then 3 
when dm.Ethnicity ='ASIAN - OTHER'then 1 
when dm.Ethnicity ='ASIAN - KOREAN' then 1
when dm.Ethnicity ='PATIENT DECLINED TO ANSWER' then 5 
when dm.Ethnicity ='UNABLE TO OBTAIN' then 5
when dm.Ethnicity ='HISPANIC/LATINO - CENTRAL AMERICAN (OTHER)' then 2 
when dm.Ethnicity = 'HISPANIC/LATINO - GUATEMALAN'then 2 
when dm.Ethnicity ='BLACK/AFRICAN' then 4 
when dm.Ethnicity ='PORTUGUESE' then 5 
when dm.Ethnicity = 'ASIAN - CHINESE' then 1
when dm.Ethnicity= 'BLACK/AFRICAN AMERICAN' then 4 
when dm.Ethnicity = 'WHITE - RUSSIAN'then 3 
when dm.Ethnicity= 'ASIAN - FILIPINO'then 1 
when dm.Ethnicity='BLACK/CAPE VERDEAN' then 4 
when dm.Ethnicity='CARIBBEAN ISLAND' then 5 
when dm.Ethnicity = 'OTHER' then 5 
when dm.Ethnicity = 'WHITE - EASTERN EUROPEAN' then 3 
when dm.Ethnicity ='MIDDLE EASTERN' then 5 
when dm.Ethnicity = 'HISPANIC/LATINO - CUBAN' then 2 
when dm.Ethnicity ='ASIAN - JAPANESE' then 1 
when dm.Ethnicity= 'ASIAN - VIETNAMESE'then 1 
else 5 
end as Ethnicity 
into #admissions 
 from dbo.ADMISSIONS dm 
where DIAGNOSIS like '%coronary%' 
select * from #admissions

select p.[SUBJECT_ID] subject_id, cast(DOB AS DATE) AS DOB, 
case 
when p.[GENDER] = 'F' then 0 
when p.[GENDER] = 'M' then 1 
end gender
INTO #patients
from [dbo].[PATIENTS] p 
SELECT * from #patients

SELECT a. * , p.DOB, p.[GENDER] 
into #patients1 
FROM #admissions a
inner join #patients p on a.subject_id = p.subject_id 
select * from #patients1

select *, datediff(year, DOB, Time_of_Admit) as AGE, datediff(d, Time_of_Admit, Time_of_Discharge) as Length_of_stay 
into #patients2 
from #patients1 
select * from #patients2

SELECT * 
into #patients3 
from #patients2 
WHERE AGE != 300 and AGE!>300 
SELECT *FROM #patients3

select subject_id as SUBJECT_ID, hadm_id as HADM_ID, AVG(CAST(cpt_number as int)) as CPT_NUMBER, 
case 
when costcenter = 'ICU' then 1 else 0 
end as Cost_Center 
into #cpt_events 
from dbo.CPTEVENTS group by subject_id,hadm_id,costcenter 
SELECT * FROM #cpt_events

select SUBJECT_ID as subject_id, HADM_ID as hadm_id, FIRST_WARDID as first_wardid, LAST_WARDID as last_wardid, 
case 
when FIRST_CAREUNIT = 'TSICU' then 1 
when FIRST_CAREUNIT = 'CSRU' then 2 
when FIRST_CAREUNIT = 'SICU' then 3 
when FIRST_CAREUNIT = 'MICU' then 4 
when FIRST_CAREUNIT = 'CCU' then 5 
when FIRST_CAREUNIT = 'NICU' then 6 
end first_careunit, 
case 
when LAST_CAREUNIT ='TSICU' then 1 
when LAST_CAREUNIT = 'CSRU' then 2 
when LAST_CAREUNIT = 'SICU' then 3 
when LAST_CAREUNIT = 'MICU' then 4 
when LAST_CAREUNIT = 'CCU' then 5 
when LAST_CAREUNIT = 'NICU' then 6 
end last_careunit 
into #icu_stays 
FROM [dbo].[ICUSTAYS] 
select * from #icu_stays

select ["SUBJECT_ID"] as subject_id, ["HADM_ID"] as hadm_id, 
case 
when ["PREV_SERVICE"] = 'NB' then 1 
when ["PREV_SERVICE"] = 'NSURG' then 2 
when ["PREV_SERVICE"] = 'GU' then 3 
when ["PREV_SERVICE"] = 'TSURG' then 4 
when ["PREV_SERVICE"] = 'ENT' then 5 
when ["PREV_SERVICE"] = 'TRAUM' then 6 
when ["PREV_SERVICE"] = 'NMED' then 7 
when ["PREV_SERVICE"] = 'OMED' then 8 
when ["PREV_SERVICE"] = 'ORTHO' then 9 
when ["PREV_SERVICE"] = 'GYN' then 10 
when ["PREV_SERVICE"]= 'CSURG' then 11 
when ["PREV_SERVICE"] = 'PSYCH' then 12 
when ["PREV_SERVICE"] = 'OBS' then 13 
when ["PREV_SERVICE"] = 'PSURG' then 14 
when ["PREV_SERVICE"] = 'NBB' then 15 
when ["PREV_SERVICE"] = 'MED' then 16 
when ["PREV_SERVICE"] = 'DENT' then 17 
when ["PREV_SERVICE"] = 'CMED' then 18 
when ["PREV_SERVICE"] = 'VSURG' then 19 
when ["PREV_SERVICE"] = 'SURG' then 20
else 0 
end previous_service , 
case 
when ["CURR_SERVICE"] = 'NB' then 1 
when ["CURR_SERVICE"] = 'NSURG' then 2 
when ["CURR_SERVICE"] = 'GU' then 3 
when ["CURR_SERVICE"]= 'TSURG' then 4 
when ["CURR_SERVICE"] = 'ENT' then 5 
when ["CURR_SERVICE"] = 'TRAUM' then 6 
when ["CURR_SERVICE"] = 'NMED'then 7 
when ["CURR_SERVICE"] = 'OMED' then 8 
when ["CURR_SERVICE"] = 'ORTHO' then 9 
when ["CURR_SERVICE"] = 'GYN' then 10 
when ["CURR_SERVICE"] = 'CSURG' then 11 
when ["CURR_SERVICE"] = 'PSYCH' then 12 
when ["CURR_SERVICE"] = 'OBS' then 13 
when ["CURR_SERVICE"] = 'PSURG' then 14 
when ["CURR_SERVICE"] = 'NBB' then 15 
when ["CURR_SERVICE"] = 'MED' then 16 
when ["CURR_SERVICE"] = 'DENT' then 17 
when ["CURR_SERVICE"] = 'CMED' then 18 
when ["CURR_SERVICE"] = 'VSURG' then 19 
when ["CURR_SERVICE"] = 'SURG' then 20 
else 0 
end current_service 
into #services 
from [dbo].[SERVICES]
select * from #services

select x.*, s.first_wardid as Firstward_id , s.last_wardid as Lastward_id, s.first_careunit as Firstcare_unit, s.last_careunit as Lastcare_unit 
into #final 
from #patients3 x 
inner join #icu_stays s 
on x.SUBJECT_ID = s.subject_id and x.HADM_ID = s.hadm_id
select * from #final

select distinct f.*, s.previous_service as previous_service, s.current_service as current_service 
into #final1
from #final f
inner join #services s on f.subject_id = s.subject_id and f.HADM_ID = s.hadm_id
select * from #final1

select f.*, y.Cost_Center as COST_NUMBER, y.CPT_NUMBER as Cpt_Number 
into #final2 
from #final1 f 
inner join #cpt_events y on f.subject_id = y.subject_id and f.hadm_id = y.HADM_ID
select * from #final2

select f.*, 
case 
when f.Length_of_stay >= 8 then 1 
else 0 
end as FINAL_LENGTHOFSTAY 
into Finalproject
from #final2 f
select * from Finalproject


