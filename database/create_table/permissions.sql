USE [warehouse_management]
GO

/****** Object:  Table [dbo].[permissions]    Script Date: 6/22/2021 4:12:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[permissions](
	[id] [uniqueidentifier] NOT NULL,
	[action_id] [int] NOT NULL,
	[object_id] [int] NOT NULL,
 CONSTRAINT [PK_permissions_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_action_object] UNIQUE NONCLUSTERED 
(
	[action_id] ASC,
	[object_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[permissions] ADD  DEFAULT (newid()) FOR [id]
GO

ALTER TABLE [dbo].[permissions]  WITH CHECK ADD  CONSTRAINT [FK_permissions_permission_actions] FOREIGN KEY([action_id])
REFERENCES [dbo].[permission_actions] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[permissions] CHECK CONSTRAINT [FK_permissions_permission_actions]
GO

ALTER TABLE [dbo].[permissions]  WITH CHECK ADD  CONSTRAINT [FK_permissions_permission_objects] FOREIGN KEY([object_id])
REFERENCES [dbo].[permission_objects] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[permissions] CHECK CONSTRAINT [FK_permissions_permission_objects]
GO


