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
select * from `Book` order by id desc limit 10;
select * from `Author` order by id desc limit 10;
select * from `Reader` order by id desc limit 10;
select * from `Genre` order by id desc limit 10;
select * from `Order` order by id desc limit 10;
*/