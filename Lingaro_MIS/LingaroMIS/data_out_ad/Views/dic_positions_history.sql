create view data_out_ad.dic_positions_history as
with
tot as (SELECT [id]
      ,[employee_id]
      ,[position_id]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
  FROM [data_in].[org_employee_position] 
 )

  select *
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_positions_history] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_positions_history] TO [data_out_ad_read_all]
    AS [dbo];
GO

