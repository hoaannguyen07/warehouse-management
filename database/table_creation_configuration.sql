USE warehouse_management;

-- CREATE PERSONNEL TABLE
CREATE TABLE personnel (
	id VARCHAR(36),
    username VARCHAR(256) NOT NULL,
    password VARCHAR(256) NOT NULL,
    full_name VARCHAR(100),
    PRIMARY KEY(id)
);

CREATE UNIQUE INDEX uidx_id ON personnel(id);
CREATE UNIQUE INDEX uidx_username ON personnel(username);

-- Create trigger to do GUID for personnel table
DELIMITER $$
CREATE 
	TRIGGER create_guid_personnel BEFORE INSERT
    ON personnel
    FOR EACH ROW
    BEGIN
		IF new.id IS NULL THEN
			SET new.id = uuid();
		END IF;
	END$$
DELIMITER ;
            
INSERT INTO personnel(username, password, full_name) VALUES('test', 'test123', 'hello mate');

SELECT * FROM personnel;