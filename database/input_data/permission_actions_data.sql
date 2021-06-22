USE warehouse_management

--SELECT * FROM dbo.permission_actions

IF NOT EXISTS(SELECT id FROM dbo.permission_actions WHERE action='create')
	INSERT INTO dbo.permission_actions(action) VALUES('create')

IF NOT EXISTS(SELECT id FROM dbo.permission_actions WHERE action='read')
	INSERT INTO dbo.permission_actions(action) VALUES('read')

IF NOT EXISTS(SELECT id FROM dbo.permission_actions WHERE action='update')
	INSERT INTO dbo.permission_actions(action) VALUES('update')

IF NOT EXISTS(SELECT id FROM dbo.permission_actions WHERE action='delete')
	INSERT INTO dbo.permission_actions(action) VALUES('delete')

SELECT * FROM dbo.permission_actions