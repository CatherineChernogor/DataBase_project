
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
INSERT INTO `Book` (`ISBN`, `code`, `name`, `storage_id`) VALUES ('Book_ISBN', 1111, 'Book_name', 1);
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
SELECT `o`.`id`, `o`.`taking_date`, `o`.`book_id`, `o`.`reader_id`, `o`.`expiration_date`, `o`.`status` FROM `Order` as `o`, `Reader` as `r`  WHERE `r`.`code`= 1222 and `r`.id = `o`.`reader_id`;
/* INSERT */
INSERT INTO `Order` (`taking_date`, `book_id`, `reader_id`, `expiration_date`, `status`) VALUES (CURDATE(), 11, 3, CURDATE() + INTERVAL 14 DAY , 0);
/* UPDATE */
UPDATE `Order` SET `expiration_date` = (`expiration_date` + INTERVAL 14 DAY) WHERE `id` = 1 LIMIT 1; --prolong expiration_time
UPDATE `Order` SET `status` = 1 WHERE `id` = 1 LIMIT 1; --return book
