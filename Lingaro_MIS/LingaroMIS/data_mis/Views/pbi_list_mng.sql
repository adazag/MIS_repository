

CREATE view [data_mis].[pbi_list_mng] AS

select line_manager_id ID, '1' IS_MANAGER from data_in.org_emp_vw
UNION
select functional_manager_id, '1' IS_MANAGER from data_in.org_emp_vw
UNION 
select manager_id ID, '1' IS_MANAGER from data_in.proj
UNION
select manager_id ID, '1' IS_MANAGER from data_in.proj
GO

