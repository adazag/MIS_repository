create view data_out_cxms.cxms_emp_stts as (
select distinct id as empee_id
		,first_name as empee_first_name
		,last_name as empee_last_name
		,email as empee_email
		,active_ind as status
		,line_manager_id as line_mgr_empee_id 
from data_in.org_emp



)
GO

