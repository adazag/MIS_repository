create view data_mis_project.new_taxonomy_competency_role as(
select [id]
      ,[competency_id]
      ,[role_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from [data_in].[new_taxonomy_competency_role])
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[new_taxonomy_competency_role] TO [data_mis_project_new_taxonomy_competency_role_read_all]
    AS [dbo];
GO

