USE warehouse_management

--SELECT * FROM dbo.permission_objects

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='columns')
	INSERT INTO dbo.permission_objects(object) VALUES('columns')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='levels')
	INSERT INTO dbo.permission_objects(object) VALUES('levels')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='locations')
	INSERT INTO dbo.permission_objects(object) VALUES('locations')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='palettes')
	INSERT INTO dbo.permission_objects(object) VALUES('palettes')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='permissions')
	INSERT INTO dbo.permission_objects(object) VALUES('permissions')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='permission_actions')
	INSERT INTO dbo.permission_objects(object) VALUES('permission_actions')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='permission_objects')
	INSERT INTO dbo.permission_objects(object) VALUES('permission_objects')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='personnel')
	INSERT INTO dbo.permission_objects(object) VALUES('personnel')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='personnel_permissions')
	INSERT INTO dbo.permission_objects(object) VALUES('personnel_permissions')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='rows')
	INSERT INTO dbo.permission_objects(object) VALUES('rows')

IF NOT EXISTS(SELECT id FROM dbo.permission_objects WHERE object='types')
	INSERT INTO dbo.permission_objects(object) VALUES('types')

SELECT * FROM dbo.permission_objects