
CREATE PROCEDURE [rls].[update_org_unit_hier_full_path_split] as

IF OBJECT_ID('[rls].[org_unit_hier_full_path_split]', 'U') IS NOT NULL TRUNCATE TABLE [rls].[org_unit_hier_full_path_split];

with 

--employees lookup table 
emp as (
SELECT [id] as ID
	  ,[email] as EMAIL
FROM  data_in.org_emp_vw
WHERE id>0),

--org unit lookup table
org_unit as(
SELECT id as ORG_UNIT_ID
      ,leader_id as ORG_UNIT_LEADER_ID
FROM [data_in].[org_unit]
where end_date>='2024-01-01' or id=15 
),

--list of employees and theirs line managers
hierarchy_emp as (
SELECT --'' as "project_id"
	   a.empee_id as empee_id
	   ,a.[EMPEE_LOGIN_NAME] as empee_email
	   --,a.LINE_MGR_EMPEE_ID as manager_id
	   --,cast('01.01.1900' as date) start_date
	   --,cast('01.01.9999' as date) end_date
	   ,value as "privilege_user_id"
	   ,b.[EMPEE_LOGIN_NAME] as privilege_user_email
FROM [rls].[org_unit_hier_full_path] a
cross apply STRING_SPLIT(PATH, '/')
left join [rls].[org_unit_hier_full_path] b on value=b.empee_id
),

--Tomasz_Rębiś as (
--SELECT --'' as "project_id"
--	   a.empee_id as empee_id
--	   ,a.[EMPEE_LOGIN_NAME] as empee_email
--	   --,a.LINE_MGR_EMPEE_ID as manager_id
--	   --,cast('01.01.1900' as date) start_date
--	   --,cast('01.01.9999' as date) end_date
--	   ,41 as "privilege_user_id"
--	   ,'tomasz.rebis@lingarogroup.com' as privilege_user_email
--FROM [rls].[org_unit_hier_full_path] a
--cross apply STRING_SPLIT(PATH, '/')
--left join [rls].[org_unit_hier_full_path] b on value=b.empee_id
--where b.EMPEE_ID=688
--),


ADF_Automation_Team as (
SELECT --'' as "project_id"
	   a.empee_id as empee_id
	   ,a.[EMPEE_LOGIN_NAME] as empee_email
	   --,a.LINE_MGR_EMPEE_ID as manager_id
	   --,cast('01.01.1900' as date) start_date
	   --,cast('01.01.9999' as date) end_date
	   ,0 as "privilege_user_id"
	   ,'ADF-Automation-Team' as privilege_user_email
FROM [rls].[org_unit_hier_full_path] a
cross apply STRING_SPLIT(PATH, '/')
left join [rls].[org_unit_hier_full_path] b on value=b.empee_id
where b.EMPEE_ID=41
),

Manuel_Jun_Bote as (
SELECT --'' as "project_id"
	   a.empee_id as empee_id
	   ,a.[EMPEE_LOGIN_NAME] as empee_email
	   --,a.LINE_MGR_EMPEE_ID as manager_id
	   --,cast('01.01.1900' as date) start_date
	   --,cast('01.01.9999' as date) end_date
	   ,123874 as "privilege_user_id"
	   ,'manuel.bote@lingarogroup.com' as privilege_user_email
FROM [rls].[org_unit_hier_full_path] a
cross apply STRING_SPLIT(PATH, '/')
left join [rls].[org_unit_hier_full_path] b on value=b.empee_id
where b.EMPEE_ID=225284 
),

Total as (select *

from hierarchy_emp
union
select * from ADF_Automation_Team
union 
select * from Manuel_Jun_Bote
)

insert into [rls].[org_unit_hier_full_path_split]
select * from Total
--where  empee_id=149047
GO

GRANT EXECUTE
    ON OBJECT::[rls].[update_org_unit_hier_full_path_split] TO [lingaro-mis-adf]
    AS [dbo];
GO

