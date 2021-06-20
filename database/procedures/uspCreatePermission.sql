USE [warehouse_management]
GO

-- Procedure to insert a permission into the permission table


-- OUTPUT(S):
--		'Unauthorized to create personnel' -> Authorizing username does not have the permission to insert into permission
--		'Cannot insert duplicate key...' -> [@action-@object] combo already exists in the permission table, cannot have a duplicate
--		'SUCCESS' -> Successfully inserted [@action-@object] into the personnel table


CREATE OR ALTER PROCEDURE dbo.uspCreatePermission
	@action nvarchar(10), -- action that this permission will be used to perform
	@object nvarchar(30), -- object that this permission will affect
	@auth nvarchar(50), -- username of the person requesting this personnel creation
	@response nvarchar(256) = '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @create_permission_response nvarchar(256) = NULL

	-- check if @auth has the authority to create personnel
	DECLARE @check_permissions_response nvarchar(3)
	EXEC dbo.uspCheckPersonnelPermission
		@username = @auth,
		@action = 'create',
		@object = 'permission',
		@response = @check_permissions_response OUTPUT

	-- if auth is granted, then go ahead with creating new personnel
	IF (@check_permissions_response = 'YES')
	BEGIN
		BEGIN TRY
			INSERT INTO dbo.permissions (action, object) VALUES (@action, @object)

			-- make sure the new permission is in the permissions table
			IF EXISTS(SELECT dbo.permissions.id FROM dbo.permissions WHERE action=@action AND object=@object)
				SET @create_permission_response = 'SUCCESS'

		END TRY
		BEGIN CATCH
			SET @create_permission_response = ERROR_MESSAGE()
		END CATCH
	END
	ELSE
		SET @create_permission_response = 'Unauthorized to create permission'

	

	-- return response message
	SET @response = @create_permission_response
	--SELECT @@create_permission_response as reponse
END
