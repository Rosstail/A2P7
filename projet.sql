/*
    EXERCICE 1
*/
CREATE DATABASE IF NOT EXISTS bdd_ca_design CHARACTER set 'utf8mb4_unicode_ci';

/*
	EXERCICE 2
*/
CREATE USER 'anthony'@'localhost' IDENTIFIED BY 'Atelier2';
CREATE USER 'etienne'@'localhost' IDENTIFIED BY 'Atelier2';
GRANT ALL PRIVILEGES ON * . * TO 'anthony'@'localhost';
GRANT ALL PRIVILEGES ON * . * TO 'etienne'@'localhost';
FLUSH PRIVILEGES;