
CREATE VIEW [data_out_ad].[v_Employee_TimeOff]
AS
SELECT        id AS Id, request_id AS RequestId, employee_id AS EmployeeId, day_date AS TimeOffDayDate, approval_status AS TimeOffApprovalStatus, created_at AS TimeOffCreated, time_off_type AS TimeOffType, 
                         time_off_minutes AS TimeOffMinutes, assigned_minutes AS TimeOffMinutesAssigned
FROM            data_out_ad.org_emp_time_off
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Employee_TimeOff] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Employee_TimeOff] TO [data_out_ad_read_all]
    AS [dbo];
GO

