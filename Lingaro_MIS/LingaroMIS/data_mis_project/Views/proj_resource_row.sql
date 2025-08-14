

CREATE view [data_mis_project].[proj_resource_row] as (
select[id]
      ,[project_id]
      ,[name]
      ,[version_number]
      ,[source]
      ,[status]
      ,[start_date]
      ,[end_date]
      ,[country_id]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[owner_id]
      ,[valuation_version_id]
      ,[total_man_days]
      ,[competency_role_rate_per_hour]
      ,[total_cost]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[on_hold_ind]
      ,[comment]
      ,[cc_owner_id]
      ,[any_location_ind]
      ,[valuation_version_row_id]
      ,[demand_type]
      ,[cancel_reason]
      ,[hiring_id]
	  ,[previous_owner_id]
from [data_in].[proj_resource_row]
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_resource_row] TO [data_mis_project_proj_resource_row_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_resource_row] TO [Resourcing_data_read]
    AS [dbo];
GO

