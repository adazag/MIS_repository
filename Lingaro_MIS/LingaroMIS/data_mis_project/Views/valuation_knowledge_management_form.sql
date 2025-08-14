create view data_mis_project.valuation_knowledge_management_form as
SELECT [id]
      ,[valuation_version_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[valuation_knowledge_management_form]
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_knowledge_management_form] TO [data_mis_project_valuation_knowledge_management_form_read_all]
    AS [dbo];
GO

