USE [warehouse_management]
GO

/****** Object:  Table [dbo].[personnel_permissions]    Script Date: 6/23/2021 11:59:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[personnel_permissions](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[personnel_id] [uniqueidentifier] NOT NULL,
	[permissions_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_personnel_permissions_id] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_personnel_permissions_personnelid_permissionsid] UNIQUE NONCLUSTERED 
(
	[personnel_id] ASC,
	[permissions_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[personnel_permissions] ADD  CONSTRAINT [DF_personnel_permissions_id]  DEFAULT (newid()) FOR [id]
GO

ALTER TABLE [dbo].[personnel_permissions]  WITH CHECK ADD  CONSTRAINT [FK_personnel_permissions_permissions] FOREIGN KEY([permissions_id])
REFERENCES [dbo].[permissions] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[personnel_permissions] CHECK CONSTRAINT [FK_personnel_permissions_permissions]
GO

ALTER TABLE [dbo].[personnel_permissions]  WITH CHECK ADD  CONSTRAINT [FK_personnel_permissions_personnel] FOREIGN KEY([personnel_id])
REFERENCES [dbo].[personnel] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[personnel_permissions] CHECK CONSTRAINT [FK_personnel_permissions_personnel]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'system generated id for this specific set of user permission' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnel_permissions', @level2type=N'COLUMN',@level2name=N'id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'foreign key id of the personnel this permission is given to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnel_permissions', @level2type=N'COLUMN',@level2name=N'personnel_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'foreign key id of the permission that is going to be given to personnel' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnel_permissions', @level2type=N'COLUMN',@level2name=N'permissions_id'
GO


