/* TABLES */

CREATE TABLE `Book` (
	`id`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ISBN` varchar(18) NOT NULL,
	`code` INT UNSIGNED NOT NULL, /*already build-in INTO the system code of book*/
	`name` varchar(255) NOT NULL,
	`storage_id` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`)
);

-- Storage status of the book ie reading room, book's shelfs, storage
CREATE TABLE `Storage` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Author` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`code` INT UNSIGNED NOT NULL, /*already build-in INTO the system code of author*/
	`lastname` varchar(30) NOT NULL,
	`firstname` varchar(30) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Genre` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`code` INT UNSIGNED NOT NULL, /*already build-in INTO the system code of genre*/
	`name` varchar(30) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Book_genre` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`book_id` INT UNSIGNED NOT NULL,
	`genre_id` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Book_author` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`book_id` INT UNSIGNED NOT NULL,
	`author_id` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Reader` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`code` INT UNSIGNED NOT NULL, /*already build-in INTO the system code of reader*/
	`lastname` varchar(30) NOT NULL,
	`firstname` varchar(30) NOT NULL,
	`phone` varchar(18),
	`adress` varchar(255),
	PRIMARY KEY (`id`)
);

CREATE TABLE `Order` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`taking_date` TIMESTAMP NULL DEFAULT NULL,
	`book_id` INT UNSIGNED NOT NULL,
	`reader_id` INT UNSIGNED NOT NULL,
	`expiration_date` TIMESTAMP NULL DEFAULT NULL,
	`updated_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`status` TINYINT(1) NOT NULL,-- 1 - the book wAS returned, 0 - not yet returned
	PRIMARY KEY (`id`)
);


/* CONSTRAINT */

ALTER TABLE `Book` ADD CONSTRAINT `Book_fk0` FOREIGN KEY (`storage_id`) REFERENCES `Storage`(`id`);

ALTER TABLE `Book_genre` ADD CONSTRAINT `Book_genre_fk0` FOREIGN KEY (`book_id`) REFERENCES `Book`(`id`) ON DELETE CASCADE ;

ALTER TABLE `Book_genre` ADD CONSTRAINT `Book_genre_fk1` FOREIGN KEY (`genre_id`) REFERENCES `Genre`(`id`) ON DELETE CASCADE ;

ALTER TABLE `Book_author` ADD CONSTRAINT `Book_author_fk0` FOREIGN KEY (`book_id`) REFERENCES `Book`(`id`) ON DELETE CASCADE ;

ALTER TABLE `Book_author` ADD CONSTRAINT `Book_author_fk1` FOREIGN KEY (`author_id`) REFERENCES `Author`(`id`) ON DELETE CASCADE ;

ALTER TABLE `Order` ADD CONSTRAINT `Order_fk0` FOREIGN KEY (`book_id`) REFERENCES `Book`(`id`) ON DELETE CASCADE;

ALTER TABLE `Order` ADD CONSTRAINT `Order_fk1` FOREIGN KEY (`reader_id`) REFERENCES `Reader`(`id`) ON DELETE CASCADE;


/* DATA */

INSERT INTO `Storage` (`name`) VALUES
('Хранилище'),
('Читальный зал'),
('Выставочный зал');

INSERT INTO `Book` ( `ISBN`, `code`, `name`, `storage_id`) VALUES
('978-5-17-099842-5', 345432, 'На дне', 3),
('978-5-17-086689-2', 345467, 'Стена', 3),
('978-5-17-090790-5', 398067, 'Колыбельная', 1),
('978-5-9925-0159-9', 567867, 'La premiere enquete de maigret', 2),
('978-5-699-96119-5', 345433, 'Край обетованный', 3),
('978-5-17-112632-2', 349809, 'Мысли', 2),
('978-5-17-117348-7', 340998, 'Своя комната', 1),
('209-031824-4', 347875, 'L\'heure du crime', 2),
('978-5-17-107197-4', 357887, 'Голод', 1),
('978-5-17-098304-9', 876556, 'Иметь или не иметь', 1),
('978-5-17-097653-9', 367123, 'Старик и море', 1),
('978-5-17-080083-4', 367123, 'Чума', 1);

INSERT INTO `Author` ( `code`, `lastname`, `firstname`) VALUES
(2345, 'Хемингуэй', 'Эрнест'),
(2349, 'Камю', 'Альбер'),
(1454, 'Гамсун', 'Кнут'),
(7654, 'Renaud', 'Dominique'),
(1233, 'Вулф', 'Вирджиния'),
(3454, 'Паскаль', 'Блез'),
(5675, 'Мураками', 'Харуки'),
(9873, 'Simenon', 'Georges'),
(5432, 'Паланик', 'Чак'),
(5467, 'Жан Поль', 'Сартр'),
(5465, 'Горький', 'Максим');

INSERT INTO `Genre` (`code`, `name`) VALUES
(34, 'Драма'),
(37, 'Приключения'),
(33, 'Роман'),
(32, 'Новелла'),
(54, 'Фантастика'),
(13, 'Полицейский роман'),
(10, 'Публицистика'),
(55, 'Проза'),
(56, 'Философия');

INSERT INTO `Book_genre` (`book_id`, `genre_id`) VALUES
(11, 1),
(2, 4),
(3, 5),
(4, 6),
(5, 8),
(6, 9),
(7, 7),
(8, 6),
(9, 8),
(10, 8),
(11, 8),
(12, 8),
(12, 3);

INSERT INTO `Book_author` (`book_id`, `author_id`) VALUES
(1, 11),
(2, 10),
(3, 9),
(4, 8),
(5, 7),
(6, 6),
(7, 5),
(8, 4),
(9, 3),
(10, 1),
(11, 1),
(12, 2);

INSERT INTO `Reader` (`code`, `lastname`, `firstname`, `phone`, `adress`) VALUES
(1221, 'Обручев', 'Владимир', '+79041236558', 'ул. Байкальская, 234, 56'),
(1222, 'Крузенштерн', 'Иван', '+79042771461', 'ул. Сибирская, 53, 38'),
(1223, 'Лисин', 'Владимир', '+79040438991', 'ул. Трикотажный 9-й пер, 14, 366'),
(1224, 'Дерипаска', 'Олег', '+79049723531', 'ул. Магнитогорская, 35, 117'),
(1225, 'Вернадский', 'Владимир', '+79042867479', 'ул. Симферопольская, 64, 224'),
(1226, 'Лаптев', 'Дмитрий', '+79042231146', 'ул. Арбатский пер, 21, 246');

INSERT INTO `Order` (`taking_date`,`book_id`,`reader_id`,`expiration_date`,`status`) VALUES
('2020-06-01', 5, 4, '2020-06-15', 0),
('2020-06-01', 6, 4, '2020-06-15', 1),
('2020-06-01', 7, 4, '2020-06-15', 1),
('2020-06-04', 8, 3, '2020-06-18', 0),
('2020-06-05', 9, 3, '2020-06-18', 1),
('2020-06-06', 12, 1, '2020-06-20', 0),
('2020-06-07', 10, 2, '2020-06-21', 0),
('2020-06-09', 11, 5, '2020-06-23', 0),
('2020-06-08', 2, 6, '2020-06-22', 1),
('2020-05-10', 4, 1, '2020-05-24', 0),
('2020-05-09', 3, 4, '2020-05-23', 0),
('2020-05-08', 11, 3, '2020-05-22', 1),
('2020-05-08', 10, 3, '2020-05-22', 1),
('2020-04-06', 2, 4, '2020-04-20', 1);


/* VIEW */

CREATE VIEW `Not_returned_books` AS
SELECT o.taking_date, o.expiration_date, 
b.name AS book_name, concat_ws(' ',a.firstname, a.lastname) AS author_name, 
concat_ws(' ', r.firstname, r.lastname) AS reader_name
FROM `Order` AS o, `Book` AS b, `Reader` AS r, `Author` AS a, `Book_author` AS ba
WHERE o.status = 0 AND o.reader_id = r.id AND o.book_id = b.id AND a.id = ba.author_id AND ba.book_id = b.id
ORDER BY o.taking_date, o.expiration_date;

CREATE VIEW `Expired_books` AS
SELECT o.taking_date, o.expiration_date, 
b.name, concat_ws(' ',a.firstname, a.lastname) AS author_name, 
concat_ws(' ', r.firstname, r.lastname) AS reader_name, r.phone AS reader_phone, r.adress AS reader_adress
FROM `Order` AS o, `Book` AS b, `Reader` AS r, `Author` AS a, `Book_author` AS ba
WHERE  o.expiration_date < CURDATE() AND o.status = 0 
AND o.reader_id = r.id AND o.book_id = b.id AND a.id = ba.author_id AND ba.book_id = b.id
ORDER BY `o`.`expiration_date`;



/* EXAMPLES*/


/* Genre */
/* SEARCH */
SELECT `id`, `code`, `name` FROM `Genre` WHERE `name`= 'Genre_name';
/* INSERT */
INSERT INTO `Genre` (`code`, `name`) VALUES (1111, 'Genre_name');
/* UPDATE */
UPDATE `Genre` SET `name` = 'Genre_name' WHERE `id` = 1 LIMIT 1;
/* DELETE */
DELETE FROM `Genre` WHERE `id` = 1 limit 1;


/* AUTHOR */
/* SEARCH */
SELECT `id`, `code`, `lastname`, `firstname` FROM `Author` WHERE `lastname`= 'Author_lastname';
/* INSERT */
INSERT INTO `Author` (`code`, `firstname`, `lastname`) VALUES (1111, 'Author_firstname', 'Author_lastname');
/* UPDATE */
UPDATE `Author` SET `lastname` = 'Author_lastname' WHERE `id` = 1 LIMIT 1;
/* DELETE */
DELETE FROM `Author` WHERE `id` = 1 limit 1;


/* READER */
/* SEARCH */
SELECT `id`, `lastname`, `firstname` FROM `Reader` WHERE `lastname`= 'Reader_lastname';
/* INSERT */
INSERT INTO `Reader` (`firstname`, `lastname`, `phone`, `adress`) VALUES ('Reader_firstname', 'Reader_lastname', 'Reader_phone', 'Reader_adress');
/* UPDATE */
UPDATE `Reader` SET `lastname` = 'Reader_lastname' WHERE `id` = 1 LIMIT 1;
/* DELETE */
DELETE FROM `Reader` WHERE `id` = 1 limit 1;


/* BOOK */
/* SEARCH */
SELECT `id`, `ISBN`, `code`, `name`, `storage_id` FROM `Book` WHERE `name` = 'Book_name';
/* INSERT */
INSERT INTO `Book` (`ISBN`, `code`, `name`, `storage_id`) VALUES ('978-5-17-080083-4', 1111, 'Book_name', 1);
/* UPDATE */
UPDATE `Book` SET `name` = 'Book_name' WHERE `id` = 1 LIMIT 1;
/* DELETE */
DELETE FROM `Book` WHERE `id` = 1 limit 1;

/*While adding book, don't forget to set author and genre, 
but first of all you have to understarnd with what book you are working*/
SELECT `id`, `code`, `lastname`, `firstname` FROM `Author` WHERE `lastname`= 'Author_lastname'; --search for author_lastname
SELECT `id`, `ISBN`, `code`, `name`, `storage_id` FROM `Book` WHERE `name` = 'Book_name'; --search for book_name
INSERT INTO `Book_author` (`book_id`, `author_id`) VALUES (1, 1);

SELECT `id`, `code`, `name` FROM `Genre` WHERE `name`= 'Genre_name'; --search for genre_name
SELECT `id`, `ISBN`, `code`, `name`, `storage_id` FROM `Book` WHERE `name` = 'Book_name'; --search for book_name
INSERT INTO `Book_genre` (`book_id`, `genre_id`) VALUES (1, 1);


/* ORDER*/
/* SEARCH */
SELECT o.`id`, o.`taking_date`, o.`book_id`, o.`reader_id`, o.`expiration_date`, o.`status` FROM `Order` as o, `Reader` as r  WHERE r.`code`= 1222 and r.id = o.reader_id;
/* INSERT */
INSERT INTO `Order` (`taking_date`, `book_id`, `reader_id`, `expiration_date`, `status`) VALUES (CURDATE(), 11, 3, CURDATE() + INTERVAL 14 DAY , 0);
/* UPDATE */
UPDATE `Order` SET `expiration_date` = (`expiration_date` + INTERVAL 14 DAY) WHERE `id` = 1 LIMIT 1; --prolong expiration_time
UPDATE `Order` SET `status` = 1 WHERE `id` = 1 LIMIT 1; --return book



/* DELETE EVERYTHING */
/*
drop view `Expired_books`;
drop view `Not_returned_books`;
drop table `Order`;
drop table `Reader`;
drop table `Book_author`;
drop table `Book_genre`;
drop table `Author`;
drop table `Book`;
drop table `Genre`;
drop table `Storage`;
*/

/* SELECT */
/*
select * from `Book` order by id desc limit 100;
select * from `Author` order by id desc limit 100;
select * from `Reader` order by id desc limit 100;
select * from `Genre` order by id desc limit 100;
select * from `Order` order by id desc limit 100;
*/