-- TEST uspReadLocationPaletteInfo



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
	@full_name = 'Jordan Nguyen',
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

-- give person permission to C.R.U.D the locations table
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'read') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
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

-- create some locations to work with
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@auth = 'test'
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 2,
	@auth = 'test'
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 3,
	@level_id = 3,
	@auth = 'test'

-- add some differences to locations
UPDATE dbo.locations
SET palette_id = 'AVP010',
last_modified_by = (SELECT id FROM dbo.personnel WHERE username='hoa')
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
UPDATE dbo.palettes
SET last_modified_by = (SELECT id FROM dbo.personnel WHERE username = 'test'),
order_num = 'G00101'
WHERE id = 'AVP010'

UPDATE dbo.locations
SET last_modified_by = (SELECT id FROM dbo.personnel WHERE username='jordan') -- jordan technically doesn't have the permission to update but this is brute force, and only used for testing
WHERE row_id = 'A' AND column_id = 2 AND level_id = 2

UPDATE dbo.locations
SET palette_id = 'BP123',
last_modified_by = (SELECT id FROM dbo.personnel WHERE username='test')
WHERE row_id = 'A' AND column_id = 3 AND level_id = 3
UPDATE dbo.palettes
SET last_modified_by = (SELECT id FROM dbo.personnel WHERE username = 'hoa'),
being_delivered = 1
WHERE id = 'BP123'
SET NOCOUNT OFF

PRINT 'TESTING USER STORED PROCEDURE uspReadLocationPaletteInfo'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Read palette w/ invalid @auth, valid location id
-- EXPECTED OUTPUT = 'Unauthorized to read full palette information'
SET @EXPECTED = 'Unauthorized to read full location information'
EXEC [dbo].[uspReadLocationPaletteInfo]
	@row = 'A',
	@col = 2,
	@level = 2,
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
-- Read palette w/ invalid @auth, invalid location id
-- EXPECTED OUTPUT = 'Unauthorized to read full palette information'
SET @EXPECTED = 'Unauthorized to read full location information'
EXEC [dbo].[uspReadLocationPaletteInfo]
	@row = 'C',
	@col = 5,
	@level = 1,
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
-- Read palette w/ valid @auth, invalid location id (doesn't return anything b/c location DNE)
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadLocationPaletteInfo]
	@row = 'A',
	@col = 4,
	@level = 1,
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
-- Read palette w/ valid @auth, invalid location id (doesn't return anything b/c location DNE)
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadLocationPaletteInfo]
	@row = 'O',
	@col = 1,
	@level = 1,
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
-- Read palette w/ valid @auth, valid location id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadLocationPaletteInfo]
	@row = 'A',
	@col = 1,
	@level = 1,
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
-- Read palette w/ valid @auth, valid location id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadLocationPaletteInfo]
	@row = 'A',
	@col = 2,
	@level = 2,
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
-- Read palette w/ valid @auth, valid location id
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC [dbo].[uspReadLocationPaletteInfo]
	@row = 'A',
	@col = 3,
	@level = 3,
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

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspReadLocationPaletteInfo'

SET NOCOUNT ON
DELETE FROM dbo.locations 
WHERE (row_id = 'A' AND column_id = 1 AND level_id = 1) 
OR (row_id = 'A' AND column_id = 2 AND level_id = 2)
OR (row_id = 'A' AND column_id = 3 AND level_id = 3)
DELETE FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
DELETE FROM dbo.personnel WHERE username IN ('hoa', 'jordan')
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.locations WHERE (row_id = 'A' AND column_id = 1 AND level_id = 1) 
			OR (row_id = 'A' AND column_id = 2 AND level_id = 2)
			OR (row_id = 'A' AND column_id = 3 AND level_id = 3))
OR EXISTS (SELECT 1 FROM dbo.personnel WHERE username IN ('hoa', 'jordan'))
OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123'))
	PRINT 'Unable to clear all data used to test uspReadLocationPaletteInfo'