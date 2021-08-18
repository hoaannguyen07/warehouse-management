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
-- EXPECTED OUTPUT = 'SUCCESS'
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


-- ============================================================================
-- TEST 2
-- Update valid palette w/ valid information, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @test_unit_mass = 2
SET @test_amount = 3
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'corn ',
	@manufacturing_date = '07/12/2018',
	@expiration_date = '01/12/2022',
	@order_num = 'ABCD',
	@order_date = '23/06/2021',
	@delivery_date = '01/07/2021',
	@type_name = 'phuy',
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
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 3
-- Update valid palette w/ valid information, valid @auth
-- EXPECTED OUTPUT = 'SUCCESS'
SET @EXPECTED = 'SUCCESS'
SET @test_unit_mass = 2
SET @test_amount = 3
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspUpdatePaletteInformation
	@id = 'BP123',
	@product_name = 'flour',
	@manufacturing_date = '03/11/2020',
	@expiration_date = '07/09/2023',
	@order_num = 'VN123',
	@order_date = '17/02/2022',
	@delivery_date = '20/02/2022',
	@type_name = 'tank',
	@type_unit = 'phuy',
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
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 4
-- Update invalid palette w/ invalid @id, random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Palette ID does not exist'
SET @EXPECTED = 'Palette ID does not exist'
SET @test_unit_mass = 2
SET @test_amount = 3
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspUpdatePaletteInformation
	@id = 'abcd', -- invalid id
	@product_name = 'flour',
	@manufacturing_date = '11/21/2020', -- invalid date
	@expiration_date = '07/09/2023',
	@order_num = 'VN123',
	@order_date = '17/02/2022',
	@delivery_date = '2/24/2021', -- invalid date
	@type_name = 'bao', -- invaldi type
	@type_unit = 'phuy',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@auth = 'la', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 5
-- Update invalid palette w/ invalid @id, random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Palette ID does not exist'
SET @EXPECTED = 'Palette ID does not exist'
SET @test_unit_mass = 2
SET @test_amount = 3
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspUpdatePaletteInformation
	@id = 'aasdg', -- invalid id
	@product_name = 'flour',
	@manufacturing_date = '26/02/2018',
	@expiration_date = '07/09/2023',
	@order_num = 'VN123',
	@order_date = '11/14/2022', -- invalid date
	@delivery_date = '2/24/2021', -- invalid date
	@type_name = 'leaf', -- invalid type
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@auth = 'asdlkfj', -- invalid id	
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 6
-- Update invalid palette w/ invalid @id, random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Palette ID does not exist'
SET @EXPECTED = 'Palette ID does not exist'
SET @test_unit_mass = 5
SET @test_amount = 3
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspUpdatePaletteInformation
	@id = 'BP12', -- invalid id
	@product_name = 'flour',
	@manufacturing_date = '01/03/2019',
	@expiration_date = '07/09/2023',
	@order_num = 'VN123',
	@order_date = '03/14/2020', -- invalid date
	@delivery_date = '5/26/2021', -- invalid date
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
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 7
-- Update invalid palette w/ valid @id, invalid man. date, random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid manufacturing date'
SET @EXPECTED = 'Invalid manufacturing date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = @test_unit_mass * @test_amount
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'sus',
	@manufacturing_date = '03/14/2020', -- invalid date
	@expiration_date = '07/09/2023',
	@order_num = 'VN123',
	@order_date = '03/14/2020', -- invalid date
	@delivery_date = '5/26/2021', -- invalid date
	@type_name = 'corn', -- invalid type
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 0,
	@auth = 'asdf', -- invalid id
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 8
-- Update invalid palette w/ valid @id, invalid man. date, random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid manufacturing date'
SET @EXPECTED = 'Invalid manufacturing date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'BP123',
	@product_name = 'dread',
	@manufacturing_date = '03/14/2020', -- invalid date
	@expiration_date = '03/14/2020', -- invalid date
	@order_num = 'VN123',
	@order_date = '07/09/2023',
	@delivery_date = '5/26/2021', -- invalid date
	@type_name = 'sigh', -- invalid type
	@type_unit = 'nuggets',
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
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 9
-- Update invalid palette w/ valid @id, invalid man. date, random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid manufacturing date'
SET @EXPECTED = 'Invalid manufacturing date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'AVP010',
	@product_name = 'dread',
	@manufacturing_date = '03/14/2020', -- invalid date
	@expiration_date = '03/14/2020', -- invalid date
	@order_num = 'VN123',
	@order_date = '5/26/2021', -- invalid date
	@delivery_date = '07/09/2023', 
	@type_name = 'bao',
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 10
-- Update invalid palette w/ valid @id, valid man. date, invalid exp. date 
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid expiration date'
SET @EXPECTED = 'Invalid expiration date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'AVP010',
	@product_name = 'misery',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '5/26/2021', -- invalid date
	@order_num = 'existential dread',
	@order_date = '7/21/2021', -- invalid date
	@delivery_date = '23/04/2019',
	@type_name = 'bao',
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'kj', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 11
-- Update invalid palette w/ valid @id, valid man. date, invalid exp. date 
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid expiration date'
SET @EXPECTED = 'Invalid expiration date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'AVP010',
	@product_name = 'misery',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '1/15/2020', -- invalid date
	@order_num = 'existential dread',
	@order_date = '03/04/2020',
	@delivery_date = '6/16/2022', -- invalid date
	@type_name = 'bao',
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'kj', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 12
-- Update invalid palette w/ valid @id, valid man. date, invalid exp. date 
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid expiration date'
SET @EXPECTED = 'Invalid expiration date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'fun',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '3/24/2021', -- invalid date
	@order_num = 'existential dread',
	@order_date = '9/27/2018', -- invalid date
	@delivery_date = '6/16/2022', -- invalid date
	@type_name = 'lamp', -- invalid type
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 13
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, invalid order date
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid order date'
SET @EXPECTED = 'Invalid order date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'fun',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '10/17/2018', -- invalid date
	@delivery_date = '14/08/2020',
	@type_name = 'chicken', -- invalid type
	@type_unit = 'sausage',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 14
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, invalid order date
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid order date'
SET @EXPECTED = 'Invalid order date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'fun',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '10/17/2018', -- invalid date
	@delivery_date = '1/24/2022', -- invalid date
	@type_name = 'phuy',
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = '#demoralizing', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 15
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, invalid order date
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid order date'
SET @EXPECTED = 'Invalid order date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'fun',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '10/17/2018', -- invalid date
	@delivery_date = '1/24/2022', -- invalid date
	@type_name = 'valorant', -- invalid type
	@type_unit = 'lost ark',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = '#demoralizing', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 16
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, valid order date, invalid deliv. date
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid delivery date'
SET @EXPECTED = 'Invalid delivery date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'fun',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '8/22/2019', -- invalid date
	@type_name = 'sun', -- invalid type
	@type_unit = 'moon',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 17
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, valid order date, invalid deliv. date
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid delivery date'
SET @EXPECTED = 'Invalid delivery date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '8/22/2019', -- invalid date
	@type_name = 'tank',
	@type_unit = 'phuy',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'hello', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 18
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, valid order date, invalid deliv. date
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid delivery date'
SET @EXPECTED = 'Invalid delivery date'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '8/22/2019', -- invalid date
	@type_name = 'tank',
	@type_unit = 'phuy',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 19
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, valid order date, valid deliv. date, invalid type
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid type'
SET @EXPECTED = 'Invalid type'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '03/08/2020',
	@type_name = 'trap', -- invalid type
	@type_unit = 'CS major',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'asdf', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 20
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, valid order date, valid deliv. date, invalid type
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid type'
SET @EXPECTED = 'Invalid type'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '03/08/2020',
	@type_name = 'trap', -- invalid type
	@type_unit = 'phuy',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'hoa',
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 21
-- Update invalid palette w/ valid @id, valid man. date, valid exp. date, valid order date, valid deliv. date, invalid type
-- random valid/invalid information for other params
-- EXPECTED OUTPUT = 'Invalid type'
SET @EXPECTED = 'Invalid type'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '03/08/2020',
	@type_name = 'bao', -- invalid type
	@type_unit = 'phuy',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'sike', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 22
-- Update invalid palette w/ valid everything but @auth
-- EXPECTED OUTPUT = 'Unauthorized to update palette information'
SET @EXPECTED = 'Unauthorized to update palette information'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'BP123',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '03/08/2020',
	@type_name = 'bao',
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'sike', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 23
-- Update invalid palette w/ valid everything but @auth
-- EXPECTED OUTPUT = 'Unauthorized to update palette information'
SET @EXPECTED = 'Unauthorized to update palette information'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'AVP010',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '03/08/2020',
	@type_name = 'bao',
	@type_unit = 'kg',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'asdf', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
SET @test_num = @test_num + 1
-- ============================================================================


-- ============================================================================
-- TEST 24
-- Update invalid palette w/ valid everything but @auth
-- EXPECTED OUTPUT = 'Unauthorized to update palette information'
SET @EXPECTED = 'Unauthorized to update palette information'
SET @test_unit_mass = 15
SET @test_amount = 10
SET @test_total_mass = (@test_unit_mass * @test_amount) - 5
EXEC dbo.uspUpdatePaletteInformation
	@id = 'SA001',
	@product_name = 'apt',
	@manufacturing_date = '18/11/2022',
	@expiration_date = '12/10/2021', 
	@order_num = 'numbing existence',
	@order_date = '20/04/2020',
	@delivery_date = '03/08/2020',
	@type_name = 'tank',
	@type_unit = 'phuy',
	@unit_mass = @test_unit_mass,
	@amount =  @test_amount,
	@total_mass = @test_total_mass,
	@being_delivered = 1,
	@auth = 'asdf', -- invalid auth
	@response = @response OUTPUT
IF (@response <> @EXPECTED)
BEGIN
	PRINT CONCAT('uspUpdatePersonnelFullName TEST ', @test_num,' FAILED')
	PRINT CONCAT('Expected: ', @EXPECTED)
	PRINT CONCAT('Result: ', @response)
END
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