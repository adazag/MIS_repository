CREATE view [data_mis_project].[valuation] as
(
SELECT [id]
      ,[name]
      ,[project_id]
      ,[invoicing_type_code]
      ,[owner_id]
      ,[client_id]
      ,[offer_currency_code]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[rate_card_id]
      ,[custom_exchange_rate]
      ,[custom_exchange_rate_comment]
	  ,opportunity_id
FROM [data_in].[valuation]
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation] TO [data_mis_project_valuation_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation] TO [Pricing_data_read]
    AS [dbo];
GO

