
CREATE view  [data_mis].[sulu_le_lkp] as
(
SELECT [id]
      ,[name]
      ,[calendar_id]
      ,[accounting_pdl]
      ,[hr_pdl]
      ,[staff_management_pld]
FROM data_in.org_legal_entity)
GO

