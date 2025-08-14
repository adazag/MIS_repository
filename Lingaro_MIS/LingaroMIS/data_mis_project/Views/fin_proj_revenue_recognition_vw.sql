Create view [data_mis_project].[fin_proj_revenue_recognition_vw] as(
SELECT [project_id]
      ,[month_date]
      ,[month_name]
      ,[additional_cost]
      ,[bookings_cost]
      ,[actuals_cost]
      ,[estimated_cost_from_contract]
      ,[estimated_price_from_contract]
      ,[auto_revenue_recognition_amount]
      ,[manual_revenue_recognition_amount]
      ,[auto_revenue_recognition_percent]
      ,[manual_revenue_recognition_percent]
      ,[approved]
  FROM [data_in].[proj_revenue_recognition_vw]
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[fin_proj_revenue_recognition_vw] TO [Controling_data_read]
    AS [dbo];
GO

