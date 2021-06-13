USE warehouse_management;

-- CREATE PERSONNEL TABLE
CREATE TABLE `personnel` (
  `id` varchar(36) NOT NULL,
  `username` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_id` (`id`),
  UNIQUE KEY `uidx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

-- CREATE PERMISSIONS TABLE
CREATE TABLE `permissions` (
  `id` varchar(20) NOT NULL,
  `action` varchar(6) NOT NULL,
  `object` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE PERSONNEL_PERMISSIONS TABLE
CREATE TABLE `personnel_permissions` (
  `id` varchar(36) NOT NULL,
  `personnel_id` varchar(36) NOT NULL,
  `permissions_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_id` (`id`),
  UNIQUE KEY `uidx_personnel_id_permissions_id` (`personnel_id`,`permissions_id`),
  KEY `personnel_id` (`personnel_id`),
  KEY `permissions_id` (`permissions_id`),
  CONSTRAINT `personnel_permissions_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE,
  CONSTRAINT `personnel_permissions_ibfk_2` FOREIGN KEY (`permissions_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Create trigger to do GUID for personnel_permissions table
DELIMITER $$
CREATE 
	TRIGGER create_guid_personnel_permissions BEFORE INSERT
    ON personnel_permissions
    FOR EACH ROW
    BEGIN
		IF new.id IS NULL THEN
			SET new.id = uuid();
		END IF;
	END$$
DELIMITER ;

-- CREATE ROW TABLE
CREATE TABLE `row` (
  `id` varchar(1) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE COLUMN TABLE
CREATE TABLE `column` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE LEVEL TABLE
CREATE TABLE `level` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE TYPE TABLE
CREATE TABLE `type` (
  `name` varchar(10) NOT NULL,
  `unit` varchar(10) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `uidx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE type;

-- CREATE PALETTE TABLE
CREATE TABLE `palette` (
  `id` varchar(10) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `manufacturing_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `order_num` varchar(50) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `type_name` varchar(10) DEFAULT NULL,
  `unit_mass` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `total_mass` int DEFAULT NULL,
  `last_updated` timestamp NOT NULL,
  `personnel_id` varchar(36) DEFAULT NULL,
  `is_empty` boolean NOT NULL DEFAULT true,
  `being_delivered` boolean NOT NULL DEFAULT false,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_being_delivered` (`being_delivered`),
  UNIQUE KEY `uidx_last_updated` (`last_updated`),
  UNIQUE KEY `uidx_product_name` (`product_name`),
  UNIQUE KEY `uidx_manufacturing_date` (`manufacturing_date`),
  UNIQUE KEY `uidx_expiration_date` (`expiration_date`),
  UNIQUE KEY `uidx_order_num` (`order_num`),
  UNIQUE KEY `uidx_order_date` (`order_date`),
  UNIQUE KEY `uidx_delivery_date` (`delivery_date`),
  UNIQUE KEY `uidx_is_empty` (`is_empty`),
  UNIQUE KEY `uidx_personnel_id` (`personnel_id`),
  CONSTRAINT `palette_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- CREATE LOCATION TABLE
CREATE TABLE `location` (
  `row_id` varchar(1) NOT NULL,
  `column_id` int NOT NULL,
  `level_id` int NOT NULL,
  `is_empty` boolean NOT NULL DEFAULT true,
  `palette_id` varchar(10) DEFAULT NULL,
  `last_updated` timestamp NOT NULL,
  `personnel_id` varchar(36) NOT NULL,
  PRIMARY KEY (`row_id`,`column_id`,`level_id`),
  UNIQUE KEY `uidx_is_empty` (`is_empty`),
  UNIQUE KEY `uidx_personnel_id` (`personnel_id`),
  KEY `column_id` (`column_id`),
  KEY `level_id` (`level_id`),
  KEY `palette_id` (`palette_id`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`row_id`) REFERENCES `row` (`id`),
  CONSTRAINT `location_ibfk_2` FOREIGN KEY (`column_id`) REFERENCES `column` (`id`),
  CONSTRAINT `location_ibfk_3` FOREIGN KEY (`level_id`) REFERENCES `level` (`id`),
  CONSTRAINT `location_ibfk_4` FOREIGN KEY (`palette_id`) REFERENCES `palette` (`id`),
  CONSTRAINT `location_ibfk_5` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
