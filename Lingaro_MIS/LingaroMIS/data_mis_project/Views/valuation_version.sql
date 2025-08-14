
CREATE view [data_mis_project].[valuation_version] as
(
SELECT [id]
      ,[name]
      ,[valuation_id]
      ,[start_date]
      ,[end_date]
      ,[status]
      ,[valuation_type]
      ,[active_version]
      ,[discount_percentage]
      ,[yearly_salary_rise_percentage]
      ,[contingency_percentage]
      ,[security_percentage]
      ,[margin_percentage]
      ,[billability_percentage]
      ,[other_cost_percentage]
      ,[net_margin_percentage]
      ,[total_cost]
      ,[original_price]
      ,[discounted_price]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[version_number]
      ,[yearly_salary_rise_cost]
      ,[contingency_cost]
      ,[security_cost]
      ,[calculation_date]
      ,[delivery_leader_approve_ind]
      ,[delivery_leader_reviewer_id]
      ,[delivery_leader_review_time]
      ,[resource_manager_approve_ind]
      ,[resource_manager_reviewer_id]
      ,[resource_manager_review_time]
      ,[rejection_reason]
      ,[reopen_reason]
      ,[account_manager_approve_ind]
      ,[account_manager_reviewer_id]
      ,[account_manager_review_time]
      ,[financials_modification_date]
      ,[account_manager_approve_action_expiration_ind]
      ,[account_manager_approve_action_expiration_date]
      ,[business_case_description]
	  ,delivery_director_approve_ind 
	  ,delivery_director_reviewer_id 
	  ,delivery_director_review_time 
	  ,delivery_director_review_required
	  ,suggested_margin 

FROM [data_in].[valuation_version] vv)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version] TO [data_mis_project_valuation_version_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[valuation_version] TO [Pricing_data_read]
    AS [dbo];
GO

