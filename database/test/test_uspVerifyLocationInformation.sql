-- TEST uspVerifyLocationInformation



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

PRINT 'TESTING USER STORED PROCEDURE uspVerifyLocationInformation'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Verify valid, newly created location
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'

-- set up what a brand new location will look like
SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = NULL,
last_modified_by = NULL
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@is_empty = 1,
	@palette_id = NULL,
	@last_modified_by = NULL,
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
-- Verify valid, newly created location
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'

-- set up what a brand new location will look like
SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = NULL,
last_modified_by = NULL
WHERE row_id = 'A' AND column_id = 2 AND level_id = 3
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@is_empty = 1,
	@palette_id = NULL,
	@last_modified_by = NULL,
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
-- Verify valid, newly created location
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'

-- set up what a brand new location will look like
SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = NULL,
last_modified_by = NULL
WHERE row_id = 'P' AND column_id = 10 AND level_id = 2
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'P',
	@column_id = 10,
	@level_id = 2,
	@is_empty = 1,
	@palette_id = NULL,
	@last_modified_by = NULL,
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
-- Verify invalid location (different location combinations each time)
-- EXPECTED OUTPUT = 'Invalid location'
SET @EXPECTED = 'Invalid location'

-- set up what a brand new location will look like
SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = NULL,
last_modified_by = NULL
WHERE row_id = 'P' AND column_id = 10 AND level_id = 2
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 5,
	@level_id = 4,
	@is_empty = 1,
	@palette_id = 'haiya',
	@last_modified_by = 'Mark Cuban',
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
-- Verify invalid location (different location combinations each time)
-- EXPECTED OUTPUT = 'Invalid location'
SET @EXPECTED = 'Invalid location'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = NULL,
last_modified_by = NULL
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'B',
	@column_id = 8,
	@level_id = 1,
	@is_empty = 0,
	@palette_id = NULL,
	@last_modified_by = 'TAMU',
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
-- Verify invalid location (different location combinations each time)
-- EXPECTED OUTPUT = 'Invalid location'
SET @EXPECTED = 'Invalid location'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = 'SA001',
last_modified_by = NULL
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'B',
	@column_id = 8,
	@level_id = 1,
	@is_empty = 0,
	@palette_id = 'SA001',
	@last_modified_by = 'Texas',
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
-- Verify valid location, invalid is empty status, valid palette id, valid L_M_B
-- EXPECTED OUTPUT = 'Unable to match empty status'
SET @EXPECTED = 'Unable to match empty status'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = 'SA001',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'hoa')
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@is_empty = 0,
	@palette_id = 'SA001',
	@last_modified_by = 'hoa',
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
-- Verify valid location, invalid is empty status, invalid palette id, valid L_M_B
-- EXPECTED OUTPUT = 'Unable to match empty status'
SET @EXPECTED = 'Unable to match empty status'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = 'SA001',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'hoa')
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@is_empty = 1,
	@palette_id = 'BP123',
	@last_modified_by = 'hoa',
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
-- Verify valid location, invalid is empty status, valid palette id, invalid L_M_B
-- EXPECTED OUTPUT = 'Unable to match empty status'
SET @EXPECTED = 'Unable to match empty status'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = 'SA001',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'jordan')
WHERE row_id = 'A' AND column_id = 2 AND level_id = 3
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@is_empty = 1,
	@palette_id = 'BP123',
	@last_modified_by = 'hoa',
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
-- Verify valid location, valid is empty status, invalid palette id, valid L_M_B
-- EXPECTED OUTPUT = 'Unable to match palette id'
SET @EXPECTED = 'Unable to match palette id'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = 'AVP010',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'jordan')
WHERE row_id = 'A' AND column_id = 2 AND level_id = 3
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@is_empty = 0,
	@palette_id = NULL,
	@last_modified_by = 'jordan',
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
-- Verify valid location, valid is empty status, invalid palette id, valid L_M_B
-- EXPECTED OUTPUT = 'Unable to match palette id'
SET @EXPECTED = 'Unable to match palette id'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = NULL,
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'hoa')
WHERE row_id = 'P' AND column_id = 10 AND level_id = 2
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'P',
	@column_id = 10,
	@level_id = 2,
	@is_empty = 0,
	@palette_id = 'SA001',
	@last_modified_by = 'hoa',
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
-- Verify valid location, valid is empty status, invalid palette id, invalid L_M_B
-- EXPECTED OUTPUT = 'Unable to match palette id'
SET @EXPECTED = 'Unable to match palette id'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = 'SA001',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'hoa')
WHERE row_id = 'P' AND column_id = 10 AND level_id = 2
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'P',
	@column_id = 10,
	@level_id = 2,
	@is_empty = 0,
	@palette_id = 'BP123',
	@last_modified_by = 'jordan',
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
-- TEST 13
-- Verify valid location, valid is empty status, valid palette id(NULL), invalid L_M_B
-- EXPECTED OUTPUT = 'Unable to match palette id'
SET @EXPECTED = 'Unable to match last modified by'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = NULL,
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'hoa')
WHERE row_id = 'P' AND column_id = 10 AND level_id = 2
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'P',
	@column_id = 10,
	@level_id = 2,
	@is_empty = 0,
	@palette_id = NULL,
	@last_modified_by = 'jordan',
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
-- TEST 14
-- Verify valid location, valid is empty status, valid palette id, invalid L_M_B
-- EXPECTED OUTPUT = 'Unable to match palette id'
SET @EXPECTED = 'Unable to match last modified by'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = 'AVP010',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'test')
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@is_empty = 1,
	@palette_id = 'AVP010',
	@last_modified_by = 'hoa',
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
-- TEST 15
-- Verify valid location, valid is empty status, valid palette id, invalid L_M_B
-- EXPECTED OUTPUT = 'Unable to match palette id'
SET @EXPECTED = 'Unable to match last modified by'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = 'SA001',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'jordan')
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@is_empty = 1,
	@palette_id = 'SA001',
	@last_modified_by = 'test',
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
-- TEST 16
-- Verify correct location w/ correct non-NULL components (since tests 1-3 already tested NULL components)
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 1,
palette_id = 'SA001',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'jordan')
WHERE row_id = 'A' AND column_id = 1 AND level_id = 1
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 1,
	@level_id = 1,
	@is_empty = 1,
	@palette_id = 'SA001',
	@last_modified_by = 'jordan',
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
-- TEST 17
-- Verify correct location w/ correct non-NULL components (since tests 1-3 already tested NULL components)
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'


SET NOCOUNT ON
UPDATE dbo.locations
SET is_empty = 0,
palette_id = 'AVP010',
last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = 'hoa')
WHERE row_id = 'A' AND column_id = 2 AND level_id = 3
SET NOCOUNT OFF

EXEC dbo.uspVerifyLocationInformation
	@row_id = 'A',
	@column_id = 2,
	@level_id = 3,
	@is_empty = 0,
	@palette_id = 'AVP010',
	@last_modified_by = 'hoa',
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
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspVerifyLocationInformation'

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
	PRINT 'Unable to clear all data used to test uspVerifyLocationInformation'