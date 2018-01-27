CREATE TABLE [dbo].[ICAVs] (
    -- This must be a string suitable for a GUID
    [Id]            NVARCHAR (128)     NOT NULL,

	-- These are the properties of our DTO not included in EntityFramework
    [ImageID]   NVARCHAR (128)     NOT NULL,
	[ContextID]   NVARCHAR (128)     NOT NULL,
	[AttributeID]   NVARCHAR (128)     NOT NULL,
	[Value]   NVARCHAR (255)     NOT NULL,
   
    -- These are the system properties
    [Version]       ROWVERSION         NOT NULL,
    [CreatedAt]     DATETIMEOFFSET (7) NOT NULL,
    [UpdatedAt]     DATETIMEOFFSET (7) NULL,
    [Deleted]       BIT                NOT NULL,

);

CREATE CLUSTERED INDEX [IX_CreatedAt]
    ON [dbo].[ICAVs]([CreatedAt] ASC);

ALTER TABLE [dbo].[ICAVs]
    ADD CONSTRAINT [PK_dbo.ICAVs] PRIMARY KEY NONCLUSTERED ([Id] ASC);
	Go
CREATE TRIGGER [TR_dbo_ICAVs_InsertUpdateDelete] ON [dbo].[ICAVs]
    AFTER INSERT, UPDATE, DELETE AS
    BEGIN
        UPDATE [dbo].[ICAVs]
            SET [dbo].[ICAVs].[UpdatedAt] = CONVERT(DATETIMEOFFSET, SYSUTCDATETIME())
            FROM INSERTED WHERE inserted.[Id] = [dbo].[ICAVs].[Id]
    END;
