-- TEST uspVerifyPaletteInformation



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

--SET NOCOUNT ON
--SELECT * FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
--SET NOCOUNT OFF

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

PRINT 'TESTING USER STORED PROCEDURE uspVerifyPaletteInformation'
PRINT 'BEGINNING TEST...'
-- ============================================================================
-- TEST 1
-- Verify valid palette
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @test_unit_mass = NULL
SET @test_amount = NULL
SET @test_total_mass = 0
EXEC dbo.uspVerifyPaletteInformation
	@id = 'SA001',
	@product_name = NULL,
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = NULL,
	@order_num = NULL,
	@converted_order_date = NULL,
	@converted_delivery_date = NULL,
	@type_name = NULL,
	@type_unit = NULL,
	@unit_mass = @test_unit_mass,
	@amount = @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 2
-- Verify valid palette
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @test_unit_mass = NULL
SET @test_amount = NULL
SET @test_total_mass = 0
EXEC dbo.uspVerifyPaletteInformation
	@id = 'AVP010',
	@product_name = NULL,
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = NULL,
	@order_num = NULL,
	@converted_order_date = NULL,
	@converted_delivery_date = NULL,
	@type_name = NULL,
	@type_unit = NULL,
	@unit_mass = @test_unit_mass,
	@amount = @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Verify valid palette
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @test_unit_mass = NULL
SET @test_amount = NULL
SET @test_total_mass = 0
EXEC dbo.uspVerifyPaletteInformation
	@id = 'AVP010',
	@product_name = NULL,
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = NULL,
	@order_num = NULL,
	@converted_order_date = NULL,
	@converted_delivery_date = NULL,
	@type_name = NULL,
	@type_unit = NULL,
	@unit_mass = @test_unit_mass,
	@amount = @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Verify palette w/ invalid @id
-- EXPECTED OUTPUT = 'Invalid ID'
SET @EXPECTED = 'Invalid ID'
SET @test_unit_mass = 413
SET @test_amount = 123
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspVerifyPaletteInformation
	@id = 'Yikes',
	@product_name = 'Exciting',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = NULL,
	@order_num = NULL,
	@converted_order_date = '01/03/2018',
	@converted_delivery_date = NULL,
	@type_name = NULL,
	@type_unit = 'fun',
	@unit_mass = 413,
	@amount = 123,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@last_modified_by = 'sun',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Verify palette w/ invalid @id (different subsequent information)
-- EXPECTED OUTPUT = 'Invalid ID'
SET @EXPECTED = 'Invalid ID'
EXEC dbo.uspVerifyPaletteInformation
	@id = 'funny',
	@product_name = 'raining',
	@converted_manufacturing_date = '12/08/2020',
	@converted_expiration_date = NULL,
	@order_num = 'JL2423',
	@converted_order_date = '01/03/2018',
	@converted_delivery_date = NULL,
	@type_name = NULL,
	@type_unit = 'fun',
	@unit_mass = 30,
	@amount = NULL,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = 'moon',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Verify palette w/ invalid @id (different subsequent information)
-- EXPECTED OUTPUT = 'Invalid ID'
SET @EXPECTED = 'Invalid ID'
EXEC dbo.uspVerifyPaletteInformation
	@id = 'asl;dkfj',
	@product_name = '',
	@converted_manufacturing_date = '2012-06-08', -- correct date format in db
	@converted_expiration_date = NULL,
	@order_num = 'JL2423',
	@converted_order_date = NULL,
	@converted_delivery_date = '2020-08-31',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = NULL,
	@amount = 100,
	@total_mass = 1034,
	@being_delivered = 0,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Verify palette w/ valid @id, invalid product_name (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match product name'
SET @EXPECTED = 'Unable to match product name'
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'yikes',
	@converted_manufacturing_date = '2019/01/02', 
	@converted_expiration_date = '03-06-2021', 
	@order_num = NULL,
	@converted_order_date = NULL,
	@converted_delivery_date = NULL,
	@type_name = 'mouse',
	@type_unit = 'brain',
	@unit_mass = 2,
	@amount = 100,
	@total_mass = 200,
	@being_delivered = 0,
	@last_modified_by = 'mom',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Verify palette w/ valid @id, invalid product_name (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match product name'
SET @EXPECTED = 'Unable to match product name'
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = 'vietnam' WHERE id = 'AVP010'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'AVP010',
	@product_name = NULL,
	@converted_manufacturing_date = '2019/01/02', 
	@converted_expiration_date = '03-06-2021', 
	@order_num = NULL,
	@converted_order_date = NULL,
	@converted_delivery_date = NULL,
	@type_name = 'mouse',
	@type_unit = 'brain',
	@unit_mass = 2,
	@amount = 100,
	@total_mass = 200,
	@being_delivered = 0,
	@last_modified_by = 'mom',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL WHERE id = 'AVP010'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- Verify palette w/ valid @id, invalid product_name (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match product name'
SET @EXPECTED = 'Unable to match product name'
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = 'vietnam' WHERE id = 'SA001'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'SA001',
	@product_name = 'usa',
	@converted_manufacturing_date = '', 
	@converted_expiration_date = NULL, 
	@order_num = NULL,
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = '03-06-2021', 
	@type_name = 'sock',
	@type_unit = 'mouse',
	@unit_mass = 2,
	@amount = 100,
	@total_mass = 200,
	@being_delivered = 0,
	@last_modified_by = 'computer',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL WHERE id = 'SA001'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- Verify palette w/ valid @id, invalid product_name (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match product name'
SET @EXPECTED = 'Unable to match product name'
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = 'vietnam' WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'asdasdf',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = NULL,
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'sock',
	@type_unit = '',
	@unit_mass = 100,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Verify palette w/ valid @id, valid product_name, invalid order_num (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match order num'
SET @EXPECTED = 'Unable to match order num'
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = 'rice', order_num = '01010' WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = NULL,
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'sock',
	@type_unit = '',
	@unit_mass = 100,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Verify palette w/ valid @id, valid product_name, invalid order_num (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match order num'
SET @EXPECTED = 'Unable to match order num'
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = 'rice', order_num = '01010' WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = NULL,
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'sock',
	@type_unit = '',
	@unit_mass = 100,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 13
-- Verify palette w/ valid @id, valid product_name, invalid order_num (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match order num'
SET @EXPECTED = 'Unable to match order num'
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = 'rice', order_num = '01010' WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = NULL,
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'sock',
	@type_unit = '',
	@unit_mass = 100,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 14
-- Verify palette w/ valid @id, valid product_name, valid order_num, invalid type (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match type'
SET @EXPECTED = 'Unable to match type'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg')
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'sock',
	@type_unit = NULL,
	@unit_mass = 100,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 15
-- Verify palette w/ valid @id, valid product_name, valid order_num, invalid type (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match type'
SET @EXPECTED = 'Unable to match type'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg')
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = NULL,
	@type_unit = 'kg',
	@unit_mass = 100,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 16
-- Verify palette w/ valid @id, valid product_name, valid order_num, invalid type (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match type'
SET @EXPECTED = 'Unable to match type'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg')
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'ant',
	@type_unit = 'kg',
	@unit_mass = 100,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 17
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, invalid unit mass (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match unit mass'
SET @EXPECTED = 'Unable to match unit mass'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 3
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = NULL,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 18
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, invalid unit mass (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match unit mass'
SET @EXPECTED = 'Unable to match unit mass'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 8,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 19
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, invalid unit mass (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match unit mass'
SET @EXPECTED = 'Unable to match unit mass'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 25
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 30,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 20
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, invalid amount (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match amount'
SET @EXPECTED = 'Unable to match amount'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 25,
amount = 10
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 25,
	@amount = 1,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL, amount = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 21
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, invalid amount (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match amount'
SET @EXPECTED = 'Unable to match amount'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = NULL,
amount = 10
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = NULL,
	@amount = NULL,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL, amount = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 22
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, invalid amount (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match amount'
SET @EXPECTED = 'Unable to match amount'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 30
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 15,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL, amount = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 23
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, invalid amount (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match amount'
SET @EXPECTED = 'Unable to match amount'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 5,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL, amount = NULL WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 24
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, invalid total mass (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match total mass'
SET @EXPECTED = 'Unable to match total mass'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 0,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL, amount = NULL, total_mass = 0 WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 25	
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, invalid total mass (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match total mass'
SET @EXPECTED = 'Unable to match total mass'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = NULL,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL, amount = NULL, total_mass = 0 WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 26
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, invalid total mass (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match total mass'
SET @EXPECTED = 'Unable to match total mass'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 30
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 50,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes SET product_name = NULL, order_num = NULL, type_id = NULL, unit_mass = NULL, amount = NULL, total_mass = 0 WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 27
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, invalid manufacturing date (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match manufacturing date'
SET @EXPECTED = 'Unable to match manufacturing date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08' -- '2020/03/08' is equal to '2020-03-08' when comparing dates
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = NULL,
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL 
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 28
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, invalid manufacturing date (different subsequent information)
-- EXPECTED OUTPUT = 'Unable to match manufacturing date'
SET @EXPECTED = 'Unable to match manufacturing date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08' -- '2020/03/08' is equal to '2020-03-08' when comparing dates
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '08/03/2020',
	@converted_expiration_date = '03-06-2021', 
	@order_num = '001',
	@converted_order_date = '2019/01/02', 
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL 
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 29
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date (but american format)
-- EXPECTED OUTPUT = 'Unable to match expiration date'
SET @EXPECTED = 'Unable to match expiration date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08' -- '2020/03/08' is equal to '2020-03-08' when comparing dates
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '03/08/2020', -- US date format of the correct date
	@converted_expiration_date = '03-06-2021',
	@order_num = '001',
	@converted_order_date = '2019/01/02',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL 
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 30
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date (but american format)
-- EXPECTED OUTPUT = 'Unable to match expiration date'
SET @EXPECTED = 'Unable to match expiration date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08' -- '2020/03/08' is equal to '2020-03-08' when comparing dates
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '03-08-2020', -- US date format of the correct date
	@converted_expiration_date = '03-06-2021',
	@order_num = '001',
	@converted_order_date = '2019/01/02',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL 
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 31
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date (but american format)
-- EXPECTED OUTPUT = 'Unable to match expiration date'
SET @EXPECTED = 'Unable to match expiration date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08' -- '2020/03/08' is equal to '2020-03-08' when comparing dates
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020/03/08', -- US date format of the correct date
	@converted_expiration_date = '03-06-2021',
	@order_num = '001',
	@converted_order_date = '2019/01/02',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL 
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 32
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, invalid expiration date
-- EXPECTED OUTPUT = 'Unable to match expiration date'
SET @EXPECTED = 'Unable to match expiration date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09'
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '03/08/2020', -- US date format of the correct date
	@converted_expiration_date = '03-06-2021',
	@order_num = '001',
	@converted_order_date = '2019/01/02',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 33
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, invalid expiration date
-- EXPECTED OUTPUT = 'Unable to match expiration date'
SET @EXPECTED = 'Unable to match expiration date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09'
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = NULL,
	@order_num = '001',
	@converted_order_date = '2019/01/02',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 34
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, invalid expiration date
-- EXPECTED OUTPUT = 'Unable to match expiration date'
SET @EXPECTED = 'Unable to match expiration date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '2025-08-09',
	@order_num = '001',
	@converted_order_date = '2019/01/02',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 35
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, invalid order date
-- EXPECTED OUTPUT = 'Unable to match order date'
SET @EXPECTED = 'Unable to match order date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2019/01/02',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL,
expiration_date = NULL,
order_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 36
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, invalid order date
-- EXPECTED OUTPUT = 'Unable to match order date'
SET @EXPECTED = 'Unable to match order date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08'
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '02/01/2020',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 37
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- EXPECTED OUTPUT = 'Unable to match order date'
SET @EXPECTED = 'Unable to match order date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08'
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = NULL,
	@converted_delivery_date = '03/08/2022',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 38
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- invalid delivery date
-- EXPECTED OUTPUT = 'Unable to match delivery date'
SET @EXPECTED = 'Unable to match delivery date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-01-14',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 39
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- invalid delivery date
-- EXPECTED OUTPUT = 'Unable to match delivery date'
SET @EXPECTED = 'Unable to match delivery date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01'
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-01-14',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 40
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- invalid delivery date
-- EXPECTED OUTPUT = 'Unable to match delivery date'
SET @EXPECTED = 'Unable to match delivery date'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01'
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = NULL,
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 41
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- valid delivery date, invalid being delivered
-- EXPECTED OUTPUT = 'Unable to match delivery status'
SET @EXPECTED = 'Unable to match delivery status'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01',
being_delivered = 0
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-02-01',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL,
being_delivered = 0
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 42
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- valid delivery date, invalid being delivered
-- EXPECTED OUTPUT = 'Unable to match delivery status'
SET @EXPECTED = 'Unable to match delivery status'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01',
being_delivered = 1
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-02-01',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 0,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL,
being_delivered = 0
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 43
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- valid delivery date, valid being delivered, invalid last modified by
-- EXPECTED OUTPUT = 'Unable to match last modified by'
SET @EXPECTED = 'Unable to match last modified by'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01',
being_delivered = 1,
last_modified_by = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-02-01',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL,
being_delivered = 0,
last_modified_by = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 44
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- valid delivery date, valid being delivered, invalid last modified by
-- EXPECTED OUTPUT = 'Unable to match last modified by'
SET @EXPECTED = 'Unable to match last modified by'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01',
being_delivered = 1,
last_modified_by = (SELECT id FROM dbo.personnel WHERE username = 'hoa')
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-02-01',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = 'jordan',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL,
being_delivered = 0
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 45
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- valid delivery date, valid being delivered, invalid last modified by
-- EXPECTED OUTPUT = 'Unable to match last modified by'
SET @EXPECTED = 'Unable to match last modified by'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01',
being_delivered = 1,
last_modified_by = (SELECT id FROM dbo.personnel WHERE username = 'hoa')
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-02-01',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = NULL,
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL,
being_delivered = 0
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 46
-- Verify palette w/ valid @id, valid product_name, valid order_num, valid type, valid unit mass, 
-- valid amount, valid total mass, valid manufacturing date, valid expiration date, valid order date,
-- valid delivery date, valid being delivered, valid last modified by
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = 'rice', 
order_num = '001',
type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = 'phuy' AND unit = 'kg'),
unit_mass = 50,
amount = 8,
total_mass = 400,
manufacturing_date = '2020-03-08', -- '2020/03/08' is equal to '2020-03-08' when comparing dates
expiration_date = '2025-08-09',
order_date = '2021-01-08',
delivery_date = '2021-02-01',
being_delivered = 1,
last_modified_by = (SELECT id FROM dbo.personnel WHERE username = 'hoa')
WHERE id = 'BP123'
SET NOCOUNT OFF
EXEC dbo.uspVerifyPaletteInformation
	@id = 'BP123',
	@product_name = 'rice',
	@converted_manufacturing_date = '2020-03-08', -- US date format of the correct date
	@converted_expiration_date = '08/09/2025',
	@order_num = '001',
	@converted_order_date = '2021-01-08',
	@converted_delivery_date = '2021-02-01',
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = 50,
	@amount = 8,
	@total_mass = 400,
	@being_delivered = 1,
	@last_modified_by = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspVerifyPaletteInformation TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET NOCOUNT ON
UPDATE dbo.palettes 
SET product_name = NULL, 
order_num = NULL, 
type_id = NULL, 
unit_mass = NULL, 
amount = NULL,
total_mass = 0, 
manufacturing_date = NULL ,
expiration_date = NULL,
order_date = NULL,
delivery_date = NULL,
being_delivered = 0,
last_modified_by = NULL
WHERE id = 'BP123'
SET NOCOUNT OFF
SET @test_num = @test_num + 1
-- ============================================================================

PRINT 'END TEST'
PRINT 'FINISHED TESTING USER STORED PROCEDURE uspVerifyPaletteInformation'

--SET NOCOUNT ON
--SELECT * FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
--SET NOCOUNT OFF

SET NOCOUNT ON
DELETE FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123')
DELETE FROM dbo.personnel WHERE username IN ('hoa', 'jordan')
DELETE FROM dbo.types WHERE name IN ('bao', 'phuy', 'tank')
SET NOCOUNT OFF

IF EXISTS (SELECT 1 FROM dbo.personnel WHERE username IN ('hoa', 'jordan'))
OR EXISTS (SELECT 1 FROM dbo.palettes WHERE id IN ('SA001', 'AVP010', 'BP123'))
OR EXISTS (SELECT 1 FROM dbo.types WHERE name IN ('bao', 'phuy', 'tank'))
	PRINT 'Unable to clear all data used to test uspVerifyPaletteInformation'