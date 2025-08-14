





CREATE view [data_out_cxms].[cxms_proj_org_unit_rel_vw] as (
select  p.project_id,
		p.name as project_name,
		c.id as client_id,
		c.name as client_name,
		client_contact_name as clen_proj_mgr_name,
		p.start_date,
		p.end_date,
		p.status_code as project_status_code,
		pu.organization_unit_id as org_unit_id,
		invoicing_name as proj_invc_info_name,
		cnct.id as clen_cntct_id,
		email_text as clen_proj_mgr_email,
		proj.BUSINESS_UNIT_NAME as bus_unit_name
from data_in.proj_org_unit pu
left join data_in.proj p on p.project_id = pu.project_id
join data_in.proj_clnt c on c.id = p.client_id
left join data_mis.proj proj on pu.project_id = proj.project_id
left join [data_in].[proj] projvw on projvw.project_id = p.project_id
left join [data_in].[proj] lkp  on lkp.project_id = p.project_id
left join [data_in].[proj_client_contact] cnct on cnct.id = lkp.client_contact_id
where pu.current_ind = 1 
)
GO

GRANT SELECT
    ON OBJECT::[data_out_cxms].[cxms_proj_org_unit_rel_vw] TO [data_out_cxms_read_all]
    AS [dbo];
GO

