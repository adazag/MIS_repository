CREATE TABLE [data_in].[proj_answer] (
    [id]              BIGINT          NULL,
    [form_id]         BIGINT          NULL,
    [question_id]     BIGINT          NULL,
    [type]            NVARCHAR (255)  NULL,
    [value]           NVARCHAR (4000) NULL,
    [custom_answer]   NVARCHAR (4000) NULL,
    [creation_at]     DATETIME2 (7)   NULL,
    [modified_at]     DATETIME2 (7)   NULL,
    [created_by]      BIGINT          NULL,
    [modified_by]     BIGINT          NULL,
    [is_optional_ind] BIT             NULL
);
GO

