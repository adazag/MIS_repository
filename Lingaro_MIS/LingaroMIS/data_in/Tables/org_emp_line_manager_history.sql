CREATE TABLE [data_in].[org_emp_line_manager_history] (
    [id]              BIGINT NOT NULL,
    [employee_id]     BIGINT NOT NULL,
    [line_manager_id] BIGINT NOT NULL,
    [start_date]      DATE   NOT NULL,
    [end_date]        DATE   NULL
);
GO

