USE warehouse_management
GO

-- create a new palette in the database (only create the palette. anything that is to be put onto the palette has to use the "update palette" procedure)
--EXEC [dbo].[uspCreatePalette]
--	@palette_id nvarchar(10), -- id this new palette will be set as. Will ONLY take the first 10 characters of an nvarchar so if more than 10 chars are used, make sure the first 10 are unique in DB as the rest will be truncated
--	@auth nvarchar(50), -- username of person who wants to create this palette (used to verify that the person actually has permission to create new palettes)
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Palette ID already exists' -> palette id already exists in the database and palette ids' have to be unique in this database
--		2. ERROR: 'Unauthorized to create palettes' -> @auth does not have the permission to create palettes
--		3. ERROR: ERROR_MESSAGE() -> something went wrong during the INSERT operation of the new palette into the database (unforseen error that wasn't checked for beforehand)
--		4. 'SUCCESS' -> successfully inserted the new palette into database (initialize nullable attributes to null, which could be updated using the "update palette" procedure)

CREATE OR ALTER PROCEDURE [dbo].[uspCreatePalette]
	@palette_id nvarchar(10),
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @create_palette_response nvarchar(256) = NULL

	-- make sure that palette id is unique
	IF NOT EXISTS (SELECT id FROM dbo.palettes WHERE id = @palette_id)
	BEGIN
		-- check authorization
		DECLARE @authorization_response nvarchar(3)

		EXEC dbo.uspCheckPersonnelPermission
			@username = @auth,
			@action = 'create',
			@object = 'palettes',
			@response = @authorization_response OUTPUT

		-- make sure @auth has the authorization to create palettes
		IF (@authorization_response = 'YES')
		BEGIN
			BEGIN TRY
				INSERT INTO dbo.palettes(id, created_by) VALUES (
					@palette_id, 
					(SELECT id FROM dbo.personnel WHERE username=@auth)
				)

				-- make sure that the palette now exists in the database
				IF EXISTS (SELECT id FROM dbo.palettes WHERE id = @palette_id AND created_by = (SELECT id FROM dbo.personnel WHERE username=@auth))
					SET @create_palette_response = 'SUCCESS'
			END TRY
			BEGIN CATCH
				SET @create_palette_response = ERROR_MESSAGE()
			END CATCH
		END
		ELSE
		BEGIN
			SET @create_palette_response = 'Unauthorized to create palettes'
		END
	END
	ELSE
	BEGIN
		SET @create_palette_response = 'Palette ID already exists'
	END

	SET @response = @create_palette_response
	--SELECT @response AS response
END
