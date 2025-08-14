CREATE SECURITY POLICY [rls].[sp_org_unit_test]
    ADD FILTER PREDICATE [rls].[fn_org_unit_test]([org_unit_id]) ON [data_mis_rls].[timesheet_data]
    WITH (STATE = ON);
GO

