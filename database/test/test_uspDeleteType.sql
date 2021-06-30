-- TEST uspCreatePalette



USE [warehouse_management]
GO

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

SET NOCOUNT ON
DELETE FROM dbo.types
SET NOCOUNT OFF

-- create types for this test to delete
EXEC dbo.uspCreateType
	@name = 'bao',
	@unit = 'kg',
	@auth = N'test'
EXEC dbo.uspCreateType
	@name = 'phuy',
	@unit = 'kg',
	@auth = N'test'
EXEC dbo.uspCreateType
	@name = 'tank',
	@unit = 'kg',
	@auth = N'test'
EXEC dbo.uspCreateType
	@name = 'tank',
	@unit = 'phuy',
	@auth = N'test'

PRINT 'TESTING USER STORED PROCEDURE uspCreateType'
PRINT 'BEGINNING TEST...'

-- ============================================================================
-- TEST 1
-- delete invalid type (valid name, invalid unit) w/ valid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'bao',
	@unit = 'lbs',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- delete invalid type (valid name, invalid unit) w/ invalid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'bao',
	@unit = 'lbs',
	@auth = N'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- delete invalid type (invalid name, valid unit) w/ valid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'building',
	@unit = 'kg',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- delete invalid type (invalid name, valid unit) w/ invalid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'mouse',
	@unit = 'phuy',
	@auth = N'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- delete invalid type (invalid name, invalid unit) w/ valid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'building',
	@unit = 'fruit',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- delete invalid type (invalid name, invalid unit) w/ invalid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'building',
	@unit = 'fruit',
	@auth = N';lks',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- delete invalid type (valid name & valid unit but not a combo) w/ valid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'bao',
	@unit = 'phuy',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- delete invalid type (valid name & valid unit but not a combo) w/ invalid @auth
-- EXPECTED OUTPUT = 'Type does not exist'
SET @EXPECTED = 'Type does not exist'
EXEC dbo.uspDeleteType
	@name = 'phuy',
	@unit = 'phuy',
	@auth = N'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- delete valid type w/ invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to delete types'
SET @EXPECTED = 'Unauthorized to delete types'
EXEC dbo.uspDeleteType
	@name = 'bao',
	@unit = 'kg',
	@auth = N'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- delete valid type w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteType
	@name = 'bao',
	@unit = 'kg',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- delete valid type w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteType
	@name = 'phuy',
	@unit = 'kg',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- delete valid type w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteType
	@name = 'tank',
	@unit = 'kg',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- delete valid type w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteType
	@name = 'tank',
	@unit = 'phuy',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspDeleteType'

SET NOCOUNT ON
DELETE FROM dbo.types
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.types)
	PRINT 'Unable to clear all data used to test uspDeleteType'