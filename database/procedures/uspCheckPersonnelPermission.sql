USE [warehouse_management]
GO

-- Checking if a [username] can perform an [action] on an [object/table]
--EXEC [dbo].[uspCheckPersonnelPermission]
--	@username NVARCHAR(50), -- username of personnel the permission is linked to
--	@action NVARCHAR(10), -- action the permission is supposed to perform (create/read/update/delete)
--	@object NVARCHAR(30), -- name of table that the action is supposed to have power over
--	@response NVARCHAR(3)='' OUTPUT

-- OUTPUT(S) (by precedence) (SUCCESS WILL ALWAYS BE '0' BUT BE LOWEST ON THE PRECEDENCE LIST):
--		1. 'NO' -> @username DOES NOT have the [@action-@object] permission
--		0. 'YES' -> @username DOES have the [@action-@object] permission

CREATE OR ALTER PROCEDURE [dbo].[uspCheckPersonnelPermission]
	@username NVARCHAR(50), 
	@action NVARCHAR(10), 
	@object NVARCHAR(30),
	@response NVARCHAR(3)='' OUTPUT
AS
BEGIN
	-- create response based on if an entry that relates @user to [@action-@object] exists in the table
	IF EXISTS(SELECT dbo.personnel_permissions.id
				FROM dbo.personnel_permissions
				INNER JOIN dbo.personnel
				ON dbo.personnel_permissions.personnel_id = dbo.personnel.id
				INNER JOIN dbo.permissions
				ON dbo.personnel_permissions.permissions_id = dbo.permissions.id
				INNER JOIN dbo.permission_actions
				ON dbo.permissions.action_id = dbo.permission_actions.id
				INNER JOIn dbo.permission_objects
				ON dbo.permissions.object_id = dbo.permission_objects.id
				WHERE dbo.personnel.username = @username 
				AND dbo.permission_actions.action = @action 
				AND dbo.permission_objects.object = @object)
	BEGIN
		SET @response = 'YES'
		RETURN (0)
	END
	

	SET @response = 'NO'
	RETURN (1)
END
GO


