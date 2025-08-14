
CREATE view [data_mis].[employee_industry_knowledge] as (
select 
	[id]
	,[employee_id]
	,[industry_knowledge_id]
	,[creation_at]
	,[modified_at]
	,[created_by]
	,[modified_by]
from data_in.employee_industry_knowledge)
GO

