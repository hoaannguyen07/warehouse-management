-- TEST uspCreatePalette



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM dbo.locations
SET NOCOUNT OFF

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

-- Create random locations in db, which will be used for this test
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@auth = 'test'
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 2,
	@auth = 'test'
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 3,
	@auth = 'test'
EXEC dbo.uspCreateLocation
	@row_id = 'B',
	@column_id = 1,
	@level_id = 1,
	@auth = 'test'
EXEC dbo.uspCreateLocation
	@row_id = 'B',
	@column_id = 2,
	@level_id = 1,
	@auth = 'test'
EXEC dbo.uspCreateLocation
	@row_id = 'B',
	@column_id = 3,
	@level_id = 1,
	@auth = 'test'

PRINT 'TESTING USER STORED PROCEDURE uspDeleteLocation'
PRINT 'BEGINNING TEST...'

-- ============================================================================
-- TEST 1
-- Delete location w/ invalid @row_id, valid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ invalid @row_id, invalid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ invalid @row_id, valid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ invalid @row_id, invalid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ invalid @row_id, valid @column_id, valid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ invalid @row_id, invalid @column_id, valid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ invalid @row_id, valid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ invalid @row_id, invalid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid row'
SET @EXPECTED = 'Invalid row'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ valid @row_id, invalid @column_id, valid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ valid @row_id, invalid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ valid @row_id, invalid @column_id, valid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ valid @row_id, invalid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid column'
SET @EXPECTED = 'Invalid column'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ valid @row_id, valid @column_id, invalid @level_id, valid @auth
-- EXPECTED OUTPUT = 'Invalid level'
SET @EXPECTED = 'Invalid level'
EXEC dbo.uspDeleteLocation
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
-- Delete location w/ valid @row_id, valid @column_id, invalid @level_id, invalid @auth
-- EXPECTED OUTPUT = 'Invalid level'
SET @EXPECTED = 'Invalid level'
EXEC dbo.uspDeleteLocation
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
-- Delete invalid location (location does not exist in database but w/ correct row/col/level ids) w/ valid @auth
-- EXPECTED OUTPUT = 'Location already exists'
SET @EXPECTED = 'Location does not exist'
EXEC dbo.uspDeleteLocation
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
-- TEST 16
-- Delete invalid location (location does not exist in database but w/ correct row/col/level ids) w/ invalid @auth
-- EXPECTED OUTPUT = 'Location already exists'
SET @EXPECTED = 'Location does not exist'
EXEC dbo.uspDeleteLocation
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


-- ============================================================================
-- TEST 17
-- Delete valid location (location exists in database) invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to create locations'
SET @EXPECTED = 'Unauthorized to delete locations'
EXEC dbo.uspDeleteLocation
	@row_id = 'B',
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
-- TEST 18
-- Delete valid location (location exists in database) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='A' AND column_id=1 AND level_id=1)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 19
-- Delete valid location (location exists in database) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 2,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='A' AND column_id=1 AND level_id=2)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 20
-- Delete valid location (location exists in database) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 3,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='A' AND column_id=1 AND level_id=3)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 21
-- Delete valid location (location exists in database) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteLocation
	@row_id = 'B',
	@column_id = 1,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='B' AND column_id=1 AND level_id=1)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 22
-- Delete valid location (location exists in database) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteLocation
	@row_id = 'B',
	@column_id = 2,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='B' AND column_id=2 AND level_id=1)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 23
-- Delete valid location (location exists in database) w/ valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspDeleteLocation
	@row_id = 'B',
	@column_id = 3,
	@level_id = 1,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.locations WHERE row_id='B' AND column_id=3 AND level_id=1)
BEGIN
	PRINT CONCAT('uspCreateLocation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================\

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspCreatePalette'

SET NOCOUNT ON
DELETE FROM dbo.locations
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.locations)
	PRINT 'Unable to clear all data used to test uspDeleteLocation'