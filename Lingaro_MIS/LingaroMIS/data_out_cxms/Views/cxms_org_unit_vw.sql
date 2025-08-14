CREATE view [data_out_cxms].[cxms_org_unit_vw] as (
    select a.id, a.name, a.parent_id, a.start_date, a.end_date, a.unit_level as level, a.leader_id,CONCAT(b.first_name,' ',b.last_name) as leader_name, a.type
    from data_in.org_unit a
    left join data_in.org_emp b on a.leader_id  = b.id);
GO

GRANT SELECT
    ON OBJECT::[data_out_cxms].[cxms_org_unit_vw] TO [data_out_cxms_read_all]
    AS [dbo];
GO

