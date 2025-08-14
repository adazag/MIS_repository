
CREATE view [data_mis_project].[proj_contract_vw] as (
select [id]
      ,[name]
      ,[project_id]
      ,[type]
      ,[client_contract_number]
      ,[internal_contract_number]
      ,[sign_date]
      ,[estimated_revenue]
      ,[estimated_margin]
      ,[estimated_cost]
      ,[storage_link]
      ,[currency_code]
      ,[modified_at]
      ,[modified_by]
      ,[creation_at]
      ,[created_by]
      ,[modifiedy_by_employee]
      ,[created_by_employee]
      ,[valuation_id]
      ,[version_number]
      ,[valuation_name] from [data_in].[proj_contract_vw])
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_contract_vw] TO [Pricing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_contract_vw] TO [data_mis_project_proj_contract_vw_read_all]
    AS [dbo];
GO

