-- TEST uspCreatePalette



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM dbo.personnel WHERE username='hoa'
SET NOCOUNT OFF

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @EXPECTED_PASSWORD NVARCHAR(50)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

-- create test personnel to be used in the test
EXEC dbo.uspCreatePersonnel
	@username = 'hoa',
	@password = 'hoa123',
	@full_name = 'Hoa Nguyen',
	@auth = 'test'

PRINT 'TESTING USER STORED PROCEDURE uspUpdatePersonnelPassword'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Update personnel w/ invalid username, valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'Username does not exist'
EXEC dbo.uspUpdatePersonnelPassword
	@username = 'potato',
	@updated_password = '1234',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelPassword TEST ', @test_num,' FAILED')
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
EXEC dbo.uspUpdatePersonnelPassword
	@username = 'carrot',
	@updated_password = 'hello',
	@auth = 'flower',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelPassword TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Update personnel w/ valid username, invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to update passwords'
SET @EXPECTED = 'Unauthorized to update passwords'
EXEC dbo.uspUpdatePersonnelPassword
	@username = 'hoa',
	@updated_password = 'bonjour',
	@auth = 'plant',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelPassword TEST ', @test_num,' FAILED')
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
SET @EXPECTED_PASSWORD = 'chao'
EXEC dbo.uspUpdatePersonnelPassword
	@username = 'hoa',
	@updated_password = 'chao',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT id FROM dbo.personnel WHERE username = 'hoa' AND password_hash = HASHBYTES('SHA2_512', @EXPECTED_PASSWORD))
BEGIN
	PRINT CONCAT('uspUpdatePersonnelPassword TEST ', @test_num,' FAILED')
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
SET @EXPECTED_PASSWORD = 'bacon'
EXEC dbo.uspUpdatePersonnelPassword
	@username = 'hoa',
	@updated_password = 'bacon',
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT id FROM dbo.personnel WHERE username = 'hoa' AND password_hash = HASHBYTES('SHA2_512', @EXPECTED_PASSWORD))
BEGIN
	PRINT CONCAT('uspUpdatePersonnelPassword TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Update personnel w/ valid username, @auth=@usename but @auth does not have permission to update passwords in personnel
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @EXPECTED_PASSWORD = 'chicken'
EXEC dbo.uspUpdatePersonnelPassword
	@username = 'hoa',
	@updated_password = 'chicken',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT id FROM dbo.personnel WHERE username = 'hoa' AND password_hash = HASHBYTES('SHA2_512', @EXPECTED_PASSWORD))
BEGIN
	PRINT CONCAT('uspUpdatePersonnelPassword TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspUpdatePersonnelPassword'

SET NOCOUNT ON
DELETE FROM dbo.personnel WHERE username = 'hoa'
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username = 'hoa')
	PRINT 'Unable to clear all data used to test uspUpdatePersonnelPassword'