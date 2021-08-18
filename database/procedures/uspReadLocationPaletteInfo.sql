USE warehouse_management
GO

-- create a new palette in the database (only create the palette. anything that is to be put onto the palette has to use the "update palette" procedure)
--EXEC [dbo].[uspReadLocationPaletteInfo]
--	@row nvarchar(1),
--	@col int,
--	@level int,
--	@auth nvarchar(50), -- username of person who wants to read this location's full info
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. ERROR: 'Unauthorized to read full location information' -> @auth does not have the permission to read locations
--		0. 'SUCCESS' -> successfully retrieved information on the palette from the db

CREATE OR ALTER PROCEDURE [dbo].[uspReadLocationPaletteInfo]
	@row nvarchar(1),
	@col int,
	@level int,
	@auth nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check authorization (need to check authorization for reading both palettes and location)
	DECLARE @authorization_response nvarchar(3)

	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'read',
		@object = 'locations',
		@response = @authorization_response OUTPUT
	-- make sure @auth has the authorization to create palettes to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to read full location information'
		RETURN (1)
	END

	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'read',
		@object = 'palettes',
		@response = @authorization_response OUTPUT
	-- make sure @auth has the authorization to create palettes to continue
	IF (@authorization_response = 'NO')
	BEGIN
		SET @response = 'Unauthorized to read full location information'
		RETURN (1)
	END

	-- search for palette information and its corresponding location information from the db
	SELECT locations.row_id, locations.column_id, locations.level_id, locations.is_empty AS loc_empty,
	loc_modifier.full_name AS loc_lmb_name, loc_modifier.username AS loc_lmb_username,
	locations.palette_id, palettes.product_name, palettes.manufacturing_date,
	palettes.expiration_date, palettes.order_num, palettes.order_date, palettes.delivery_date,
	palettes.type_id, palettes.unit_mass, palettes.amount, palettes.total_mass,
	palettes.is_empty AS pal_empty, palettes.last_modified, pal_modifier.full_name AS pal_lmb_name,
	pal_modifier.username AS pal_lmb_username, palettes.being_delivered
	FROM dbo.locations 
	LEFT JOIN dbo.palettes
	ON dbo.locations.palette_id = dbo.palettes.id
	LEFT JOIN dbo.personnel AS pal_modifier
	ON dbo.palettes.last_modified_by = pal_modifier.id
	LEFT JOIN dbo.personnel AS loc_modifier
	ON dbo.locations.last_modified_by = loc_modifier.id
	WHERE dbo.locations.row_id = @row AND dbo.locations.column_id = @col AND dbo.locations.level_id = @level

	SET @response = 'SUCCESS'
	RETURN (0)

END