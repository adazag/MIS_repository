CREATE PROCEDURE [rls].[update_org_unit_emp_full_path] as

IF OBJECT_ID('rls.org_unit_emp_full_path', 'U') IS NOT NULL TRUNCATE TABLE [rls].org_unit_emp_full_path;

with org as (
SELECT o.id, o.parent_id, start_date ,end_date, ou.bu_leader_id, o.leader_id, email leader_login
  FROM data_in.org_unit o
  left join data_in.org_emp e on leader_id = e.id
  left join [data_in].[org_unit_flatten] ou  on (o.id = ou.id)
  ),
tot as (
select id, start_date, end_date, bu_leader_id, leader_id, leader_login, 
cast(leader_id as varchar(255)) as leader_path
from org
where parent_id is null
union all
SELECT o.id, o.start_date, o.end_date, o.bu_leader_id, o.leader_id, o.leader_login
    , cast((leader_path + '/' + cast(o.leader_id as varchar(255))) as varchar(255))
    FROM org o
    INNER JOIN tot t ON t.id = o.parent_id
)
insert into rls.org_unit_emp_full_path
select id org_id, start_date, end_date, leader_id, bu_leader_id, leader_login, leader_path, right(leader_path, len(leader_path) - charindex((cast(bu_leader_id AS varchar)), leader_path) + 1) as leader_path_to_bu_leader

from tot;
GO

GRANT EXECUTE
    ON OBJECT::[rls].[update_org_unit_emp_full_path] TO [lingaro-mis-adf]
    AS [dbo];
GO

