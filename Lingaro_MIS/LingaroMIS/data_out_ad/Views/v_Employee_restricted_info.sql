
CREATE view  data_out_ad.v_Employee_restricted_info as 
SELECT [employee_id]
      --,[emergency_phone_number]
      --,[emergency_contact_type_id]
      --,[postal_code_id]
      ,[private_email]
  FROM [data_in].[employee_restricted_info]
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Employee_restricted_info] TO [sa-ITAssetsManagement@lingarogroup.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Employee_restricted_info] TO [HR365@lingaro.onmicrosoft.com]
    AS [dbo];
GO

