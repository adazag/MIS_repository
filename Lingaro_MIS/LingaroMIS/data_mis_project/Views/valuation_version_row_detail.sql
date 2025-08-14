
CREATE VIEW [data_mis_project].[valuation_version_row_detail] as
(
SELECT [id]
      ,[valuation_version_row_id]
      ,[month_date]
      ,[fte]
      ,[man_days]
      ,[hours]
      ,[cross_charge_per_hour]
      ,[client_rate_per_hour]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[first_day_of_week]
      ,[hibernate_version]
FROM data_in.valuation_version_row_detail 
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_row_detail] TO [data_mis_project_valuation_version_row_detail_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_row_detail] TO [Pricing_data_read]
    AS [dbo];
GO

