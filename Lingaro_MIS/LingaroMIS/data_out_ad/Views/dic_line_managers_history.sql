
create view  data_out_ad.dic_line_managers_history as
with
tot as (SELECT [id]
      ,[employee_id]
      ,[line_manager_id]
      ,[start_date]
      ,[end_date]
  FROM [data_in].[org_emp_line_manager_history] 
 )

  select *
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_line_managers_history] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_line_managers_history] TO [data_out_ad_read_all]
    AS [dbo];
GO

