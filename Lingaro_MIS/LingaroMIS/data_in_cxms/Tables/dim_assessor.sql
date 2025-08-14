CREATE TABLE [data_in_cxms].[dim_assessor] (
    [assessor_id]      INT           NULL,
    [first_name]       NVARCHAR (50) NULL,
    [last_name]        NVARCHAR (50) NULL,
    [customer_id]      INT           NULL,
    [assessor_email]   NVARCHAR (50) NULL,
    [status]           VARCHAR (20)  NULL,
    [active]           BIT           NULL,
    [reason]           VARCHAR (200) NULL,
    [reason_set_date]  DATETIME      NULL,
    [location]         NVARCHAR (50) NULL,
    [service_line]     VARCHAR (250) NULL,
    [service_category] VARCHAR (250) NULL
);
GO

