USE [warehouse_management]
GO

/****** Object:  Table [dbo].[rows]    Script Date: 6/14/2021 9:46:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[rows](
	[id] [nvarchar](1) NOT NULL,
	[description] [nvarchar](50) NULL,
 CONSTRAINT [PK_rows_id] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[rows] ADD  CONSTRAINT [DF_rows_description]  DEFAULT (NULL) FOR [description]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'id of row (A-G, H, K, L, M, N, P)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rows', @level2type=N'COLUMN',@level2name=N'id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'description of what is stored on that row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rows', @level2type=N'COLUMN',@level2name=N'description'
GO


