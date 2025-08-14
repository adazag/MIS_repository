create view data_out_ad.dic_business_units as 
with
tot as (
SELECT id as BusinessUnitId
		,name as BusinessUnitName
		,parent_id as ParentId
		,start_date
		,end_date
FROM [data_in].[org_unit] 
where unit_level = 2
)


  select * 
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_business_units] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_business_units] TO [data_out_ad_alter_all]
    AS [dbo];
GO

