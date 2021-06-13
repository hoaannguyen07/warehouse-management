USE warehouse_management;

-- personnel table
INSERT INTO personnel(username, password, full_name) VALUES('test', 'test123', 'hello mate');

SELECT * FROM personnel;

-- permissions table
INSERT INTO permissions VALUES('create-location', 'create', 'location');
INSERT INTO permissions VALUES('read-location', 'read', 'location');
INSERT INTO permissions VALUES('update-location', 'update', 'location');
INSERT INTO permissions VALUES('delete-location', 'delete', 'location');

SELECT * FROM permissions;

-- personnel_permissions table
INSERT INTO personnel_permissions(personnel_id, permissions_id) VALUES('a7e23282-cbce-11eb-84a3-2cf05db81bc3', 'create-location');
INSERT INTO personnel_permissions(personnel_id, permissions_id) VALUES('a7e23282-cbce-11eb-84a3-2cf05db81bc3', 'read-location');
INSERT INTO personnel_permissions(personnel_id, permissions_id) VALUES('a7e23282-cbce-11eb-84a3-2cf05db81bc3', 'update-location');
INSERT INTO personnel_permissions(personnel_id, permissions_id) VALUES('a7e23282-cbce-11eb-84a3-2cf05db81bc3', 'delete-location');

SELECT * FROM personnel_permissions;

SELECT personnel.username, personnel.password, personnel.full_name, permissions.action, permissions.object 
FROM personnel_permissions 
JOIN personnel 
ON personnel_permissions.personnel_id = personnel.id
JOIN permissions
ON personnel_permissions.permissions_id = permissions.id;