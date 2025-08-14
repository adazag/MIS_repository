create view data_out_ad.dic_clients as
with
tot as (
SELECT  id as ClientId
		,name as ClientName
		,account_manager_id as AccountManager
		,SALESFORCE_ID
		,ULTIMATE_PARENT_ID
		,ULTIMATE_PARENT_NAME
  FROM data_in.proj_clnt
 )

  select * 
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_clients] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_clients] TO [data_out_ad_alter_all]
    AS [dbo];
GO

