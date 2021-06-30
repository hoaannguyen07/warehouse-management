-- TEST uspCreatePalette



USE [warehouse_management]
GO

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

PRINT 'TESTING USER STORED PROCEDURE uspCreatePersonnel'
PRINT 'BEGINNING TEST...'

-- ============================================================================
-- TEST 1
-- Creating unique palette w/ unique id, invalid @auth
-- EXPECTED OUTPUT = 'Unauthorized to create palettes'
SET @EXPECTED = '%Unauthorized to create palettes%'
EXEC dbo.uspCreatePalette
	@palette_id = N'SA001',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Creating unique palette w/ unique id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspCreatePalette
	@palette_id = N'SA001',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR NOT EXISTS(SELECT id FROM dbo.palettes WHERE id='SA001')
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Creating unique palette w/ repeating id, valid @auth
-- EXPECTED OUTPUT = 'Palette ID already exists'
SET @EXPECTED = '%Palette ID already exists%'
EXEC dbo.uspCreatePalette
	@palette_id = N'SA001',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Creating unique palette w/ repeating id, invalid @auth
-- EXPECTED OUTPUT = 'Palette ID already exists'
SET @EXPECTED = '%Palette ID already exists%'
EXEC dbo.uspCreatePalette
	@palette_id = N'SA001',
	@auth = N'hoa',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Creating unique palette w/ unique id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspCreatePalette
	@palette_id = N'SA000000001',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR NOT EXISTS(SELECT id FROM dbo.palettes WHERE id='SA00000000')
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
	(SELECT id FROM dbo.palettes WHERE id='SA00000000')
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Creating unique palette w/ unique id but same first 10 characters, valid @auth
-- EXPECTED OUTPUT = 'Palette ID already exists'
SET @EXPECTED = '%Palette ID already exists%'
EXEC dbo.uspCreatePalette
	@palette_id = N'SA000000002',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Creating unique palette w/ unique id but same first 10 characters, invalid @auth
-- EXPECTED OUTPUT = 'Palette ID already exists'
SET @EXPECTED = '%Palette ID already exists%'
EXEC dbo.uspCreatePalette
	@palette_id = N'SA000000003',
	@auth = N'hello',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspCreatePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspCreatePalette'

DELETE FROM dbo.palettes WHERE id IN ('SA001', 'SA00000000')
IF EXISTS (SELECT id FROM dbo.palettes)
	PRINT 'Unable to clear all data used to test uspCreatePalette'