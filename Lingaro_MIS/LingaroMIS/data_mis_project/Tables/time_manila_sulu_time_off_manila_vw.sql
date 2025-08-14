CREATE TABLE [data_mis_project].[time_manila_sulu_time_off_manila_vw] (
    [EMPEE_ID]            FLOAT (53)     NULL,
    [EMPEE_FIRST_NAME]    NVARCHAR (50)  NULL,
    [EMPEE_LAST_NAME]     NVARCHAR (100) NULL,
    [EMPEE_ORG_UNIT_NAME] NVARCHAR (100) NULL,
    [DAY_DATE]            DATETIME2 (0)  NULL,
    [STTUS_CODE]          NVARCHAR (10)  NULL,
    [APRV_REJCT_BY]       FLOAT (53)     NULL,
    [REQ_ID]              FLOAT (53)     NULL,
    [REQ_TIME_STAMP]      DATETIME2 (6)  NULL,
    [LEAVE_TYPE_CODE]     NVARCHAR (20)  NULL,
    [SHRT_CMMNT]          NVARCHAR (100) NULL,
    [TIME_OFF_MIN_AMT]    FLOAT (53)     NULL
);
GO

