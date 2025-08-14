
CREATE view [data_mis_project].[valuation_version_bm_total_amount] as
(
SELECT [valuation_version_id]
      ,[total_amount] FROM data_in.valuation_version_bm_total_amount 
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_bm_total_amount] TO [Pricing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_bm_total_amount] TO [data_mis_project_valuation_version_bm_total_amount_read_all]
    AS [dbo];
GO

