CREATE TABLE [data_in].[proj_revenue_recognition_vw] (
    [project_id]                         BIGINT          NULL,
    [month_date]                         VARCHAR (100)   NULL,
    [month_name]                         NVARCHAR (4000) NULL,
    [additional_cost]                    DECIMAL (38, 6) NULL,
    [bookings_cost]                      DECIMAL (38, 2) NULL,
    [actuals_cost]                       DECIMAL (38, 2) NULL,
    [estimated_cost_from_contract]       DECIMAL (18, 2) NULL,
    [estimated_price_from_contract]      DECIMAL (18, 2) NULL,
    [auto_revenue_recognition_amount]    DECIMAL (18, 2) NULL,
    [manual_revenue_recognition_amount]  DECIMAL (18, 2) NULL,
    [auto_revenue_recognition_percent]   DECIMAL (18, 2) NULL,
    [manual_revenue_recognition_percent] DECIMAL (18, 2) NULL,
    [approved]                           BIT             NULL
);
GO

