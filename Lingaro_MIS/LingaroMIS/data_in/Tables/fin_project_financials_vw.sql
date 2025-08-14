CREATE TABLE [data_in].[fin_project_financials_vw] (
    [project_id]                              BIGINT          NULL,
    [day_date]                                DATE            NULL,
    [actuals_cost]                            DECIMAL (38, 6) NULL,
    [bookings_cost]                           DECIMAL (38, 6) NULL,
    [additional_cost]                         DECIMAL (38, 6) NULL,
    [additional_fund]                         DECIMAL (38, 6) NULL,
    [position_net_amount_after_discount_pln]  DECIMAL (38, 6) NULL,
    [bm_after_discount_amount_pln]            DECIMAL (38, 6) NULL,
    [bm_before_discount_amount_pln]           DECIMAL (38, 6) NULL,
    [position_net_amount_discount_pln]        DECIMAL (38, 6) NULL,
    [bm_additional_discount_amount_pln]       DECIMAL (38, 6) NULL,
    [position_net_amount_before_discount_pln] DECIMAL (38, 6) NULL,
    [bm_basic_discount_amount_pln]            DECIMAL (38, 6) NULL
);
GO

