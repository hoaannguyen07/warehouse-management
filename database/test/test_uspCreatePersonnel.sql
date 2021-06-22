-- TEST uspCreatePersonnel



USE [warehouse_management]
GO

DELETE FROM [dbo].[personnel] WHERE username<>'test'

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @res NVARCHAR(256)


-- ============================================================================
-- TEST 1
-- Creating peronnel w/ correct authorization, correct & unique user information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
BEGIN
	IF EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa')
		SELECT 'uspCreatePersonnel TEST 1 SUCCESSFUL' AS test_output
END
ELSE
	SELECT 'uspCreatePersonnel TEST 1 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Creating personnel w/ incorrect authorization, correct & unique user information, auth in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = '%Unauthorized to create personnel%'
EXEC dbo.uspCreatePersonnel
	@username = N'binh',
	@password = N'binh123',
	@full_name = N'Binh Nguyen',
	@auth = N'hoa',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 2 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 2 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Creating personnel w/ incorrect authorization, correct & unique user information, auth not in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = 'Unauthorized to create personnel'
EXEC dbo.uspCreatePersonnel
	@username = N'nhan',
	@password = N'nhan123',
	@full_name = N'Nhan Nguyen',
	@auth = N'hello',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 3 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 3 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Creating peronnel w/ correct authorization, fully repeating user information
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 4 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 4 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Creating peronnel w/ incorrect authorization, fully repeating user information, auth in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'hoa',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 5 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 5 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Creating peronnel w/ incorrect authorization, fully repeating user information, auth not in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'hello',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 6 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 6 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Creating peronnel w/ correct authorization, repeating username but not password & full_name user information
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'haibabon',
	@full_name = N'i dont know',
	@auth = N'test',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 7 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 7 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Creating peronnel w/ incorrect authorization, repeating username but not password & full_name user information, auth in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'onetwothree',
	@full_name = N'what to do',
	@auth = N'hoa',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 8 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 8 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 9
-- Creating peronnel w/ incorrect authorization, repeating username but not password & full_name user information, auth not in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'bonnamsau',
	@full_name = N'abc',
	@auth = N'hello',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 9 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 9 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 10
-- Creating peronnel w/ correct authorization, repeating username & password but not full_name user information
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'i dont know',
	@auth = N'test',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 10 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 10 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Creating peronnel w/ incorrect authorization, repeating username & password but not full_name user information, auth in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'what to do',
	@auth = N'hoa',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 11 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 11 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Creating peronnel w/ incorrect authorization, repeating username & password but not full_name user information, auth not in personnel
-- EXPECTED OUTPUT = 'Username already exist'
SET @EXPECTED = '%Username already exist%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'abc',
	@auth = N'hello',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 12 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 12 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 13
-- Creating peronnel w/ correct authorization, repeating password & full_name but not username user information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa1',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
BEGIN
	IF EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa')
		SELECT 'uspCreatePersonnel TEST 13 SUCCESSFUL' AS test_output
END
ELSE
	SELECT 'uspCreatePersonnel TEST 13 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 14
-- Creating peronnel w/ correct authorization, repeating full_name but not username & password user information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa2',
	@password = N'123hoa',
	@full_name = N'Hoa Nguyen',
	@auth = N'test',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
BEGIN
	IF EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa')
		SELECT 'uspCreatePersonnel TEST 14 SUCCESSFUL' AS test_output
END
ELSE
	SELECT 'uspCreatePersonnel TEST 14 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 15
-- Creating peronnel w/ incorrect authorization, repeating password & full_name but not username user information, auth in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = '%Unauthorized to create personnel%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa3',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'hoa',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 15 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 15 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 16
-- Creating peronnel w/ incorrect authorization, repeating full_name but not username & password user information, auth not in personnel
-- EXPECTED OUTPUT = 'Unauthorized to create personnel'
SET @EXPECTED = '%Unauthorized to create personnel%'
EXEC dbo.uspCreatePersonnel
	@username = N'hoa4',
	@password = N'hoa1234',
	@full_name = N'Hoa Nguyen',
	@auth = N'hello',
	@response = @res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspCreatePersonnel TEST 16 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspCreatePersonnel TEST 16 FAILED' AS test_output
-- ============================================================================

SELECT * FROM [dbo].[personnel]

DELETE FROM [dbo].[personnel] WHERE username LIKE 'hoa_' OR username='hoa'
