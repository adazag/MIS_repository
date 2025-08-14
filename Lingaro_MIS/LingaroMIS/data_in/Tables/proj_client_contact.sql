CREATE TABLE [data_in].[proj_client_contact] (
    [id]          BIGINT         NULL,
    [first_name]  NVARCHAR (200) NULL,
    [last_name]   NVARCHAR (200) NULL,
    [client_id]   BIGINT         NULL,
    [email_text]  NVARCHAR (200) NULL,
    [active_ind]  BIT            NULL,
    [created_by]  BIGINT         NULL,
    [modified_by] BIGINT         NULL,
    [creation_at] DATETIME2 (7)  NULL,
    [modified_at] DATETIME2 (7)  NULL
);
GO

