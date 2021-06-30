-- TEST uspCreatePalette



USE [warehouse_management]
GO

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

SET NOCOUNT ON
DELETE FROM dbo.types
SET NOCOUNT OFF

PRINT 'TESTING USER STORED PROCEDURE uspCreateType'
PRINT 'BEGINNING TEST...'

-- ============================================================================
-- TEST 1
-- create unique type (unique name & unit) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreateType
	@name = 'bag',
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
-- TEST 2
-- create unique type (same name & unique unit) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreateType
	@name = 'bag',
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
-- TEST 3
-- create unique type (unique name & same unit) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreateType
	@name = 'drum',
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
-- TEST 4
-- create repeating name-unit type combo w/ valid @auth
-- EXPECTED OUTPUT = 'Type already exists'
SET @EXPECTED = 'Type already exists'
EXEC dbo.uspCreateType
	@name = 'drum',
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
-- TEST 5
-- create unique type (unique name & unit) w/ invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to create types'
SET @EXPECTED = 'Unauthorized to create types'
EXEC dbo.uspCreateType
	@name = 'tank',
	@unit = 'tons',
	@auth = N'binh',
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
-- create repeating name-unit type combo w/ invalid @auth
-- EXPECTED OUTPUT = 'Type already exists'
SET @EXPECTED = 'Type already exists'
EXEC dbo.uspCreateType
	@name = 'bag',
	@unit = 'kg',
	@auth = N'bbq',
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
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspCreateType'

SET NOCOUNT ON
DELETE FROM dbo.types
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.types)
	PRINT 'Unable to clear all data used to test uspCreateType'