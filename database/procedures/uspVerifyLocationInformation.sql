USE warehouse_management
GO

-- verify existence of palette in db with all these params
--EXEC [dbo].[uspVerifyLocationInformation]
--	@row_id nvarchar(1),
--	@column_id int,
--	@level_id int,
--	@is_empty binary(1),
--	@palette_id nvarchar(10), -- id of palette that is currently in that location (NULL if there are none)
--	@last_modified_by nvarchar(50), -- username of the person who last modified the specific location
--	@response nvarchar(256) = '' OUTPUT

-- NOTES: for dates, '2020-03-08' = '2020/03/08' = '03/08/2020' = '03-08-2020'

-- OUTPUT(S) (by precedence):
--		1. ERROR: 'Invalid location' -> location [@row_id, @column_id, @level_id] does not exist in the db
--		2. ERROR: 'Unable to match empty status' -> specific location [@row_id, @column_id, @level_id] does not have the inputted empty status
--		3. ERROR: 'Unable to match palette id' -> @palette_id is not currently in the specific location [@row_id, @column_id, @level_id]
--		4. ERROR: 'Unable to match last modified by' -> either the @last_modified_by username is not in the system or it doesn't match with the last modifier of the specified location
--		0. 'SUCCESS' -> there exists a location in the db that has all the params

CREATE OR ALTER PROCEDURE [dbo].[uspVerifyLocationInformation]
	@row_id nvarchar(1),
	@column_id int,
	@level_id int,
	@is_empty binary(1),
	@palette_id nvarchar(10),
	@last_modified_by nvarchar(50),
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	-- check validity of inputted location
	IF NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id=@row_id AND column_id=@column_id AND level_id=@level_id)
	BEGIN
		SET @response = 'Invalid location'
		RETURN (1)
	END

	-- match empty status of the location to inputted param
	IF NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id=@row_id AND column_id=@column_id AND level_id=@level_id AND is_empty=@is_empty)
	BEGIN
		SET @response = 'Unable to match empty status'
		RETURN (2)
	END

	-- match palette id (have to take into account that palette id could be null)
	IF (@palette_id IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id=@row_id AND column_id=@column_id AND level_id=@level_id AND palette_id IS NULL)
		BEGIN
			SET @response = 'Unable to match palette id'
			RETURN (3)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM dbo.locations WHERE row_id=@row_id AND column_id=@column_id AND level_id=@level_id AND palette_id=@palette_id)
		BEGIN
			SET @response = 'Unable to match palette id'
			RETURN (3)
		END
	END

	-- match last modified by (could also be null, i.e. when the location is first created and there has not been any modifications made yet)
	IF (@last_modified_by IS NULL)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.locations WHERE row_id=@row_id AND column_id=@column_id AND level_id=@level_id AND last_modified_by IS NULL)
		BEGIN
			SET @response = 'Unable to match last modified by'
			RETURN (3)
		END
	END
	ELSE
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM dbo.locations 
						WHERE row_id=@row_id 
						AND column_id=@column_id 
						AND level_id=@level_id 
						AND last_modified_by=(SELECT TOP 1 id FROM dbo.personnel WHERE username = @last_modified_by))
		BEGIN
			SET @response = 'Unable to match last modified by'
			RETURN (3)
		END
	END

	-- since all information matched in the system, return success
	SET @response = 'SUCCESS'
	RETURN (0)
END