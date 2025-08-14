
CREATE view [data_mis_project].[valuation_version_bm] as
(
SELECT [id]
      ,[valuation_version_id]
      ,[bm_name]
      ,[original_percentage]
      ,[original_amount]
      ,[core_discount_percentage]
      ,[core_discount_amount]
      ,[total_discounted_amount]
      ,[additional_discount_percentage]
      ,[additional_discount_amount]
      ,[billing_date]
      ,[delivery_date]
      ,[client_approver]
      ,[edited_by_user]
      ,[reinvoice_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[amount_after_core_discount]
      ,[total_discount_amount]
      ,[discounted_amount]
      ,[original_split_percentage_ind]
      ,[additional_discount_split_percentage_ind]
FROM data_in.valuation_version_bm 
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_bm] TO [Pricing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version_bm] TO [data_mis_project_valuation_version_bm_read_all]
    AS [dbo];
GO

