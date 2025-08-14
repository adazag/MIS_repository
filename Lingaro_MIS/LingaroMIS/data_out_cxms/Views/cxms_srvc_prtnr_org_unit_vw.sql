

CREATE VIEW [data_out_cxms].[cxms_srvc_prtnr_org_unit_vw] as
select e.email as partner_email,
u.organization_unit_id as org_unit_id
from data_in.org_emp e
left join data_in.org_emp_org_unit u
on e.id = u.employee_id
where u.end_date is null 
and technical_account_ind = 0
GO

GRANT SELECT
    ON OBJECT::[data_out_cxms].[cxms_srvc_prtnr_org_unit_vw] TO [data_out_cxms_read_all]
    AS [dbo];
GO

