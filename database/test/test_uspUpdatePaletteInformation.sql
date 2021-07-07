-- TEST uspUpdatePaletteInformation



USE [warehouse_management]
GO

SET NOCOUNT ON
DELETE FROM dbo.personnel WHERE username='hoa'
SET NOCOUNT OFF

DECLARE @EXPECTED NVARCHAR(256)
DECLARE @test_unit_mass INT
DECLARE @test_amount INT
DECLARE @test_total_mass INT
DECLARE @response NVARCHAR(256)
DECLARE @test_num INT = 1

SET NOCOUNT ON
-- create test personnel to be used in the test
EXEC dbo.uspCreatePersonnel
	@username = 'hoa',
	@password = 'hoa123',
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
	WHERE action_id=(SELECT id FROM dbo.permission_actions WHERE action = 'update') 
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

-- create a few types to use
EXEC dbo.uspCreateType
	@name = 'bao',
	@unit = 'kg',
	@auth = 'test'
EXEC dbo.uspCreateType
	@name = 'phuy',
	@unit = 'kg',
	@auth = 'test'
EXEC dbo.uspCreateType
	@name = 'tank',
	@unit = 'phuy',
	@auth = 'test'
SET NOCOUNT OFF

--SELECT * FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')

--SELECT dbo.personnel.username, dbo.personnel.full_name, dbo.permission_actions.action, dbo.permission_objects.object
--FROM dbo.personnel_permissions
--INNER JOIN dbo.personnel
--ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
--INNER JOIN dbo.permissions
--ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
--INNER JOIN dbo.permission_actions
--ON dbo.permissions.action_id = dbo.permission_actions.id
--INNER JOIN dbo.permission_objects
--ON dbo.permissions.object_id = dbo.permission_objects.id
--WHERE dbo.personnel.username = 'hoa' 
----AND dbo.permission_actions.action = @action 
----AND dbo.permission_objects.object = @object

PRINT 'TESTING USER STORED PROCEDURE uspUpdatePaletteInformation'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Update valid palette w/ valid information, valid @auth
-- EXPECTED OUTPUT = 'Username does not exist'
SET @EXPECTED = 'SUCCESS'
SET @test_unit_mass = 20
SET @test_amount = 10
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspUpdatePaletteInformation
	@id = 'AVP010',
	@product_name = 'rice grain',
	@manufacturing_date = '02/03/2020',
	@expiration_date = '13/02/2022',
	@order_num = '',
	@order_date = NULL,
	@delivery_date = '01/07/2021',
	@type_name = 'bao',
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
--SELECT * FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
--SELECT TOP 1 id FROM dbo.types WHERE name = 'bao' AND unit = 'kg'
--SELECT TOP 1 id FROM dbo.personnel WHERE username = 'hoa'
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspUpdatePaletteInformation'

SET NOCOUNT ON
DELETE FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
DELETE FROM dbo.personnel WHERE username = 'hoa'
DELETE FROM dbo.types WHERE name IN ('bao', 'phuy', 'tank')
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username = 'hoa')
OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123'))
OR EXISTS (SELECT 1 FROM dbo.types WHERE name IN ('bao', 'phuy', 'tank'))
	PRINT 'Unable to clear all data used to test uspUpdatePaletteInformation'