USE warehouse_management
GO

-- create all of the permissions this database has to offer (no need for authorization)
--EXEC [dbo].[uspCreateAllPermissions]
--	@response nvarchar(256) = '' OUTPUT

-- OUTPUT(S) (by precedence):
--		1. ERROR_MESSAGE() -> error occurred during the INSERT operation into the permissions table
--		1. 'SUCCESS' -> Successfully created all the possible permissions for this database (skipped creating the permissions that already exists)


CREATE OR ALTER PROCEDURE [dbo].[uspCreateAllPermissions]
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @create_all_permissions_response nvarchar(256) = NULL
	DECLARE @error binary(1) = 0

	DECLARE @NumOfPermissions INT = 0

	DECLARE @ObjectCounter INT, @MaxObjectID INT, @ObjectName NVARCHAR(30)
	SELECT @ObjectCounter = min(id), @MaxObjectID = max(id) FROM dbo.permission_objects

	WHILE (@ObjectCounter IS NOT NULL AND @ObjectCounter <= @MaxObjectID)
	BEGIN
		SELECT @ObjectName = object FROM dbo.permission_objects WHERE id = @ObjectCounter

		DECLARE @ActionCounter INT, @MaxActionID INT, @ActionName NVARCHAR(10)
		SELECT @ActionCounter = min(id), @MaxActionID = max(id) FROM dbo.permission_actions

		WHILE(@ActionCounter IS NOT NULL AND @ActionCounter <= @MaxActionID)
		BEGIN
			SELECT @ActionName = action FROM dbo.permission_actions WHERE id = @ActionCounter

			

			IF NOT EXISTS (SELECT permissions.id FROM permissions
							INNER JOIN dbo.permission_actions ON dbo.permissions.action_id = dbo.permission_actions.id
							INNER JOIN dbo.permission_objects ON dbo.permissions.object_id = dbo.permission_objects.id
							WHERE dbo.permission_actions.action = @ActionName 
							AND dbo.permission_objects.object = @ObjectName)
			BEGIN
				BEGIN TRY
					INSERT INTO dbo.permissions (action_id, object_id) VALUES(@ActionCounter,@ObjectCounter)
					--PRINT CONCAT('Permission: ', @ActionName, '-', @ObjectName, ' created')
				END TRY
				BEGIN CATCH
					SET @error = 1
					SET @create_all_permissions_response = ERROR_MESSAGE()
					BREAK
				END CATCH
			END

			SET @ActionCounter = @ActionCounter + 1

			SET @NumOfPermissions = @NumOfPermissions + 1
		END

		IF (@error = 1)
			BREAK

		SET @ObjectCounter = @ObjectCounter + 1
	END

	-- in case no error has occurred and @create_all_permissions_response hasn't been filled out with another statement, the run was successful
	IF (@error = 0 AND @create_all_permissions_response IS NULL)
		SET @create_all_permissions_response = 'SUCCESS'

	SET @response = @create_all_permissions_response
	--SELECT @response as response

	--PRINT CONCAT('Number of permissions available: ', @NumOfPermissions)
END

