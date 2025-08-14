

CREATE view [data_mis_project].[sulu_proj_sched_fct] as (
select [id]
      ,[project_id]
      ,[name]
      ,[start_date]
      ,[end_date]
      ,[task_type]
      ,[task_status]
      ,[display_order]
      ,[created_by]
      ,[modified_by]
      ,[creation_at]
      ,[modified_at] from data_in.proj_project_schedule)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[sulu_proj_sched_fct] TO [data_mis_project_sulu_proj_sched_fct_read_all]
    AS [dbo];
GO

