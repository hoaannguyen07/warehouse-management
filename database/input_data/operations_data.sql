USE warehouse_management

DELETE FROM dbo.operations

INSERT INTO dbo.operations (action) VALUES ('create')
INSERT INTO dbo.operations (action) VALUES ('read')
INSERT INTO dbo.operations (action) VALUES ('update')
INSERT INTO dbo.operations (action) VALUES ('delete')

SELECT * FROM dbo.operations