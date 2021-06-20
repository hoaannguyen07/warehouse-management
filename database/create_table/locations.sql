USE [warehouse_management]
GO

/****** Object:  Table [dbo].[locations]    Script Date: 6/14/2021 9:48:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[locations](
	[row_id] [nvarchar](1) NOT NULL,
	[column_id] [int] NOT NULL,
	[level_id] [int] NOT NULL,
	[is_empty] [binary](1) NOT NULL,
	[palette_id] [nvarchar](10) NULL,
	[last_modified] [datetime] NULL,
	[last_modified_by] [uniqueidentifier] NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_locations] PRIMARY KEY CLUSTERED 
(
	[row_id] ASC,
	[column_id] ASC,
	[level_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_locations_row_column_level] UNIQUE NONCLUSTERED 
(
	[row_id] ASC,
	[column_id] ASC,
	[level_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[locations] ADD  DEFAULT ((1)) FOR [is_empty]
GO

ALTER TABLE [dbo].[locations] ADD  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dbo].[locations]  WITH CHECK ADD  CONSTRAINT [FK_locations_columns_columns_id] FOREIGN KEY([column_id])
REFERENCES [dbo].[columns] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[locations] CHECK CONSTRAINT [FK_locations_columns_columns_id]
GO

ALTER TABLE [dbo].[locations]  WITH CHECK ADD  CONSTRAINT [FK_locations_levels_levels_id] FOREIGN KEY([level_id])
REFERENCES [dbo].[levels] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[locations] CHECK CONSTRAINT [FK_locations_levels_levels_id]
GO

ALTER TABLE [dbo].[locations]  WITH CHECK ADD  CONSTRAINT [FK_locations_palettes_palettes_id] FOREIGN KEY([palette_id])
REFERENCES [dbo].[palettes] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[locations] CHECK CONSTRAINT [FK_locations_palettes_palettes_id]
GO

ALTER TABLE [dbo].[locations]  WITH CHECK ADD  CONSTRAINT [FK_locations_personnel_created_by] FOREIGN KEY([created_by])
REFERENCES [dbo].[personnel] ([id])
GO

ALTER TABLE [dbo].[locations] CHECK CONSTRAINT [FK_locations_personnel_created_by]
GO

ALTER TABLE [dbo].[locations]  WITH CHECK ADD  CONSTRAINT [FK_locations_personnel_last_modified_by] FOREIGN KEY([last_modified_by])
REFERENCES [dbo].[personnel] ([id])
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[locations] CHECK CONSTRAINT [FK_locations_personnel_last_modified_by]
GO

ALTER TABLE [dbo].[locations]  WITH CHECK ADD  CONSTRAINT [FK_locations_rows_rows_id] FOREIGN KEY([row_id])
REFERENCES [dbo].[rows] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[locations] CHECK CONSTRAINT [FK_locations_rows_rows_id]
GO


