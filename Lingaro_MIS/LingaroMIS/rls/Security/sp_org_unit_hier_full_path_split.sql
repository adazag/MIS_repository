CREATE SECURITY POLICY [rls].[sp_org_unit_hier_full_path_split]
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[tmsht_time_report_vw],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[org_emp_position_history],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([id]) ON [data_mis_rls].[org_emp_vw],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[org_emp_education],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[org_emp_work_experience_industry_knowledge],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[org_emp_work_experience],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[org_emp_about],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[org_used_time_off_limit_report_vw],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[proj_empee_bookg_daily_vw],
    ADD FILTER PREDICATE [rls].[fn_org_unit_hier_full_path_split]([employee_id]) ON [data_mis_rls].[tmsht_pm_approval]
    WITH (STATE = ON);
GO

