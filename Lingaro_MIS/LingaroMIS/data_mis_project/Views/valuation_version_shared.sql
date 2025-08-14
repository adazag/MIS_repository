
CREATE view [data_mis_project].[valuation_version_shared] as (
SELECT  [id]
      ,[valuation_version_id]
      ,[shared_to_employee_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by] 
FROM data_in.valuation_version_shared 
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_shared] TO [Pricing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_shared] TO [data_mis_project_valuation_version_shared_read_all]
    AS [dbo];
GO

