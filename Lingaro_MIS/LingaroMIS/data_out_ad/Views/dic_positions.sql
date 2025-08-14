
create view [data_out_ad].[dic_positions] as
with
tot as (SELECT id as PositionId, name as PositionName
  FROM [data_in].[org_emp_position] 
 )


  select *
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_positions] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_positions] TO [data_out_ad_alter_all]
    AS [dbo];
GO

