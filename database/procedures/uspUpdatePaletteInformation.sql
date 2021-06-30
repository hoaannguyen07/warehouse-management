USE warehouse_management
GO

-- update information on a palette in the db (only people with express permission to update palettes will be able to do it)
-- update ALL information on a palette at the same time (can't update palette id, created_date, and created_by)
--EXEC [dbo].[uspUpdatePaletteInformation]
--	@id nvarchar(10), -- id of the palette (will not be updated)
--	@product_name nvarchar(100),
--	@manufacturing_date date,
--	@expiration_date date,
--	@order_num nvarchar(50), -- product's order number
--	@order_date date,
--	@delivery_date date,
--	@type_name nvarchar(10), -- name of container the products are in (i.e. bao, phuy, tank, etc.)
--	@type_unit nvarchar(10), -- mass unit that the container uses (kg, lbs, etc.)
--	@unit_mass int, -- mass of one of the products (mass of 1 bao)
--	@amount int, -- number of products on the palette
--	@being_delivered binary, -- status of the palette being in the warehouse or on the way to being delivered
--	@auth nvarchar(50), -- username of the person requesting this palette update
--	@response nvarchar(256) = '' OUTPUT


-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Palette ID does not exist' -> id of palette trying to update does not exist in the system
--		2. ERROR: 'Invalid manufacturing date' -> manufacturing date is not a valid date
--		3. ERROR: 'Invalid expiration date' -> expiration date is not a valid date
--		4. ERROR: 'Invalid order date' -> order date is not a valid date
--		5. ERROR: 'Invalid delivery date' -> delivery date is not a valid date
--		6. ERROR: 'Invalid type' -> container with name = @type_name and measured in @type_unit does not exist in the db
--		7. ERROR: 'Unauthorized to update palette information' -> @auth does not have the permission to update palette information
--		8. ERROR: ERROR_MESSAGE() -> error occurred during the UPDATE operation of that was unaccounted for (but passed all previous checks)
--		9. ERROR: 'Error occurred during the UPDATE operation' -> something went wrong during the UDPATE operation of the palette but did not cause any errors (or it would've returned ERROR_MESSAGE() instead)
--		0. 'SUCCESS' -> successfully updated the information of palette id = @id


CREATE OR ALTER PROCEDURE [dbo].[uspUpdatePaletteInformation]
	@id nvarchar(10),
	@product_name nvarchar(100),
	@manufacturing_date varchar(10),
	@expiration_date varchar(10),
	@order_num nvarchar(50),
	@order_date varchar(10),
	@delivery_date varchar(10),
	@type_name nvarchar(10),
	@type_unit nvarchar(10),
	@unit_mass int,
	@amount int,
	@being_delivered binary,
	@auth nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check existence of palette id = @id
	IF EXISTS (SELECT id FROM dbo.palettes WHERE id = @id)
	BEGIN
		SET @response = 'Palette ID does not exist'
		RETURN (1)
	END

	-- try converting all dates to make sure that the inputted dates are valid
	DECLARE @converted_manufacturing_date date
	DECLARE @converted_expiration_date date
	DECLARE @converted_order_date date
	DECLARE @converted_delivery_date date

	-- try converting manufacturing date to SQL preferred date
	BEGIN TRY
		-- convert to string to date, where the string contains a date in the form of code 103 ('DD/MM/YYYY')
		SET @converted_manufacturing_date = (SELECT CONVERT(date, @manufacturing_date, 103)) -- @converted_manufacturing_date = NULL if @manufacturing)date = NULL w/o errors
	END TRY
	BEGIN CATCH 
		SET @response = 'Invalid manufacturing date'
		RETURN (2)
	END CATCH

	-- try converting expiration date to SQL preferred date
	BEGIN TRY
		SET @converted_expiration_date = (SELECT CONVERT(date, @expiration_date, 103)) -- @converted_expiration_date = NULL if @expiration_date = NULL w/o errors
	END TRY
	BEGIN CATCH
		SET @response = 'Invalid expiration date'
		RETURN (3)
	END CATCH 

	-- try converting order date to SQL preferred date
	BEGIN TRY
		SET @converted_order_date = (SELECT CONVERT(date, @order_date, 103)) -- @converted_order_date = NULL if @expiration_date = NULL w/o errors
	END TRY
	BEGIN CATCH
		SET @response = 'Invalid order date'
		RETURN (4)
	END CATCH 
	
	-- try converting delviery date to SQL preferred date
	BEGIN TRY
		SET @converted_delivery_date = (SELECT CONVERT(date, @delivery_date, 103)) -- @converted_order_date = NULL if @expiration_date = NULL w/o errors
	END TRY
	BEGIN CATCH
		SET @response = 'Invalid delivery date'
		RETURN (5)
	END CATCH


	-- check if type exists
	IF NOT EXISTS (SELECT TOP 1 id FROM dbo.types WHERE name = @type_name AND unit = @type_unit)
	BEGIN
		SET @response = 'Invalid type'
		RETURN (6)
	END


	-- check authorization
	DECLARE @authorization_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'update',
		@object = 'palettes',
		@response = @authorization_response OUTPUT
	-- must have permission to update palettes in order to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to update palette information'
		RETURN (7)
	END

	-- all verifications have been made so starting updating palette info in the db
	BEGIN TRY
		UPDATE dbo.palettes
		SET product_name = @product_name,
		manufacturing_date = @converted_manufacturing_date,
		expiration_date = @converted_expiration_date,
		order_num = @order_num,
		order_date = @converted_order_date,
		delivery_date = @converted_delivery_date,
		type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = @type_name AND unit = @type_unit),
		unit_mass = @unit_mass,
		amount = @amount,
		total_mass = @unit_mass * @amount,
		last_modified = GETDATE(),
		last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = @auth),
		being_delivered = @being_delivered
		WHERE id = @id
	END TRY
	BEGIN CATCH
		SET @response = ERROR_MESSAGE()
		RETURN (8)
	END CATCH


	-- check if the db actuall updated
	IF EXISTS (SELECT id FROM dbo.palettes
				WHERE product_name = @product_name
				AND manufacturing_date = @converted_manufacturing_date
				AND expiration_date = @converted_expiration_date
				AND order_num = @order_num
				AND order_date = @converted_order_date
				AND delivery_date = @converted_delivery_date
				AND type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = @type_name AND unit = @type_unit)
				AND unit_mass = @unit_mass
				AND amount = @amount
				AND total_mass = @unit_mass * @amount
				AND last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = @auth)
				AND being_delivered = @being_delivered
	)
	BEGIN
		-- palette was succesfully updated to return successful
		SET @response = 'SUCCESS'
		RETURN (0)
	END
	

	-- unable to find the updated entry of the paletteo so the UPDATE operation was unsuccessful
	SET @response = 'Error occurred during the UPDATE operation'
	RETURN (9)
END
GO