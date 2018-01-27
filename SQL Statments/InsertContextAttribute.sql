CREATE TABLE [dbo].[Context_Attribute] (
    -- This must be a string suitable for a GUID
    [Id]            NVARCHAR (128)     NOT NULL,

	-- These are the properties of our DTO not included in EntityFramework
    [ContextID]   NVARCHAR (255)     NOT NULL,
	[AttributeID]   NVARCHAR (255)     NOT NULL,
    [SortNumber] INTEGER NULL,
    -- These are the system properties
    [Version]       ROWVERSION         NOT NULL,
    [CreatedAt]     DATETIMEOFFSET (7) NOT NULL,
    [UpdatedAt]     DATETIMEOFFSET (7) NULL,
    [Deleted]       BIT                NOT NULL,

);

CREATE CLUSTERED INDEX [IX_CreatedAt]
    ON [dbo].[Context_Attribute]([CreatedAt] ASC);

ALTER TABLE [dbo].[Context_Attribute]
    ADD CONSTRAINT [PK_dbo.Context_Attribute] PRIMARY KEY NONCLUSTERED ([Id] ASC);
	Go
CREATE TRIGGER [TR_dbo_Context_Attribute_InsertUpdateDelete] ON [dbo].[Context_Attribute]
    AFTER INSERT, UPDATE, DELETE AS
    BEGIN
        UPDATE [dbo].[Context_Attribute]
            SET [dbo].[Context_Attribute].[UpdatedAt] = CONVERT(DATETIMEOFFSET, SYSUTCDATETIME())
            FROM INSERTED WHERE inserted.[Id] = [dbo].[Context_Attribute].[Id]
    END;
