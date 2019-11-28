/*
    EXERCICE 1
*/
DROP DATABASE IF EXISTS bdd_ca_design;
CREATE DATABASE IF NOT EXISTS bdd_ca_design CHARACTER set utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bdd_ca_design;

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
    )
    ENGINE INNODB;

CREATE TABLE IF NOT EXISTS projects (
    project_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    project_name VARCHAR(20) NOT NULL,
    project_customer_id INT UNSIGNED NOT NULL,
    project_architect_id INT UNSIGNED NOT NULL,
    project_start_datetime DATETIME NOT NULL,
    project_delivery_datetime DATETIME NOT NULL,
    project_quotation INT NOT NULL,
    project_commentary TEXT,
    PRIMARY KEY (project_id),
    CONSTRAINT fk_projects_project_customer_id FOREIGN KEY (project_customer_id) REFERENCES users(user_id),
    CONSTRAINT fk_projects_project_architect_id FOREIGN KEY (project_architect_id) REFERENCES users(user_id)
    )
    ENGINE INNODB;

CREATE TABLE IF NOT EXISTS steps (
    step_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    step_project_id INT UNSIGNED NOT NULL,
    step_architect_id INT UNSIGNED NOT NULL,
    step_name VARCHAR(20) NOT NULL,
    step_commentary TEXT,
    step_start_datetime DATETIME NOT NULL,
    step_done_datetime DATETIME NOT NULL,
	  PRIMARY KEY (step_id),
    CONSTRAINT fk_steps_step_project_id FOREIGN KEY (step_project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_steps_step_architect_id FOREIGN KEY (step_architect_id) REFERENCES users(user_id)
    )
    ENGINE INNODB;

CREATE TABLE IF NOT EXISTS architects (
  	architect_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    architect_project_id INT UNSIGNED NOT NULL,
    architect_assigned_datetime DATETIME NOT NULL,
    PRIMARY KEY (architect_id),
    CONSTRAINT fk_architects_architect_id FOREIGN KEY (architect_project_id) REFERENCES users(user_id),
    CONSTRAINT fk_architects_architect_project_id FOREIGN KEY (architect_project_id) REFERENCES projects(project_id)
    )
    ENGINE INNODB;

CREATE TABLE IF NOT EXISTS used_materials (
  	used_material_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    used_material_name VARCHAR(20) NOT NULL,
    used_material_surface_price INT NOT NULL,
	PRIMARY KEY (used_material_id)
    )
    ENGINE INNODB;

CREATE TABLE IF NOT EXISTS materials (
  	material_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  	material_material_id INT UNSIGNED NOT NULL,
    material_project_id INT UNSIGNED NOT NULL,
    material_needed_surface INT NOT NULL,
	  PRIMARY KEY (material_id),
    CONSTRAINT fk_materials_material_id FOREIGN KEY (material_material_id) REFERENCES used_materials(used_material_id),
    CONSTRAINT fk_materials_project_id FOREIGN KEY (material_project_id) REFERENCES projects(project_id)
    )
    ENGINE INNODB;

CREATE TABLE IF NOT EXISTS messages (
    message_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    message_project_id INT UNSIGNED NOT NULL,
    message_sender_id INT UNSIGNED NOT NULL,
    message_receiver_id INT UNSIGNED NOT NULL,
    message_content TEXT NOT NULL,
    message_sent_datetime DATETIME NOT NULL,
	  PRIMARY KEY (message_id),
    CONSTRAINT fk_messages_message_id FOREIGN KEY (message_project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_messages_message_sender_id FOREIGN KEY (message_sender_id) REFERENCES users(user_id),
    CONSTRAINT fk_messages_message_receiver_id FOREIGN KEY (message_receiver_id) REFERENCES users(user_id)
    )
    ENGINE INNODB;

/*
	EXERCICE 4
*/
INSERT INTO users (user_name, user_firstname, user_mail, user_password, user_role, user_signdatetime)
VALUES  ('Man', 'Iron', 'stark-industries@tony.stark', '4v3ng385', 'admin', '2019-11-18 11:50:00'),
		#ARCHITECTES
		('Bacon', 'Engineer', 'spysappedmysentry@pootis.as', 'P00T15', 'architect', '2019-11-18 12:00:00'),
		('Jenkis', 'Leroy', 'lerooooooooooy@jenkins.wow', 'r41D', 'architect', '2019-11-18 12:10:00'),
		('Pardo', 'Manny', 'theliamimutilator@hotline.us', 'gotTaGetaGRIp', 'architect', '2019-11-18 12:20:00'),
		('Numerobis', 'saucisse', 'asterixetobelix@panoramix.gaule', 'ilssontfouscesromains', 'architect', '2019-11-18 12:30:00'),
		('titi', 'grominet', 'sapristi@saucisse.wb', 'W4rn3r', 'architect', '2019-11-18 12:40:00'),
		('menethil', 'arthas', 'warcraft@troua.com', 'Bl1554rD', 'architect', '2019-11-18 12:50:00'),
        ('girl', 'inkling', 'woomy-ngyes@calamazones.cp', '5t4y-FR35h', 'architect', '2019-11-18 13:00:00'),
		('Trotro', 'l''âne', 'trotro-rigolol@fuck.com', 'SuuS', 'architect', '2019-11-18 13:10:00'),
		('Mac', 'Little', 'comeonkid@smash.com', 'G155J03', 'architect', '2019-11-18 13:20:00'),
		('Zeus', 'Mercure', 'zerotohero@gmail.com', '0to1', 'architect', '2019-11-18 13:30:00'),
		('Blyat', 'Cyka', 'rushbrushb@russia.ru', 'CYKA', 'architect', '2019-11-18 13:40:00'),
		('Tenshirok', 'Le Hacker', 'theodorevatecoucher@olidry.fr', 'sgdyudgaydugzds', 'architect', '2019-11-18 13:50:00'),
		('Le Nain', 'Calbut', 'fier-de-hache@comptedunain.nain', 'touchepaamonor', 'architect', '2019-11-18 14:00:00'),
		('simpson', 'homer', 'the-simpsoooooooooonz@tadala.com', 'd0nUt', 'architect', '2019-11-18 14:10:00'),
		('Splinter', 'Master', 'Cowabunga@tadala.com', 'trowkdozd', 'architect', '2019-11-18 14:20:00'),
		#CLIENTS
		('Haddock', 'Archibald', 'capitaine_haddock@bachi-bouzouk.be', 'Wh15Ky', 'customer', '2019-11-18 14:30:00'),
		('Cage', 'Johnny', 'johnny_cage@famous.cage', '50nYa', 'customer', '2019-11-18 14:40:00'),
		('Pas lui', 'Moi', 'moietctout@genius.fr', '0n1y_Me', 'customer', '2019-11-18 14:50:00');

/*
	EXERCICE 5
*/
INSERT INTO projects (project_customer_id, project_architect_id, project_name, project_start_datetime, project_delivery_datetime, project_quotation, project_commentary)
VALUES  (17, 2, "Maison du Pauvre", "2019-11-19 08:00", "2019-12-01 13:00", 70000, "Délai à ne pas dépasser"),
		(18, 8, "Maison du pas riche", "2019-11-20 10:30", "2019-12-03 08:00", 100000, NULL),
		(19, 12, "Maison du bien payé", "2019-11-21 16:00", "2020-12-06 11:00", 125000, "Le client roucoule fort"),
    (17, 4, "Maison de Kollector", "2019-11-22 12:00", "2019-12-08 09:00", 62500, "Client très content");

/*
	EXERCICE 6
*/
INSERT INTO steps (step_project_id, step_architect_id, step_name, step_commentary, step_start_datetime, step_done_datetime)
 VALUES    (1, 2, "Observations", "Début du projet", "2019-11-20 08:00", "2019-11-20 17:00"),
 (1, 2, "Estimations", NULL, "2019-11-21 08:00", "2019-11-21 17:00"),
 (1, 3, "Croquis simples", NULL, "2019-11-22 08:00", "2019-11-22 17:00"),
 (1, 2, "Proposition croquis", NULL, "2019-11-23 08:00", "2019-11-23 17:00"),
 (1, 5, "Calculs contraintes", NULL, "2019-11-24 08:00", "2019-11-24 17:00"),
 (1, 2, "Soumission croquis ", NULL, "2019-11-25 08:00", "2019-11-25 17:00"),
 (1, 7, "Simulations", NULL, "2019-11-26 08:00", "2019-11-26 17:00"),
 (1, 2, "Corrections", NULL, "2019-11-27 08:00", "2019-11-27 17:00"),
 (1, 2, "Validation", NULL, "2019-11-28 08:00", "2019-11-28 17:00"),
 (1, 2, "Confirmation", "Fin de projet", "2019-11-29 08:00", "2019-11-29 17:00"),
 #2EME PROJET
 (2, 4, "Observations", "Début du projet", "2019-11-20 11:00", "2019-11-20 17:00"),
 (2, 12, "Estimations", NULL, "2019-11-21 08:00", "2019-11-21 17:00"),
 (2, 11, "Croquis simples", NULL, "2019-11-22 08:00", "2019-11-22 17:00"),
 (2, 8, "Proposition croquis", NULL, "2019-11-23 08:00", "2019-11-23 17:00"),
 (2, 3, "Calculs contraintes", NULL, "2019-11-24 08:00", "2019-11-24 17:00"),
 (2, 11, "Soumission croquis ", NULL, "2019-11-25 08:00", "2019-11-25 17:00"),
 (2, 4, "Simulations", NULL, "2019-11-26 08:00", "2019-11-26 17:00"),
 (2, 8, "Corrections", NULL, "2019-11-27 08:00", "2019-11-27 17:00"),
 (2, 3, "Validation", NULL, "2019-11-28 08:00", "2019-11-28 17:00"),
 (2, 4, "Confirmation", "Fin de projet", "2019-11-29 08:00", "2019-11-29 17:00"),
 #3EME PROJET
 (3, 12, "Observations", "Début du projet", "2019-11-22 08:00", "2019-11-22 17:00"),
 (3, 7, "Estimations", NULL, "2019-11-23 08:00", "2019-11-23 17:00"),
 (3, 9, "Croquis simples", NULL, "2019-11-24 08:00", "2019-11-24 17:00"),
 (3, 9, "Proposition croquis", NULL, "2019-11-25 08:00", "2019-11-25 17:00"),
 (3, 6, "Calculs contraintes", NULL, "2019-11-26 08:00", "2019-11-26 17:00"),
 (3, 7, "Soumission croquis ", NULL, "2019-11-27 08:00", "2019-11-27 17:00"),
 (3, 12, "Simulations", NULL, "2019-11-28 08:00", "2019-11-28 17:00"),
 (3, 9, "Corrections", NULL, "2019-11-29 08:00", "2019-11-29 17:00"),
 (3, 7, "Validation", NULL, "2019-11-30 08:00", "2019-12-03 17:00"),
 (3, 7, "Confirmation", "Fin de projet", "2019-12-04 08:00", "2019-12-06 17:00"),
 #4EME PROJET
 (4, 9, "Observations", "Début du projet", "2019-11-22 12:00", "2019-11-22 17:00"),
 (4, 11, "Estimations", NULL, "2019-11-23 08:00", "2019-11-23 17:00"),
 (4, 10, "Croquis simples", NULL, "2019-11-24 08:00", "2019-11-24 17:00"),
 (4, 16, "Proposition croquis", NULL, "2019-11-25 08:00", "2019-11-25 17:00"),
 (4, 16, "Calculs contraintes", NULL, "2019-11-26 08:00", "2019-11-26 17:00"),
 (4, 10, "Soumission croquis ", NULL, "2019-11-27 08:00", "2019-11-27 17:00"),
 (4, 11, "Simulations", NULL, "2019-11-28 08:00", "2019-11-28 17:00"),
 (4, 9, "Corrections", NULL, "2019-11-29 08:00", "2019-11-29 17:00"),
 (4, 11, "Validation", NULL, "2019-11-30 08:00", "2019-11-30 17:00"),
 (4, 9, "Confirmation", "Fin de projet", "2019-12-01 08:00", "2019-12-08 09:00");

/*
	EXERCICE 7
*/
INSERT INTO architects (architect_id, architect_project_id, architect_assigned_datetime)
VALUES  (2, 1, "2019-11-20 08:00:00"),
        (8, 2, "2019-11-21 10:30:00"),
        (12, 3, "2019-11-22 16:00:00"),
        (4, 4, "2019-11-23 12:00:00");

/*
	EXERCICE 8
*/
INSERT INTO used_materials (used_material_name, used_material_surface_price)
VALUES  ("Carrelage", 10),
        ("Parquet", 16),
        ("Laine de verre", 45),
        ("Argile", 16),
        ("Marbre", 7),
        ("Acier", 30),
        ("Verre", 20),
        ("Plastique", 15),
        ("Isolants", 20),
        ("Faience", 15),
        ("Béton", 13),
        ("Fontes", 40),
        ("Céramiques", 18),
        ("Cuir", 90),
        ("Mousse", 40),
        ("Contreplaqués", 32),
        ("Plexiglas", 3),
        ("Parpaings", 9),
        ("Goudron", 22),
        ("Tuile", 24);

/*
	EXERCICE 9
*/
INSERT INTO materials (material_material_id, material_project_id, material_needed_surface)
VALUES (8, 1, 13),
       (1, 1, 17),
       (2, 1, 22),
       (4, 1, 11),
       (6, 1, 10),
       (9, 1, 19),
       (12, 1, 22),
       (3, 2, 13),
       (5, 2, 30),
       (11, 2, 50),
       (13, 2, 10),
       (14, 2, 5),
       (17, 2, 3),
       (16, 2, 19),
       (18, 3, 5),
       (10, 3, 22),
       (19, 3, 55),
       (20, 3, 33),
       (8, 3, 20),
       (7, 3, 14),
       (1, 3, 11),
       (2, 4, 20),
       (15, 4, 93),
       (3, 4, 30),
       (19, 4, 12),
       (5, 4, 17),
       (18, 4, 27),
       (11, 4, 47);

/*
	EXERCICE 10
*/
INSERT INTO messages (message_project_id, message_sender_id, message_receiver_id, message_content, message_sent_datetime)
VALUES 
  #GROUPE PROJET 1 (2 3 5 7)
  ("1", "2", "3", "Projet 1 GRP 1", "2019-11-20 12:00"),
  ("1", "3", "2", "Projet 1 GRP 2", "2019-11-21 12:00"),
  ("1", "5", "7", "Projet 1 GRP 3", "2019-11-21 15:00"),
  ("1", "2", "5", "Projet 1 GRP 4", "2019-11-22 12:00"),
  ("1", "7", "2", "Projet 1 GRP 5", "2019-11-23 12:00"),
  ("1", "7", "2", "Projet 1 GRP 6", "2019-11-24 12:00"),
  ("1", "3", "2", "Projet 1 GRP 7", "2019-11-25 12:00"),
  ("1", "5", "2", "Projet 1 GRP 8", "2019-11-26 12:00"),
  #PROJET 1 (2 ET 17)
  ("1", "17", "2", "Projet 1 PV 1", "2019-11-21 12:00"),
  ("1", "2", "17", "Projet 1 PV 2", "2019-11-23 12:00"),
  ("1", "17", "2", "Projet 1 PV 3", "2019-11-25 12:00"),
  ("1", "2", "17", "Projet 1 PV 4", "2019-11-26 12:00"),
  #GROUPE PROJET 2 (3 4 8 11 12)
  ("2", "4", "11", "Projet 2 GRP 1", "2019-11-21 12:00"),
  ("2", "3", "4", "Projet 2 GRP 2", "2019-11-21 12:00"),
  ("2", "8", "12", "Projet 2 GRP 3", "2019-11-21 12:00"),
  ("2", "11", "3", "Projet 2 GRP 4", "2019-11-23 12:00"),
  ("2", "12", "11", "Projet 2 GRP 5", "2019-11-24 12:00"),
  ("2", "12", "8", "Projet 2 GRP 6", "2019-11-24 12:00"),
  ("2", "8", "3", "Projet 2 GRP 7", "2019-11-25 12:00"),
  ("2", "3", "8", "Projet 2 GRP 8", "2019-11-26 12:00"),
  ("2", "3", "4", "Projet 2 GRP 9", "2019-11-26 12:00"),
  ("2", "11", "12", "Projet 2 GRP 10", "2019-11-28 12:00"),
  #PROJET 2 (8 ET 18)
  ("2", "18", "8", "Projet 2 PV 1", "2019-11-21 12:00"),
  ("2", "8", "18", "Projet 2 PV 2", "2019-11-24 12:00"),
  ("2", "18", "8", "Projet 2 PV 3", "2019-11-26 12:00"),
  ("2", "8", "18", "Projet 2 PV 4", "2019-11-28 12:00"),
  #GROUPE PROJET 3 ( 6 7 9 12 15)
  ("3", "7", "15", "Projet 3 GRP 1", "2019-11-22 12:00"),
  ("3", "6", "12", "Projet 3 GRP 2", "2019-11-23 12:00"),
  ("3", "9", "7", "Projet 3 GRP 3", "2019-11-23 12:00"),
  ("3", "12", "9", "Projet 3 GRP 4", "2019-11-24 12:00"),
  ("3", "7", "12", "Projet 3 GRP 5", "2019-11-25 12:00"),
  ("3", "9", "12", "Projet 3 GRP 6", "2019-11-25 12:00"),
  ("3", "6", "15", "Projet 3 GRP 7", "2019-11-26 12:00"),
  ("3", "9", "7", "Projet 3 GRP 8", "2019-11-27 12:00"),
  ("3", "7", "15", "Projet 3 GRP 9", "2019-11-29 12:00"),
  ("3", "12", "7", "Projet 3 GRP 10", "2019-11-30 12:00"),
  ("3", "6", "9", "Projet 3 GRP 11", "2019-12-01 12:00"),
  ("3", "9", "6", "Projet 3 GRP 12", "2019-12-04 12:00"),
  #PROJET 3 (12 et 19)
  ("3", "19", "12", "Projet 3 PV 1", "2019-11-22 12:00"),
  ("3", "12", "12", "Projet 3 PV 2", "2019-11-24 12:00"),
  ("3", "19", "12", "Projet 3 PV 3", "2019-11-27 12:00"),
  ("3", "12", "19", "Projet 3 PV 4", "2019-11-30 12:00"),
  ("3", "19", "12", "Projet 3 PV 5", "2019-12-01 12:00"),
  ("3", "12", "19", "Projet 3 PV 6", "2019-12-04 12:00"),
  #GROUPE PROJET 4 (4, 10, 11, 16)
  ("4", "4", "16", "Projet 4 GRP 1", "2019-11-23 12:00"),
  ("4", "10", "4", "Projet 4 GRP 2", "2019-11-24 12:00"),
  ("4", "10", "11", "Projet 4 GRP 3", "2019-11-26 12:00"),
  ("4", "16", "4", "Projet 4 GRP 4", "2019-11-27 12:00"),
  ("4", "16", "11", "Projet 4 GRP 5", "2019-11-28 12:00"),
  ("4", "16", "4", "Projet 4 GRP 6", "2019-11-28 12:00"),
  ("4", "11", "10", "Projet 4 GRP 7", "2019-11-29 12:00"),
  ("4", "11", "4", "Projet 4 GRP 8", "2019-11-29 12:00"),
  ("4", "4", "11", "Projet 4 GRP 9", "2019-11-29 12:00"),
  ("4", "4", "10", "Projet 4 GRP 10", "2019-11-30 12:00"),
  ("4", "11", "4", "Projet 4 GRP 11", "2019-11-30 12:00"),
  ("4", "4", "11", "Projet 4 GRP 12", "2019-12-02 12:00"),
  ("4", "16", "11", "Projet 4 GRP 13", "2019-12-02 12:00"),
  ("4", "4", "16", "Projet 4 GRP 14", "2019-12-03 12:00"),
  ("4", "4", "10", "Projet 4 GRP 15", "2019-12-04 12:00"),
  #PROJET 4 (4 et 17)
  ("4", "17", "4", "Projet 4 PV 1", "2019-11-23 12:00"),
  ("4", "4", "17", "Projet 4 PV 2", "2019-11-25 12:00"),
  ("4", "4", "17", "Projet 4 PV 3", "2019-11-27 12:00"),
  ("4", "17", "4", "Projet 4 PV 4", "2019-11-28 12:00"),
  ("4", "17", "4", "Projet 4 PV 5", "2019-11-29 12:00"),
  ("4", "4", "17", "Projet 4 PV 6", "2019-12-01 12:00"),
  ("4", "17", "4", "Projet 4 PV 7", "2019-12-03 12:00"),
  ("4", "4", "17", "Projet 4 PV 8", "2019-12-04 12:00")

/*
	EXERCICE 11
*/
SELECT project_name, project_start_datetime, project_quotation
FROM projects;

/*
	EXERCICE 12
*/
SELECT project_name, project_start_datetime, project_quotation
FROM projects
#si valeur de project_quotation égale valeur sélectionnée (ici min / max)
WHERE project_quotation = (SELECT MIN(project_quotation) FROM projects)
OR project_quotation = (SELECT MAX(project_quotation) FROM projects);

/*
	EXERCICE 13
*/
SELECT project_name, project_start_datetime, project_delivery_datetime, DATEDIFF(project_delivery_datetime, project_start_datetime) AS project_days, project_quotation
FROM projects
#si valeur de project_days égale valeur sélectionnée (ici min / max)
WHERE DATEDIFF(project_delivery_datetime, project_start_datetime) = (SELECT MIN(DATEDIFF(project_delivery_datetime, project_start_datetime)) FROM projects)
OR DATEDIFF(project_delivery_datetime, project_start_datetime) = (SELECT MAX(DATEDIFF(project_delivery_datetime, project_start_datetime)) FROM projects);

/*
	EXERCICE 14
*/
SELECT P.project_name, P.project_start_datetime, P.project_quotation, U.user_name, U.user_firstname, U.user_signdatetime
FROM projects as P, users as U
WHERE P.project_architect_id = U.user_id
AND P.project_architect_id = 8;

/*
	EXERCICE 15
*/
SELECT P.project_name, CONCAT(U.user_firstname, ' ', U.user_name) AS architect_name, SUM(UM.used_material_surface_price * M.material_needed_surface) AS total_price
FROM projects AS P, users AS U, materials as M, used_materials AS UM
WHERE P.project_id = M.material_project_id AND M.material_material_id = UM.used_material_id AND P.project_architect_id = U.user_id
AND P.project_id = 1;

/*
	EXERCICE 16
*/
SELECT P.project_name, P.project_start_datetime, P.project_quotation, CONCAT(U.user_firstname, ' ', U.user_name) AS nom_prenom, U.user_signdatetime
FROM projects AS P, users AS U
WHERE P.project_id = 1 AND U.user_id = P.project_architect_id;

/*
	EXERCICE 17
*/
SELECT DISTINCT projects.project_name, projects.project_start_datetime, projects.project_quotation, CONCAT(users.user_firstname, " ", users.user_name) as name_architects
FROM projects, users, steps
WHERE steps.step_architect_id = users.user_id AND steps.step_project_id = projects.project_id
AND projects.project_id = 1;

/*
	EXERCICE 18
*/
SELECT P.project_name, P.project_start_datetime, P.project_quotation, CONCAT(U.user_firstname, ' ', U.user_name) AS nom_prenom, U.user_signdatetime, S.step_name
FROM projects AS P, users AS U, steps AS S
WHERE P.project_id = 1 AND U.user_id = P.project_architect_id AND S.step_project_id = P.project_id;

/*
	EXERCICE 19
*/
SELECT P.project_name, DATEDIFF(P.project_delivery_datetime, P.project_start_datetime) AS project_estimated_days, DATEDIFF(MAX(S.step_done_datetime), MIN(S.step_start_datetime)) AS real_time
FROM projects AS P, steps as S
WHERE P.project_id = 1 AND S.step_project_id = P.project_id;

/*
	EXERCICE 20
*/
#TEST
SELECT P.project_name, P.project_start_datetime, P.project_quotation, S.step_done_datetime
FROM projects AS P, steps AS S
WHERE S.step_done_datetime > (SELECT MAX(P.project_delivery_datetime) FROM projects AS P)
AND S.step_project_id = P.project_id;

/*
	EXERCICE 21
*/
SELECT  P.project_name,
    CONCAT(U.user_firstname," ", U.user_name) AS name_expeditor,
        M.message_content,
        M.message_sent_datetime,
        (SELECT DATEDIFF (MAX(M.message_sent_datetime), MIN(M.message_sent_datetime)) / COUNT(M.message_sent_datetime) FROM messages as M WHERE M.message_project_id = 1) AS average_days_between_messages
FROM projects AS P, users AS U, messages AS M
WHERE P.project_id = 1 AND M.message_project_id = P.project_id AND (M.message_sender_id = U.user_id OR M.message_sender_id = U.user_id)
GROUP BY P.project_name, U.user_firstname, U.user_name, M.message_content, M.message_sent_datetime;

/*
  EXERCICE 22
*/
SELECT projects.project_name, CONCAT(users.user_firstname," ",
                                     users.user_name) AS name_expeditor,
                                     (SELECT users.user_name FROM users WHERE users.user_id = messages.message_receiver_id) AS name_receiver,
                                     (SELECT users.user_firstname FROM users WHERE users.user_id = messages.message_receiver_id) AS firstname_receiver,
                                     messages.message_content,
                                     messages.message_sent_datetime,
                                     (SELECT DATEDIFF( 
    (SELECT FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(messages.message_sent_datetime)))
     FROM projects, messages, users 
     WHERE projects.project_id = 1 AND messages.message_project_id = projects.project_id AND users.user_id = projects.project_architect_id 
     AND messages.message_sender_id = users.user_id AND messages.message_receiver_id = projects.project_customer_id),
    (SELECT FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(messages.message_sent_datetime)))
     FROM projects, messages, users 
     WHERE projects.project_id = 1 AND messages.message_project_id = projects.project_id AND users.user_id = projects.project_customer_id 
     AND messages.message_sender_id = users.user_id AND messages.message_receiver_id = projects.project_architect_id) )) AS avg_time_to_respond
FROM projects, users, messages
WHERE projects.project_id = 1 AND (users.user_id = projects.project_customer_id OR users.user_id = projects.project_architect_id) 
AND messages.message_sender_id = users.user_id AND messages.message_project_id = projects.project_id 
AND (messages.message_receiver_id = projects.project_customer_id OR messages.message_receiver_id = projects.project_architect_id)

/*
	EXERCICE 23
*/
SELECT DISTINCT projects.project_name, projects.project_start_datetime, projects.project_delivery_datetime, CONCAT(users.user_firstname, " ", users.user_name) AS referent_firstname_name,
(SELECT DISTINCT MAX(steps.step_done_datetime)
  FROM projects, steps
  WHERE projects.project_id = 2 AND steps.step_project_id = projects.project_id
) AS real_done_date,
(SELECT DISTINCT COUNT(messages.message_id)
  FROM projects, users, messages, architects 
  WHERE projects.project_id = 2 AND architects.architect_project_id = projects.project_id AND users.user_id = architects.architect_id AND messages.message_project_id = projects.project_id
) AS nb_messages,
(SELECT DISTINCT COUNT(steps.step_id)
  FROM projects, steps
  WHERE projects.project_id = 2 AND steps.step_project_id = projects.project_id
) AS nb_steps,
(SELECT COUNT(DISTINCT messages.message_id) / DATEDIFF(MAX(steps.step_done_datetime), MIN(projects.project_start_datetime))
  FROM projects, steps, messages
  WHERE projects.project_id = 2 AND steps.step_project_id = projects.project_id AND messages.message_project_id = projects.project_id
) AS nb_messages_per_day,
(SELECT DISTINCT DATEDIFF(MAX(steps.step_done_datetime), MIN(projects.project_start_datetime)) / COUNT(steps.step_id)
  FROM projects, steps
  WHERE projects.project_id = 2 AND steps.step_project_id = projects.project_id
) AS nb_days_per_steps
FROM projects, users, steps, messages, architects
WHERE projects.project_id = 2 AND steps.step_project_id = projects.project_id AND architects.architect_project_id = projects.project_id 
AND users.user_id = architects.architect_id AND messages.message_project_id = projects.project_id;

#   F I N #

