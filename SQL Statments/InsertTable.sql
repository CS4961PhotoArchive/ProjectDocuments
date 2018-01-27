CREATE TABLE [dbo].[Examples] (
    -- This must be a string suitable for a GUID
    [Id]            NVARCHAR (128)     NOT NULL,

	 -- These are the properties of our DTO not included in EntityFramework
    [StringField]   NVARCHAR (MAX)     NULL,
    [IntField]      INT                NOT NULL,
    [DoubleField]   FLOAT (53)         NOT NULL,
    [DateTimeField] DATETIMEOFFSET (7) NOT NULL,

    -- These are the system properties
    [Version]       ROWVERSION         NOT NULL,
    [CreatedAt]     DATETIMEOFFSET (7) NOT NULL,
    [UpdatedAt]     DATETIMEOFFSET (7) NULL,
    [Deleted]       BIT                NOT NULL,

);

CREATE CLUSTERED INDEX [IX_CreatedAt]
    ON [dbo].[Examples]([CreatedAt] ASC);

ALTER TABLE [dbo].[Examples]
    ADD CONSTRAINT [PK_dbo.Examples] PRIMARY KEY NONCLUSTERED ([Id] ASC);
	Go
CREATE TRIGGER [TR_dbo_Examples_InsertUpdateDelete] ON [dbo].[Examples]
    AFTER INSERT, UPDATE, DELETE AS
    BEGIN
        UPDATE [dbo].[Examples]
            SET [dbo].[Examples].[UpdatedAt] = CONVERT(DATETIMEOFFSET, SYSUTCDATETIME())
            FROM INSERTED WHERE inserted.[Id] = [dbo].[Examples].[Id]
    END;
