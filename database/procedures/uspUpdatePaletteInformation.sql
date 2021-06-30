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


-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Palette ID does not exist' -> id of palette trying to update does not exist in the system
--		2. ERROR: 'Invalid manufacturing date' -> manufacturing date is not a valid date
--		3. ERROR: 'Invalid expiration date' -> expiration date is not a valid date
--		4. ERROR: 'Invalid order date' -> order date is not a valid date
--		5. ERROR: 'Invalid delivery date' -> delivery date is not a valid date
--		6. ERROR: 'Invalid type' -> container with name = @type_name and measured in @type_unit does not exist in the db
--		7. ERROR: 'Unauthorized to update palette information' -> @auth does not have the permission to update palette information
--		8. ERROR: ERROR_MESSAGE() -> error occurred during the UPDATE operation of that was unaccounted for (but passed all previous checks)
--		9. 'SUCCESS' -> successfully updated the information of palette id = @id


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
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @update_palette_information_response nvarchar(256) = NULL
	
	
	-- check existence of palette id = @id
	IF EXISTS (SELECT id FROM dbo.palettes WHERE id = @id)
	BEGIN
		DECLARE @converted_manufacturing_date date

		-- try converting manufacturing date to SQL preferred date
		BEGIN TRY
			-- convert to string to date, where the string contains a date in the form of code 103 ('DD/MM/YYYY')
			SET @converted_manufacturing_date = (SELECT CONVERT(date, @manufacturing_date, 103)) -- @converted_manufacturing_date = NULL if @manufacturing)date = NULL w/o errors

			DECLARE @converted_expiration_date date

			-- try converting expiration date to SQL preferred date
			BEGIN TRY
				SET @converted_expiration_date = (SELECT CONVERT(date, @expiration_date, 103)) -- @converted_expiration_date = NULL if @expiration_date = NULL w/o errors

				DECLARE @converted_order_date date

				-- try converting order date to SQL preferred date
				BEGIN TRY
					SET @converted_order_date = (SELECT CONVERT(date, @order_date, 103)) -- @converted_order_date = NULL if @expiration_date = NULL w/o errors

					-- try converting delviery date to SQL preferred date
					DECLARE @converted_delivery_date date
					BEGIN TRY
						SET @converted_delivery_date = (SELECT CONVERT(date, @delivery_date, 103)) -- @converted_order_date = NULL if @expiration_date = NULL w/o errors

						-- check if type exists
						IF EXISTS (SELECT TOP 1 id FROM dbo.types WHERE name = @type_name AND unit = @type_unit)
						BEGIN
							-- check authorization
							DECLARE @authorization_response nvarchar(3)

							EXEC dbo.uspCheckPersonnelPermission
								@username = @auth,
								@action = 'update',
								@object = 'palettes',
								@response = @authorization_response OUTPUT

							IF (@authorization_response = 'YES')
							BEGIN
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
										SET @update_palette_information_response = 'SUCCESS' 
									END
									ELSE
									BEGIN
										DECLARE @message nvarchar(256) = NULL
										SET @message = CONCAT('The UPDATE operation was unable update palette ', @id, '''s information')

										RAISERROR(
											@message, -- Message
											16, -- Severity
											1 -- State
										)
									END
								END TRY

								-- catch any errors that occurred during the update operation
								BEGIN CATCH
									SET @update_palette_information_response = ERROR_MESSAGE()
								END CATCH
							END
							ELSE
							BEGIN
								SET @update_palette_information_response = 'Unauthorized to update palette information'
							END
							-- finished checking authorization of @auth to make sure he/she has the permission to update the palettes table
						END

						ELSE
						BEGIN
							SET @update_palette_information_response = 'Invalid type'
						END
						-- finished checking if the inputted type exists

					END TRY

					-- catch errors from converting delivery date
					BEGIN CATCH
						SET @update_palette_information_response = 'Invalid delivery date'
					END CATCH
					-- finished attempt to convert delivery date

				END TRY

				-- catch errors from converting order date
				BEGIN CATCH
					SET @update_palette_information_response = 'Invalid order date'
				END CATCH 
				-- finished attempt to convert order date
			END TRY

			-- catch errors from converting expiration date
			BEGIN CATCH
				SET @update_palette_information_response = 'Invalid expiration date'
			END CATCH 
			-- finished attempt to convert expiration date

		END TRY

		-- catch errors from converting manufacturing date
		BEGIN CATCH 
			SET @update_palette_information_response = 'Invalid manufacturing date'
		END CATCH
		-- finished attempt to convert manufacturing date

	END
	-- palette id = @id does NOT exist in the db
	ELSE 
	BEGIN
		SET @update_palette_information_response = 'Palette ID does not exist'
	END -- finished checking existence of @id in the db

	SET @response = @update_palette_information_response
	--SELECT @response AS response
END