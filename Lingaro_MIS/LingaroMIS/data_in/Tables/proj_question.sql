CREATE TABLE [data_in].[proj_question] (
    [id]                     BIGINT          NULL,
    [text]                   NVARCHAR (4000) NULL,
    [allow_custom_answer]    BIT             NULL,
    [dictionary_id]          BIGINT          NULL,
    [expected_answer_type]   NVARCHAR (255)  NULL,
    [creation_at]            DATETIME2 (7)   NULL,
    [modified_at]            DATETIME2 (7)   NULL,
    [created_by]             BIGINT          NULL,
    [modified_by]            BIGINT          NULL,
    [form_type_id]           BIGINT          NULL,
    [active_ind]             BIT             NULL,
    [description]            NVARCHAR (4000) NULL,
    [category_id]            BIGINT          NULL,
    [allow_multiple_answers] BIT             NULL,
    [parent_question_id]     BIGINT          NULL,
    [display_order]          INT             NULL,
    [before_question_id]     BIGINT          NULL,
    [read_only]              BIT             NULL
);
GO

