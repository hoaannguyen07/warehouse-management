USE [warehouse_management]
GO

/****** Object:  Table [dbo].[personnel]    Script Date: 6/14/2021 9:45:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[personnel](
	[id] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password_hash] [binary](64) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [pk_personnel_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uidx_personnel_username] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[personnel] ADD  CONSTRAINT [DF_personnel_id]  DEFAULT (newid()) FOR [id]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnel', @level2type=N'CONSTRAINT',@level2name=N'pk_personnel_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnel', @level2type=N'CONSTRAINT',@level2name=N'uidx_personnel_username'
GO


