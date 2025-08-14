create view data_out_ad.dic_roles_history as 
with
tot as (SELECT [id]
      ,[employee_id]
      ,[role_name]
      ,[start_date]
      ,[end_date]
  FROM [data_in].[org_emp_old_role] 
 )

  select *
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_roles_history] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_roles_history] TO [data_out_ad_alter_all]
    AS [dbo];
GO

