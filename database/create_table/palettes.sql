USE [warehouse_management]
GO

/****** Object:  Table [dbo].[palettes]    Script Date: 6/23/2021 11:10:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[palettes](
	[id] [nvarchar](10) NOT NULL,
	[product_name] [nvarchar](100) NULL,
	[manufacturing_date] [date] NULL,
	[expiration_date] [date] NULL,
	[order_num] [nvarchar](50) NULL,
	[order_date] [date] NULL,
	[delivery_date] [date] NULL,
	[type_id] [uniqueidentifier] NULL,
	[unit_mass] [int] NULL,
	[amount] [int] NULL,
	[total_mass] [int] NOT NULL,
	[is_empty] [binary](1) NULL,
	[last_modified] [datetime] NULL,
	[last_modified_by] [uniqueidentifier] NULL,
	[being_delivered] [binary](1) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[created_by] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_palettes_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[palettes] ADD  CONSTRAINT [DF_palettes_type_id_1]  DEFAULT (NULL) FOR [type_id]
GO

ALTER TABLE [dbo].[palettes] ADD  CONSTRAINT [DF_palettes_total_mass]  DEFAULT (0) FOR [total_mass]
GO

ALTER TABLE [dbo].[palettes] ADD  CONSTRAINT [DF_palettes_is_empty]  DEFAULT ((1)) FOR [is_empty]
GO

ALTER TABLE [dbo].[palettes] ADD  CONSTRAINT [DF_palettes_being_delivered]  DEFAULT ((0)) FOR [being_delivered]
GO

ALTER TABLE [dbo].[palettes] ADD  CONSTRAINT [DF_palettes_created_date]  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dbo].[palettes]  WITH CHECK ADD  CONSTRAINT [FK_palettes_personnel_created_by] FOREIGN KEY([created_by])
REFERENCES [dbo].[personnel] ([id])
GO

ALTER TABLE [dbo].[palettes] CHECK CONSTRAINT [FK_palettes_personnel_created_by]
GO

ALTER TABLE [dbo].[palettes]  WITH CHECK ADD  CONSTRAINT [FK_palettes_personnel_last_modified_by] FOREIGN KEY([last_modified_by])
REFERENCES [dbo].[personnel] ([id])
GO

ALTER TABLE [dbo].[palettes] CHECK CONSTRAINT [FK_palettes_personnel_last_modified_by]
GO

ALTER TABLE [dbo].[palettes]  WITH CHECK ADD  CONSTRAINT [FK_palettes_types_type_id] FOREIGN KEY([type_id])
REFERENCES [dbo].[types] ([id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[palettes] CHECK CONSTRAINT [FK_palettes_types_type_id]
GO


