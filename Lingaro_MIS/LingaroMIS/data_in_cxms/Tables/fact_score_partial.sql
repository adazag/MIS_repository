CREATE TABLE [data_in_cxms].[fact_score_partial] (
    [score_id]    INT            NULL,
    [rdate]       DATE           NULL,
    [assessor_id] INT            NULL,
    [category_id] INT            NULL,
    [score]       DECIMAL (3, 1) NULL,
    [comment]     NVARCHAR (MAX) NULL
);
GO

