USE [warehouse_management]
GO

/****** Object:  Table [dbo].[permissions]    Script Date: 6/14/2021 9:46:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[permissions](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[action] [nvarchar](10) NOT NULL,
	[object] [nvarchar](30) NOT NULL,
 CONSTRAINT [pk_permissions_id] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_permissions_action_object] UNIQUE NONCLUSTERED 
(
	[object] ASC,
	[action] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[permissions] ADD  CONSTRAINT [DF_permissions_id]  DEFAULT (newid()) FOR [id]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'system generated id for specific permission' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'permissions', @level2type=N'COLUMN',@level2name=N'id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'type of action (create/read/update/delete)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'permissions', @level2type=N'COLUMN',@level2name=N'action'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'type of object (table) an action could be performed on' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'permissions', @level2type=N'COLUMN',@level2name=N'object'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'permissions', @level2type=N'CONSTRAINT',@level2name=N'pk_permissions_id'
GO


