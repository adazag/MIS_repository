CREATE TABLE [data_in].[valuation_version_bm] (
    [id]                                       BIGINT          NULL,
    [valuation_version_id]                     BIGINT          NULL,
    [bm_name]                                  NVARCHAR (500)  NULL,
    [original_percentage]                      DECIMAL (9, 2)  NULL,
    [original_amount]                          DECIMAL (19, 2) NULL,
    [core_discount_percentage]                 DECIMAL (9, 2)  NULL,
    [core_discount_amount]                     DECIMAL (19, 2) NULL,
    [total_discounted_amount]                  DECIMAL (19, 2) NULL,
    [additional_discount_percentage]           DECIMAL (9, 2)  NULL,
    [additional_discount_amount]               DECIMAL (19, 2) NULL,
    [billing_date]                             DATE            NULL,
    [delivery_date]                            DATE            NULL,
    [client_approver]                          NVARCHAR (500)  NULL,
    [edited_by_user]                           BIT             NULL,
    [reinvoice_ind]                            BIT             NULL,
    [creation_at]                              DATETIME2 (7)   NULL,
    [modified_at]                              DATETIME2 (7)   NULL,
    [created_by]                               BIGINT          NULL,
    [modified_by]                              BIGINT          NULL,
    [amount_after_core_discount]               DECIMAL (19, 2) NULL,
    [total_discount_amount]                    DECIMAL (19, 2) NULL,
    [discounted_amount]                        DECIMAL (19, 2) NULL,
    [original_split_percentage_ind]            BIT             NULL,
    [additional_discount_split_percentage_ind] BIT             NULL,
    [frozen_data]                              BIT             DEFAULT ((0)) NULL
);
GO

