-- TEST uspVerifyLogin



USE [warehouse_management]
GO

DECLARE @response nvarchar(50)
-- Correct username and password
EXEC dbo.uspVerifyLogin
	@username = N'test',
	@password = N'test123'


-- Incorrect username but correct password
EXEC dbo.uspVerifyLogin
	@username = N'jason1',
	@password = N'jason123'


-- Incorrect password but correct username
EXEC dbo.uspVerifyLogin
	@username = N'hoa',
	@password = N'hoa1234'

-- Incorrect username & password
EXEC dbo.uspVerifyLogin
	@username = N'binh123',
	@password = N'binh1234'