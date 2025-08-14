

CREATE PROCEDURE[rls].[update_org_unit_hier_full_path] AS

IF OBJECT_ID('[rls].[org_unit_hier_full_path]', 'U') IS NOT NULL TRUNCATE TABLE [rls].[org_unit_hier_full_path];

with 
hier as (
select id as EMPEE_ID, email as EMPEE_LOGIN_NAME,  
case when line_manager_id = id then null else line_manager_id end as LINE_MGR_EMPEE_ID
from data_in.org_emp_vw
where id>0 
),

emp as 
(
select EMPEE_ID, EMPEE_LOGIN_NAME, LINE_MGR_EMPEE_ID, 0 as LEVEL, cast(EMPEE_ID AS VARCHAR(255)) as PATH
from hier
where LINE_MGR_EMPEE_ID is null
union all
SELECT h.EMPEE_ID, h.EMPEE_LOGIN_NAME, h.LINE_MGR_EMPEE_ID
    , LEVEL + 1
    , CAST(PATH + '/' + CAST(h.EMPEE_ID AS VARCHAR(255)) AS VARCHAR(255))
    FROM hier h
    INNER JOIN emp e ON e.EMPEE_ID = h.LINE_MGR_EMPEE_ID
)
insert into [rls].[org_unit_hier_full_path]
SELECT * 
FROM emp
GO

GRANT EXECUTE
    ON OBJECT::[rls].[update_org_unit_hier_full_path] TO [lingaro-mis-adf]
    AS [dbo];
GO

