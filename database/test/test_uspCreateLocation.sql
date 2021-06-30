-- TEST uspCreatePalette



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM dbo.locations
SET NOCOUNT OFF

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

PRINT 'TESTING USER STORED PROCEDURE uspCreateLocation'
PRINT 'BEGINNING TEST...'

-- ============================================================================
-- TEST 1
-- Create location w/ invalid @row_id, valid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'O',
	@column_id = 1,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Create location w/ invalid @row_id, invalid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'I',
	@column_id = 20,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Create location w/ invalid @row_id, valid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'J',
	@column_id = 1,
	@level_id = 6,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Create location w/ invalid @row_id, invalid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'X',
	@column_id = 299,
	@level_id = 1241,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

-- ============================================================================
-- TEST 5
-- Create location w/ invalid @row_id, valid @column_id, valid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'Y',
	@column_id = 5,
	@level_id = 3,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Create location w/ invalid @row_id, invalid @column_id, valid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'Z',
	@column_id = 1000,
	@level_id = 1,
	@auth = 'hola',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Create location w/ invalid @row_id, valid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'Q',
	@column_id = 1,
	@level_id = 6,
	@auth = 'bonjour',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Create location w/ invalid @row_id, invalid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspCreateLocation
	@row_id = 'U',
	@column_id = 5432,
	@level_id = 5134,
	@auth = 'bacon',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- Create location w/ valid @row_id, invalid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 5432,
	@level_id = 2,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- Create location w/ valid @row_id, invalid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspCreateLocation
	@row_id = 'D',
	@column_id = 413,
	@level_id = 20,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Create location w/ valid @row_id, invalid @column_id, valid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspCreateLocation
	@row_id = 'K',
	@column_id = 518,
	@level_id = 1,
	@auth = 'salad',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Create location w/ valid @row_id, invalid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspCreateLocation
	@row_id = 'E',
	@column_id = 518,
	@level_id = 1034,
	@auth = 'apple',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 13
-- Create location w/ valid @row_id, valid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid level'
SET @EXPECTED = 'Invalid level'
EXEC dbo.uspCreateLocation
	@row_id = 'P',
	@column_id = 5,
	@level_id = 3453,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 14
-- Create location w/ valid @row_id, valid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid level'
SET @EXPECTED = 'Invalid level'
EXEC dbo.uspCreateLocation
	@row_id = 'H',
	@column_id = 8,
	@level_id = 1423,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 15
-- Create location w/ valid @row_id, valid @column_id, valid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to create locations'
SET @EXPECTED = 'Unauthorized to create locations'
EXEC dbo.uspCreateLocation
	@row_id = 'C',
	@column_id = 3,
	@level_id = 1,
	@auth = 'fun',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 16
-- Create location w/ valid @row_id, valid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreateLocation
	@row_id = 'B',
	@column_id = 3,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='B' AND column_id=3 AND level_id=1)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 17
-- Create location w/ valid @row_id, valid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreateLocation
	@row_id = 'H',
	@column_id = 6,
	@level_id = 3,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='H' AND column_id=6 AND level_id=3)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 18
-- Create location w/ valid @row_id, valid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspCreateLocation
	@row_id = 'K',
	@column_id = 2,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='K' AND column_id=2 AND level_id=1)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 19
-- Create repeating location w/ valid @auth
-- EXPECTED OUTPUT = 'Location already exists'
SET @EXPECTED = 'Location already exists'
EXEC dbo.uspCreateLocation
	@row_id = 'K',
	@column_id = 2,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 20
-- Create repeating location w/ invalid @auth
-- EXPECTED OUTPUT = 'Location already exists'
SET @EXPECTED = 'Location already exists'
EXEC dbo.uspCreateLocation
	@row_id = 'H',
	@column_id = 6,
	@level_id = 3,
	@auth = 'chao',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspCreatePalette'

SET NOCOUNT ON
DELETE FROM dbo.locations
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.locations)
	PRINT 'Unable to clear all data used to test uspCreateLocation'