-- TEST uspDeletePalette



USE [warehouse_management]
GO



DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

-- create palettes to be used in this test
EXEC dbo.uspCreatePalette
	@palette_id = N'SA001',
	@auth = N'test',
	@response = @response OUTPUT

EXEC dbo.uspCreatePalette
	@palette_id = N'SA002',
	@auth = N'test',
	@response = @response OUTPUT

EXEC dbo.uspCreatePalette
	@palette_id = N'SA003',
	@auth = N'test',
	@response = @response OUTPUT

EXEC dbo.uspCreatePalette
	@palette_id = N'SA004',
	@auth = N'test',
	@response = @response OUTPUT

PRINT 'TESTING USER STORED PROCEDURE uspDeletePersonnel'
PRINT 'BEGINNING TEST...'

-- ============================================================================
-- TEST 1
-- Creating unique palette w/ invalid id, valid @auth
-- EXPECTED OUTPUT = 'Palette does not exist'
SET @EXPECTED = '%Palette ID does not exist%'
EXEC dbo.uspDeletePalette
	@palette_id = N'A&M',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Creating unique palette w/ invalid id, invalid @auth
-- EXPECTED OUTPUT = 'Palette does not exist'
SET @EXPECTED = '%Palette ID does not exist%'
EXEC dbo.uspDeletePalette
	@palette_id = N'dentist',
	@auth = N'fruit',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Creating unique palette w/ valid id, invalid @auth
-- EXPECTED OUTPUT = 'Palette does not exist'
SET @EXPECTED = '%Unauthorized to delete palettes%'
EXEC dbo.uspDeletePalette
	@palette_id = N'SA001',
	@auth = N'salad',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED)
BEGIN
	PRINT CONCAT('uspDeletePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Creating unique palette w/ valid id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePalette
	@palette_id = N'SA001',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id = 'SA001')
BEGIN
	PRINT CONCAT('uspDeletePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Creating unique palette w/ valid id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePalette
	@palette_id = N'SA002',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id = 'SA002')
BEGIN
	PRINT CONCAT('uspDeletePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Creating unique palette w/ valid id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePalette
	@palette_id = N'SA003',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id = 'SA003')
BEGIN
	PRINT CONCAT('uspDeletePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Creating unique palette w/ valid id, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = '%SUCCESS%'
EXEC dbo.uspDeletePalette
	@palette_id = N'SA004',
	@auth = N'test',
	@response = @response OUTPUT
IF (@response NOT LIKE @EXPECTED) OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id = 'SA004')
BEGIN
	PRINT CONCAT('uspDeletePalette TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================
PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspDeletePalette'



DELETE FROM dbo.palettes WHERE id IN ('SA001', 'SA002', 'SA003', 'SA004')
IF EXISTS (SELECT id FROM dbo.palettes)
	PRINT 'Unable to clear all data used to test uspCreatePalette'