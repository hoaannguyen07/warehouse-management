USE warehouse_management
GO

-- verify existence of palette in db with all these params
--EXEC [dbo].[uspVerifyPaletteInformation]
--	@id nvarchar(10), -- id of the palette (will not be updated)
--	@product_name nvarchar(100),
--	@converted_manufacturing_date date,
--	@converted_expiration_date date,
--	@order_num nvarchar(50), -- product's order number
--	@converted_order_date date,
--	@converted_delivery_date date,
--	@type_name nvarchar(10), -- name of container the products are in (i.e. bao, phuy, tank, etc.)
--	@type_unit nvarchar(10), -- mass unit that the container uses (kg, lbs, etc.)
--	@unit_mass int, -- mass of one of the products (mass of 1 bao)
--	@amount int, -- number of products on the palette
--	@total_mass int, -- total mass of the palette
--	@being_delivered binary, -- status of the palette being in the warehouse or on the way to being delivered
--	@last_modified_by nvarchar(50), -- username of the person requesting this palette update
--	@response nvarchar(256) = '' OUTPUT

-- NOTES: for dates, '2020-03-08' = '2020/03/08' = '03/08/2020' = '03-08-2020'

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Invalid ID' -> @id doesn't exist in the db
--		2. ERROR: 'Unable to match product name' -> @product_name doesn't match product_name of @id
--		3. ERROR: 'Unable to match order num' -> @order_num doesn't match order_num of @id
--		4. ERROR: 'Unable to match type' -> inputted type_id doesn't match type_id of @id
--		5. ERROR: 'Unable to match unit mass' -> @unit_mass doesn't match unit_mass of @id
--		6. ERROR: 'Unable to match amount' -> @amount doesn't match amount of @id
--		7. ERROR: 'Unable to match total mass' -> @total_mass doesn't match total_mass of @id
--		8. ERROR: 'Unable to match manufacturing date' -> @converted_manufacturing_date doesn't match manufacturing_date of @id
--		9. ERROR: 'Unable to match expiration date' -> @converted_expiration_date doesn't match expiration_date of @id
--		10. ERROR: 'Unable to match order date' -> @converted_order_date doesn't match order_date of @id
--		11. ERROR: 'Unable to match delivery date' -> @converted_delivery_date doesn't match delivery_date of @id
--		12. ERROR: 'Unable to match delivery status' -> @being_delivered doesn't match being_delivered of @id
--		13. ERROR: 'Unable to match last modified by' -> @last_updated_by doesn't match last_updated_by of @id
--		0. 'SUCCESS' -> there exists a palette in the db that has all the params

CREATE OR ALTER PROCEDURE [dbo].[uspVerifyPaletteInformation]
	@id nvarchar(10),
	@product_name nvarchar(100),
	@converted_manufacturing_date date,
	@converted_expiration_date date,
	@order_num nvarchar(50),
	@converted_order_date date,
	@converted_delivery_date date,
	@type_name nvarchar(10),
	@type_unit nvarchar(10),
	@unit_mass int,
	@amount int,
	@total_mass int,
	@being_delivered binary,
	@last_modified_by nvarchar(50),
	@response nvarchar(256) = NULL OUTPUT
AS 
BEGIN
	SET NOCOUNT ON

	-- check id
	IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id)
	BEGIN
		--PRINT 'Unable to correctly verify id'
		SET @response = 'Invalid ID'
		RETURN (1)
	END
	
	-- check nullable non-date entities
	-- product name
	IF (@product_name IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND product_name IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify product name'
			SET @response = 'Unable to match product name'
			RETURN (2)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND product_name = @product_name)
		BEGIN
			--PRINT 'Unable to correctly verify product name'
			SET @response = 'Unable to match product name'
			RETURN (2)
		END
	END
	-- order num
	IF (@order_num IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND order_num IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify order num'
			SET @response = 'Unable to match order num'
			RETURN (3)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND order_num = @order_num)
		BEGIN
			--PRINT 'Unable to correctly verify order num'
			SET @response = 'Unable to match order num'
			RETURN (3)
		END
	END
	-- type id
	IF (@type_name IS NULL OR @type_unit IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND type_id IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify type id'
			SET @response = 'Unable to match type'
			RETURN (4)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes 
						WHERE id = @id 
						AND type_id = (SELECT TOP 1 id FROM dbo.types WHERE name = @type_name AND unit = @type_unit)
						)
		BEGIN
			(SELECT TOP 1 id FROM dbo.types WHERE name = @type_name AND unit = @type_unit)
			--PRINT 'Unable to correctly verify type id'
			SET @response = 'Unable to match type'
			RETURN (4)
		END
	END
	-- unit mass
	IF (@unit_mass IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND unit_mass IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify unit mass'
			SET @response = 'Unable to match unit mass'
			RETURN (5)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND unit_mass = @unit_mass)
		BEGIN
			--PRINT 'Unable to correctly verify unit mass'
			SET @response = 'Unable to match unit mass'
			RETURN (5)
		END
	END
	-- amount
	IF (@amount IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND amount IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify amount'
			SET @response = 'Unable to match amount'
			RETURN (6)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND amount = @amount)
		BEGIN
			--PRINT 'Unable to correctly verify amount'
			SET @response = 'Unable to match amount'
			RETURN (6)
		END
	END

	-- check total mass
	IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND total_mass = @total_mass)
	BEGIN
		--PRINT 'Unable to correctly verify total mass'
		SET @response = 'Unable to match total mass'
		RETURN (7)
	END

	-- check if dates are correct
	IF (@converted_manufacturing_date IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND manufacturing_date IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify manufacturing date'
			SET @response = 'Unable to match manufacturing date'
			RETURN (8)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND manufacturing_date = @converted_manufacturing_date)
		BEGIN
			--PRINT 'Unable to correctly verify manufacturing date'
			SET @response = 'Unable to match manufacturing date'
			RETURN (8)
		END
	END

	IF (@converted_expiration_date IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND expiration_date IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify expiration date'
			SET @response = 'Unable to match expiration date'
			RETURN (9)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND expiration_date = @converted_expiration_date)
		BEGIN
			--PRINT 'Unable to correctly verify expiration date'
			SET @response = 'Unable to match expiration date'
			RETURN (9)
		END
	END

	IF (@converted_order_date IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND order_date IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify order date'
			SET @response = 'Unable to match order date'
			RETURN (10)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND order_date = @converted_order_date)
		BEGIN
			--PRINT 'Unable to correctly verify order date'
			SET @response = 'Unable to match order date'
			RETURN (10)
		END
	END

	IF (@converted_delivery_date IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND delivery_date IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify delivery date'
			SET @response = 'Unable to match delivery date'
			RETURN (11)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND delivery_date = @converted_delivery_date)
		BEGIN
			--PRINT 'Unable to correctly verify delivery date'
			SET @response = 'Unable to match delivery date'
			RETURN (11)
		END
	END

	-- check being delivered
	IF NOT EXISTS (SELECT id FROM dbo.palettes WHERE id = @id AND being_delivered = @being_delivered)
	BEGIN
		--PRINT 'Unable to correctly verify delivery status'
		SET @response = 'Unable to match delivery status'
		RETURN (12)
	END

	-- check updater
	IF (@last_modified_by IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND last_modified_by IS NULL)
		BEGIN
			--PRINT 'Unable to correctly verify last modified by'
			SET @response = 'Unable to match last modified by'
			RETURN (13)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.palettes WHERE id = @id AND last_modified_by = (SELECT TOP 1 id FROM dbo.personnel WHERE username = @last_modified_by))
		BEGIN
			--PRINT 'Unable to correctly verify last modified by'
			SET @response = 'Unable to match last modified by'
			RETURN (13)
		END
	END

	-- since all information matched in the system, return success
	SET @response = 'SUCCESS'
	RETURN (0)
END