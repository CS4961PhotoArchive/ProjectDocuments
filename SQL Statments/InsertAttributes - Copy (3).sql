CREATE TABLE [dbo].[Contexts] (
    -- This must be a string suitable for a GUID
    [Id]            NVARCHAR (128)     NOT NULL,

	-- These are the properties of our DTO not included in EntityFramework
    [Descriptor]   NVARCHAR (255)     NOT NULL,
   
    -- These are the system properties
    [Version]       ROWVERSION         NOT NULL,
    [CreatedAt]     DATETIMEOFFSET (7) NOT NULL,
    [UpdatedAt]     DATETIMEOFFSET (7) NULL,
    [Deleted]       BIT                NOT NULL,

);

CREATE CLUSTERED INDEX [IX_CreatedAt]
    ON [dbo].[Contexts]([CreatedAt] ASC);

ALTER TABLE [dbo].[Contexts]
    ADD CONSTRAINT [PK_dbo.Contexts] PRIMARY KEY NONCLUSTERED ([Id] ASC);
	Go
CREATE TRIGGER [TR_dbo_Contexts_InsertUpdateDelete] ON [dbo].[Contexts]
    AFTER INSERT, UPDATE, DELETE AS
    BEGIN
        UPDATE [dbo].[Contexts]
            SET [dbo].[Contexts].[UpdatedAt] = CONVERT(DATETIMEOFFSET, SYSUTCDATETIME())
            FROM INSERTED WHERE inserted.[Id] = [dbo].[Contexts].[Id]
    END;
