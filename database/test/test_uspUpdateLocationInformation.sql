-- TEST uspUpdateLocationInformation



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM dbo.personnel WHERE username='hoa'
DELETE FROM dbo.personnel WHERE username='jordan'
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

EXEC dbo.uspCreatePersonnel -- jordan will not have permission to do anything
	@username = 'jordan',
	@password = 'jordan123',
	@full_name = 'Jordan Nguyen',
	@auth = 'test'

--SELECT * FROM dbo.personnel WHERE username = 'hoa' AND password_hash = HASHBYTES('SHA2_512', N'hoa123')
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
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'delete') 
	AND object_id=(SELECT id FROM dbo.permission_objects WHERE object = 'locations'))
)
-- give 'hoa' permission to create palettes so some palettes to be used in some tests
INSERT INTO personnel_permissions(personnel_id, permissions_id) 
VALUES(
(SELECT TOP 1 id FROM dbo.personnel WHERE username='hoa' AND password_hash=HASHBYTES('SHA2_512', N'hoa123')),
(SELECT TOP 1 id FROM dbo.permissions 
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'create') 
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

-- create a few locations to work with
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@auth = 'hoa'
EXEC dbo.uspCreateLocation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@auth = 'hoa'
EXEC dbo.uspCreateLocation
	@row_id = 'P',
	@column_id = 10,
	@level_id = 2,
	@auth = 'hoa'

--SET NOCOUNT ON
--SELECT * FROM dbo.personnel WHERE username IN ('hoa', 'jordan')
--SELECT * FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
--SELECT * FROM dbo.locations
--SET NOCOUNT OFF

PRINT 'TESTING USER STORED PROCEDURE uspUpdateLocationInformation'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Update valid location with valid information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@palette_id = 'AVP010',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Update valid location with valid information
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@palette_id = 'BP123',
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Update valid location with valid information -> change palette id back to null and make sure is empty status is true
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@palette_id = NULL,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Update valid location with valid information -> change palette id back to null and make sure is empty status is true
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@palette_id = NULL,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Update valid location with valid information -> change palette id that was already to null and make sure is empty status is true
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'P',
	@column_id = 10,
	@level_id = 2,
	@palette_id = NULL,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Update invalid location combination, auth exists as personnel but unauthorized to update locations
-- EXPECTED OUTPUT = 'Location does not exist'
SET @EXPECTED = 'Location does not exist'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'B',
	@column_id = 1,
	@level_id = 1,
	@palette_id = NULL,
	@auth = 'jordan',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Update invalid location combination, valid auth
-- EXPECTED OUTPUT = 'Location does not exist'
SET @EXPECTED = 'Location does not exist'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'A',
	@column_id = 3,
	@level_id = 1,
	@palette_id = NULL,
	@auth = 'test',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Update invalid location combination, invalid auth
-- EXPECTED OUTPUT = 'Location does not exist'
SET @EXPECTED = 'Location does not exist'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'P',
	@column_id = 10,
	@level_id = 3,
	@palette_id = NULL,
	@auth = 'tefdasst',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- Update invalid location combination, invalid auth
-- EXPECTED OUTPUT = 'Location does not exist'
SET @EXPECTED = 'Location does not exist'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'P',
	@column_id = 6,
	@level_id = 5,
	@palette_id = NULL,
	@auth = 'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- Update invalid location combination, valid auth
-- EXPECTED OUTPUT = 'Location does not exist'
SET @EXPECTED = 'Location does not exist'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'B',
	@column_id = 4,
	@level_id = 1,
	@palette_id = NULL,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Update valid location combination but unauthorized auth (auth is a personnel)
-- EXPECTED OUTPUT = 'Unauthorized to update location information'
SET @EXPECTED = 'Unauthorized to update location information'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@palette_id = NULL,
	@auth = 'jordan',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Update valid location combination but unauthorized auth (auth is NOT a personnel)
-- EXPECTED OUTPUT = 'Unauthorized to update location information'
SET @EXPECTED = 'Unauthorized to update location information'
EXEC dbo.uspUpdateLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@palette_id = NULL,
	@auth = 'asdf',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyLocationInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspUpdateLocationInformation'

--SET NOCOUNT ON
--SELECT * FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
--SELECT * FROM dbo.locations
--SET NOCOUNT OFF

SET NOCOUNT ON
DELETE FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
DELETE FROM dbo.locations WHERE (row_id='A' AND column_id=1 AND level_id=1) OR (row_id='A' AND column_id=2 AND level_id=3) OR (row_id='P' AND column_id=10 AND level_id=2)
DELETE FROM dbo.personnel WHERE username IN ('hoa', 'jordan')
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username IN ('hoa', 'jordan'))
OR EXISTS (SELECT 1 FROM dbo.locations WHERE (row_id='A' AND column_id=1 AND level_id=1) OR (row_id='A' AND column_id=2 AND level_id=3) OR (row_id='P' AND column_id=10 AND level_id=2))
OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123'))
	PRINT 'Unable to clear all data used to test uspUpdateLocationInformation'