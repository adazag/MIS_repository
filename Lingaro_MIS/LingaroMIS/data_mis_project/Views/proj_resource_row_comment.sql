create view data_mis_project.proj_resource_row_comment as (
select [id]
      ,[resource_row_id]
      ,[employee_id]
      ,[text]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[log]
from [data_in].[proj_resource_row_comment]
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_resource_row_comment] TO [data_mis_project_proj_resource_row_comment_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_resource_row_comment] TO [Resourcing_data_read]
    AS [dbo];
GO

