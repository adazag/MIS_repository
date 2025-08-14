create view [data_mis_project].[valuation_version_row] as (
SELECT [id]
      ,[valuation_version_id]
      ,[primary_employee_id]
      ,[secondary_employee_id]
      ,[client_rate_card_id]
      ,[role_id]
      ,[client_employee_rate_id]
      ,[on_call_hours_per_day]
      ,[margin]
      ,[country_id]
      ,[competency]
      ,[family]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[comment]
      ,[total_man_days]
      ,[cost_type]
      ,[client_rate_per_hour]
      ,[cross_charge_per_hour]
      ,[value_based_on_rate_card]
      ,[total_cost]
      ,[competency_id]
      ,[seniority_id]
      ,[any_location_ind]
      ,[financials_modification_date]
      ,[custom_discount_percentage]
      ,[custom_client_rate_per_hour]
      ,[converted_custom_client_rate_per_hour]
      ,[custom_margin]
      ,[custom_client_rate_comment]
      ,[resource_row_id]
      ,[last_resource_row_sync_date_time]
FROM [data_in].[valuation_version_row] )
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_row] TO [data_mis_project_valuation_version_row_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_row] TO [Pricing_data_read]
    AS [dbo];
GO

