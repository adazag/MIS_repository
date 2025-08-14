
CREATE view [data_mis_project].[proj_client_employee_rate] as
(
select [id]
      ,[employee_id]
      ,[project_id]
      ,[currency_code]
      ,[rate_start_date]
      ,[rate_end_date]
      ,[rate]
      ,[comment]
      ,[client_id]
      ,[client_rate_id]
      ,[client_rate_card_id]
      ,[is_manual_override]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by] from data_in.proj_client_employee_rate)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_client_employee_rate] TO [data_mis_project_proj_client_employee_rate_read_all]
    AS [dbo];
GO

