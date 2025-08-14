
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [data_mis_thor].[client_rate_card] as
(
SELECT  a.[id]
      ,a.[employee_id]
      ,a.[employee_full_name]
      ,a.[project_id]
      ,a.[project_name]
      ,b.[client_id]
      ,b.name as client_name
	  ,c.ultimate_parent_id
      ,a.[rate]
      ,a.[rate_start_date]
      ,a.[rate_end_date]
      ,a.[currency_code]
      ,a.[client_rate_id]
      ,a.[client_rate_card_id]
      ,a.[client_rate_card_name]
      ,a.[comment]
      ,a.[is_manual_override]
      ,a.[modified_at]
      ,a.[modified_by]
      ,a.[creation_at]
      ,a.[created_by]
      ,a.[modifiedy_by_employee]
      ,a.[created_by_employee]
      ,a.[role_full_name]
      ,a.[current_rate_ind]
FROM  [data_in].proj_client_employee_rate_vw a
left join data_in.proj AS b ON b.project_id = a.project_id
LEFT OUTER JOIN data_in.proj_clnt c ON b.client_id = c.id
WHERE  (c.ultimate_parent_id = '0012o00002RDg2gAAD' or c.ultimate_parent_id='0012o00002RDg20AAD')
)
GO

GRANT ALTER
    ON OBJECT::[data_mis_thor].[client_rate_card] TO [data_mis_thor_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_thor].[client_rate_card] TO [data_mis_thor_read_all]
    AS [dbo];
GO

