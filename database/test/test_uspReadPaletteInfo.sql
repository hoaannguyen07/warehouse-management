-- TEST uspReadPaletteInfo



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM dbo.personnel WHERE username='hoa'
SET NOCOUNT OFF

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

SET NOCOUNT ON
-- create test personnel to be used in the test
EXEC dbo.uspCreatePersonnel
	@username = 'hoa',
	@password = 'hoa123',
	@full_name = 'Hoa Nguyen',
	@auth = 'test'
EXEC dbo.uspCreatePersonnel
	@username = 'jordan',
	@password = 'jordan123',
	@full_name = 'Hoa Nguyen',
	@auth = 'test'
--SELECT * FROM dbo.personnel WHERE username = 'hoa' AND password_hash = HASHBYTES('SHA2_512', N'hoa123')
-- give person permission to C.R.U.D the palettes table
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
)
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
)
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'palettes'))
)

-- create a few palettes to work with
EXEC dbo.uspCreatePalette
	@palette_id = N'SA001',
	@auth = N'hoa'
EXEC dbo.uspCreatePalette
	@palette_id = N'AVP010',
	@auth = N'hoa'
EXEC dbo.uspCreatePalette
	@palette_id = N'BP123',
	@auth = N'hoa'

SET NOCOUNT OFF

PRINT 'TESTING USER STORED PROCEDURE uspReadPaletteInfo'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Read palette w/ invalid @auth, valid palette id
-- EXPECTED OUTPUT = 'Unauthorized to read palettes'
SET @EXPECTED = 'Unauthorized to read palettes'
EXEC [dbo].[uspReadPaletteInfo]
	@palette_id = 'SA001',
	@auth = 'jordan',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspReadPaletteInfo TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Read palette w/ invalid @auth, invalid palette id
-- EXPECTED OUTPUT = 'Unauthorized to read palettes'
SET @EXPECTED = 'Unauthorized to read palettes'
EXEC [dbo].[uspReadPaletteInfo]
	@palette_id = 'FUN',
	@auth = 'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspReadPaletteInfo TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Read palette w/ valid @auth, invalid palette id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadPaletteInfo]
	@palette_id = 'FUN',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspReadPaletteInfo TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Read palette w/ valid @auth, invalid palette id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadPaletteInfo]
	@palette_id = 'AVP123',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspReadPaletteInfo TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Read palette w/ valid @auth, valid palette id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadPaletteInfo]
	@palette_id = 'BP123',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspReadPaletteInfo TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Read palette w/ valid @auth, valid palette id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadPaletteInfo]
	@palette_id = 'AVP010',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspReadPaletteInfo TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Read palette w/ valid @auth, valid palette id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadPaletteInfo]
	@palette_id = 'SA001',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspReadPaletteInfo TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspReadPaletteInfo'

SET NOCOUNT ON
DELETE FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
DELETE FROM dbo.personnel WHERE username IN ('hoa', 'jordan')
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username IN ('hoa', 'jordan'))
OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123'))
	PRINT 'Unable to clear all data used to test uspReadPaletteInfo'