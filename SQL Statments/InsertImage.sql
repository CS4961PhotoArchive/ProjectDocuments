CREATE TABLE [dbo].[Images] (
    -- This must be a string suitable for a GUID
    [Id]            NVARCHAR (128)     NOT NULL,

	-- These are the properties of our DTO not included in EntityFramework
    [UserID]   NVARCHAR (255)     NULL,
    [Lat]      FLOAT (53)               NULL,
    [Lon]   FLOAT (53)         NULL,

    -- These are the system properties
    [Version]       ROWVERSION         NOT NULL,
    [CreatedAt]     DATETIMEOFFSET (7) NOT NULL,
    [UpdatedAt]     DATETIMEOFFSET (7) NULL,
    [Deleted]       BIT                NOT NULL,

);

CREATE CLUSTERED INDEX [IX_CreatedAt]
    ON [dbo].[Images]([CreatedAt] ASC);

ALTER TABLE [dbo].[Images]
    ADD CONSTRAINT [PK_dbo.Images] PRIMARY KEY NONCLUSTERED ([Id] ASC);
	Go
CREATE TRIGGER [TR_dbo_Images_InsertUpdateDelete] ON [dbo].[Images]
    AFTER INSERT, UPDATE, DELETE AS
    BEGIN
        UPDATE [dbo].[Images]
            SET [dbo].[Images].[UpdatedAt] = CONVERT(DATETIMEOFFSET, SYSUTCDATETIME())
            FROM INSERTED WHERE inserted.[Id] = [dbo].[Images].[Id]
    END;
