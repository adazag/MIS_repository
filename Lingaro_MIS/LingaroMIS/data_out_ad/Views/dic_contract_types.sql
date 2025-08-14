create view data_out_ad.dic_contract_types as
with
tot as (SELECT id as ContractTypeId, code as ContractTypeCode, name as ContractTypeName
  FROM [data_in].[org_contract_type] 
 )

  select *
  from tot
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_contract_types] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_contract_types] TO [data_out_ad_alter_all]
    AS [dbo];
GO

