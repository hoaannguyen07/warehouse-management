USE [warehouse_management]
GO

INSERT INTO dbo.personnel(username, password_hash, full_name) VALUES(N'test', HASHBYTES('SHA2_512', N'test123'), 'Test Case')

SELECT * FROM [dbo].[personnel]

--DELETE FROM [dbo].[personnel] WHERE username='test' OR username='hoa' OR username='binh' OR username='jordan' OR username='jason'