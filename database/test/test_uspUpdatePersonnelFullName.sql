-- TEST uspCreatePalette



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM dbo.personnel WHERE username='hoa'
SET NOCOUNT OFF

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @EXPECTED_FULL_NAME NVARCHAR(50)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

-- create test personnel to be used in the test
EXEC dbo.uspCreatePersonnel
	@username = 'hoa',
	@password = 'hoa123',
	@full_name = 'Hoa Nguyen',
	@auth = 'test'

PRINT 'TESTING USER STORED PROCEDURE uspUpdatePersonnelFullName'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Update personnel w/ invalid username, valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspUpdatePersonnelFullName
	@username = 'carrot',
	@updated_full_name = 'sky',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Update personnel w/ invalid username, invalid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspUpdatePersonnelFullName
	@username = 'ham',
	@updated_full_name = 'school',
	@auth = 'flower',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Update personnel w/ valid username, invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to update passwords'
SET @EXPECTED = 'Unauthorized to update full names'
EXEC dbo.uspUpdatePersonnelFullName
	@username = 'hoa',
	@updated_full_name = 'YouTube',
	@auth = 'plant',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Update personnel w/ valid username, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @EXPECTED_FULL_NAME = 'TAMU'
EXEC dbo.uspUpdatePersonnelFullName
	@username = 'hoa',
	@updated_full_name = 'TAMU',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT id FROM dbo.personnel WHERE username = 'hoa' AND full_name = @EXPECTED_FULL_NAME)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Update personnel w/ valid username, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @EXPECTED_FULL_NAME = 'Hu Tieu Name Vang'
EXEC dbo.uspUpdatePersonnelFullName
	@username = 'hoa',
	@updated_full_name = 'Hu Tieu Name Vang',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT id FROM dbo.personnel WHERE username = 'hoa' AND full_name = @EXPECTED_FULL_NAME)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspUpdatePersonnelFullName'

SET NOCOUNT ON
DELETE FROM dbo.personnel WHERE username = 'hoa'
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username = 'hoa')
	PRINT 'Unable to clear all data used to test uspUpdatePersonnelFullName'