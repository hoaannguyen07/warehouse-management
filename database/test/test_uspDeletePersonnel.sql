-- TEST uspDeletePersonnel



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM [dbo].[personnel] WHERE username NOT IN ('test', 'hoaannguyen07')
SET NOCOUNT OFF

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

EXEC dbo.uspCreatePersonnel
	@username = N'hoa',
	@password = N'hoa123',
	@full_name = N'Hoa Nguyen',
	@auth = N'test'

PRINT 'TESTING USER STORED PROCEDURE uspDeletePersonnel'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Delete personnel w/ incorrect auth, correct username, auth in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Unauthorized to delete personnel%'
EXEC dbo.uspDeletePersonnel
	@username=N'hoa',
	@auth='hoa',
	@response=@response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Delete personnel w/ incorrect auth, correct username, auth not in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Unauthorized to delete personnel%'
EXEC dbo.uspDeletePersonnel
	@username=N'hoa',
	@auth='holla',
	@response=@response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Delete personnel w/ incorrect auth, incorrect username, auth in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnel
	@username=N'asdfjk',
	@auth='hoa',
	@response=@response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Delete personnel w/ incorrect auth, incorrect username, auth not in personnel
-- EXPECTED OUTPUT: 'Unauthorized to delete personnel'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnel
	@username=N'asdfjk',
	@auth='hoa',
	@response=@response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Delete personnel w/ correct auth, incorrect username
-- EXPECTED OUTPUT: 'SUCCESS'
SET @EXPECTED = '%Username does not exist%'
EXEC dbo.uspDeletePersonnel
	@username=N'asdfjk',
	@auth='test',
	@response=@response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'asdfjk')
BEGIN
	PRINT CONCAT('uspDeletePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Delete personnel w/ correct auth, correct username
-- EXPECTED OUTPUT: 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePersonnel
	@username=N'hoa',
	@auth='test',
	@response=@response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR EXISTS(SELECT dbo.personnel.id FROM dbo.personnel WHERE username=N'hoa')
BEGIN
	PRINT CONCAT('uspDeletePersonnel TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspDeletePersonnel'

SET NOCOUNT ON
DELETE FROM [dbo].[personnel] WHERE username IN ('hoa', 'asdfjk')
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username IN ('hoa', 'asdfjk'))
	PRINT 'Unable to fully erase everything created in the uspDeletePersonnel Test'