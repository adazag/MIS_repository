CREATE TABLE [data_in].[valuation_version_row_detail] (
    [id]                       BIGINT          NULL,
    [valuation_version_row_id] BIGINT          NULL,
    [month_date]               DATE            NULL,
    [fte]                      DECIMAL (12, 4) NULL,
    [man_days]                 DECIMAL (12, 4) NULL,
    [hours]                    DECIMAL (12, 4) NULL,
    [cross_charge_per_hour]    DECIMAL (9, 2)  NULL,
    [client_rate_per_hour]     DECIMAL (9, 2)  NULL,
    [creation_at]              DATETIME2 (7)   NULL,
    [modified_at]              DATETIME2 (7)   NULL,
    [created_by]               BIGINT          NULL,
    [modified_by]              BIGINT          NULL,
    [first_day_of_week]        DATE            NULL,
    [hibernate_version]        INT             NULL,
    [frozen_data]              BIT             DEFAULT ((0)) NULL
);
GO

