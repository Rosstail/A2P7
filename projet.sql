/*
    EXERCICE 1
*/
CREATE DATABASE IF NOT EXISTS bdd_ca_design CHARACTER set 'utf8';

/*
	EXERCICE 2
*/
CREATE USER 'anthony'@'localhost' IDENTIFIED BY 'Atelier2';
CREATE USER 'etienne'@'localhost' IDENTIFIED BY 'Atelier2';
GRANT ALL PRIVILEGES ON * . * TO 'anthony'@'localhost';
GRANT ALL PRIVILEGES ON * . * TO 'etienne'@'localhost';
FLUSH PRIVILEGES;

/*
	EXERCICE 3
*/
CREATE TABLE IF NOT EXISTS users (
    user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(20) NOT NULL,
    user_firstname VARCHAR(20) NOT NULL,
    user_mail VARCHAR(50) NOT NULL UNIQUE,
    user_password VARCHAR(80) NOT NULL UNIQUE,
    user_role VARCHAR(10) NOT NULL,
    user_signdatetime DATETIME NOT NULL,
	PRIMARY KEY (user_id)
    );

CREATE TABLE IF NOT EXISTS projects (
    project_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    project_customer_id INT UNSIGNED NOT NULL,
    project_architect_id INT UNSIGNED NOT NULL,
    project_start_datetime DATETIME NOT NULL,
    project_delivery_datetime DATETIME NOT NULL,
    project_quotation INT NOT NULL,
    project_commentary TEXT,
	PRIMARY KEY (project_id)
    );

CREATE TABLE IF NOT EXISTS steps (
	step_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    step_project_id INT NOT NULL,
    step_architect_id INT UNSIGNED NOT NULL,
    step_name VARCHAR(20) NOT NULL,
    step_commentary TEXT,
    step_start_datetime DATETIME NOT NULL,
    step_done_datetime DATETIME NOT NULL,
	PRIMARY KEY (step_id)
    );

CREATE TABLE IF NOT EXISTS architect (
	architect_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    architect_project_id INT NOT NULL,
    architect_architect_id INT UNSIGNED NOT NULL,
    architect_assigned_datetime DATETIME NOT NULL,
	PRIMARY KEY (architect_id)
    );

CREATE TABLE IF NOT EXISTS used_material (
	used_material_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    used_material_project_id INT NOT NULL,
    used_material_name VARCHAR(20) NOT NULL,
    used_material_surface_price INT NOT NULL,
	PRIMARY KEY (used_material_id)
    );

CREATE TABLE IF NOT EXISTS materials (
	material_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    material_project_id INT NOT NULL,
    material_needed_surface INT NOT NULL,
	PRIMARY KEY (material_id)
    );

CREATE TABLE IF NOT EXISTS messages (
    message_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    message_project_id INT NOT NULL,
    message_architect_id INT NOT NULL,
    message_customer_id INT NOT NULL,
    message_content TEXT NOT NULL,
    message_sent_datetime DATETIME NOT NULL,
	PRIMARY KEY (message_id)
    )