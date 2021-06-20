-- TEST uspDeletePersonnel



USE [warehouse_management]
GO

DELETE FROM [dbo].[personnel] WHERE username<>'test'

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @res NVARCHAR(256)


EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test'
-- ============================================================================
-- TEST 1
-- Delete personnel w/ incorrect auth, correct username, auth in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Unauthorized to delete personnel%'
EXEC dbo.uspDeletePersonnel
	@username=N'hoa',
	@auth='hoa',
	@response=@res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspDeletePersonnel TEST 1 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnel TEST 1 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Delete personnel w/ incorrect auth, correct username, auth not in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Unauthorized to delete personnel%'
EXEC dbo.uspDeletePersonnel
	@username=N'hoa',
	@auth='holla',
	@response=@res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspDeletePersonnel TEST 2 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnel TEST 2 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Delete personnel w/ incorrect auth, incorrect username, auth in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnel
	@username=N'asdfjk',
	@auth='hoa',
	@response=@res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspDeletePersonnel TEST 3 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnel TEST 3 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Delete personnel w/ incorrect auth, incorrect username, auth not in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnel
	@username=N'asdfjk',
	@auth='hoa',
	@response=@res OUTPUT
IF (@res LIKE @EXPECTED)
	SELECT 'uspDeletePersonnel TEST 4 SUCCESSFUL' AS test_output
ELSE
	SELECT 'uspDeletePersonnel TEST 4 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Delete personnel w/ correct auth, incorrect username
-- EXPECTED OUTPUT: 'SUCCESS'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnel
	@username=N'asdfjk',
	@auth='test',
	@response=@res OUTPUT
IF (@res LIKE @EXPECTED)
BEGIN	
	IF NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'asdfjk')
		SELECT 'uspDeletePersonnel TEST 5 SUCCESSFUL' AS test_output
END
ELSE
	SELECT 'uspDeletePersonnel TEST 5 FAILED' AS test_output
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Delete personnel w/ correct auth, correct username
-- EXPECTED OUTPUT: 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePersonnel
	@username=N'hoa',
	@auth='test',
	@response=@res OUTPUT
IF (@res LIKE @EXPECTED)
BEGIN	
	IF NOT EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa')
		SELECT 'uspDeletePersonnel TEST 6 SUCCESSFUL' AS test_output
END
ELSE
	SELECT 'uspDeletePersonnel TEST 6 FAILED' AS test_output
-- ============================================================================

DELETE FROM [dbo].[personnel] WHERE username=N'hoa'


DELETE FROM [dbo].[personnel] WHERE username<>'test'