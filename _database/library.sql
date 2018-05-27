-- MySQL Script generated by MySQL Workbench
-- Sun May 27 11:43:37 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Drop tables
-- -----------------------------------------------------

DROP TABLE IF EXISTS `room_reservation` ;
DROP TABLE IF EXISTS `equipment_reservation` ;
DROP TABLE IF EXISTS `book_reservation` ;
DROP TABLE IF EXISTS `event_registry` ;
DROP TABLE IF EXISTS `event` ;
DROP TABLE IF EXISTS `room` ;
DROP TABLE IF EXISTS `floor` ;
DROP TABLE IF EXISTS `equipment` ;
DROP TABLE IF EXISTS `book` ;
DROP TABLE IF EXISTS `editorial` ;
DROP TABLE IF EXISTS `author` ;
DROP TABLE IF EXISTS `reservation_detail` ;
DROP TABLE IF EXISTS `user` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `type` ENUM('admin', 'guest') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `floor`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `floor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `number_UNIQUE` (`number` ASC))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `room`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `room` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tv` TINYINT(1) NOT NULL,
  `number` INT NOT NULL,
  `floor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `number_UNIQUE` (`number` ASC, `floor_id` ASC),
  INDEX `fk_room_floor1_idx` (`floor_id` ASC),
  CONSTRAINT `fk_room_floor1`
    FOREIGN KEY (`floor_id`)
    REFERENCES `floor` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `reservation_detail`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `reservation_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_request` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_reservation` TIMESTAMP NOT NULL,
  `time` INT NULL,
  `status` ENUM('request', 'approved', 'canceled') NOT NULL DEFAULT 'request',
  `user_id` INT NOT NULL,
  `item` ENUM('book', 'room', 'equipment') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reservation_detail_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_reservation_detail_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `room_reservation`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `room_reservation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reservation_detail_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  PRIMARY KEY (`id`, `reservation_detail_id`),
  INDEX `fk_room_reservation_reservation_detail1_idx` (`reservation_detail_id` ASC),
  INDEX `fk_room_reservation_room1_idx` (`room_id` ASC),
  CONSTRAINT `fk_room_reservation_reservation_detail1`
    FOREIGN KEY (`reservation_detail_id`)
    REFERENCES `reservation_detail` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_reservation_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `room` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `equipment`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `equipment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `quantity` INT NOT NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `serial_number` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `manufacturer_UNIQUE` (`manufacturer` ASC, `serial_number` ASC))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `equipment_reservation`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `equipment_reservation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reservation_detail_id` INT NOT NULL,
  `equipment_id` INT NOT NULL,
  PRIMARY KEY (`id`, `reservation_detail_id`),
  INDEX `fk_equipment_reservation_reservation_detail1_idx` (`reservation_detail_id` ASC),
  INDEX `fk_equipment_reservation_equipment1_idx` (`equipment_id` ASC),
  CONSTRAINT `fk_equipment_reservation_reservation_detail1`
    FOREIGN KEY (`reservation_detail_id`)
    REFERENCES `reservation_detail` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_equipment_reservation_equipment1`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `equipment` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `editorial`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `editorial` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `names` VARCHAR(45) NOT NULL,
  `surnames` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `edition` INT NOT NULL,
  `pages` INT NOT NULL,
  `ISBN` VARCHAR(45) NOT NULL,
  `editorial_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_editorial1_idx` (`editorial_id` ASC),
  INDEX `fk_book_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_book_editorial1`
    FOREIGN KEY (`editorial_id`)
    REFERENCES `editorial` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_book_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `book_reservation`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `book_reservation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reservation_detail_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`id`, `reservation_detail_id`),
  INDEX `fk_book_reservation_reservation_detail1_idx` (`reservation_detail_id` ASC),
  INDEX `fk_book_reservation_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_book_reservation_reservation_detail1`
    FOREIGN KEY (`reservation_detail_id`)
    REFERENCES `reservation_detail` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_book_reservation_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `event`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `place` VARCHAR(45) NOT NULL,
  `guest_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Table `event_registry`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `event_registry` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_email` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_registry_user1_idx` (`user_id` ASC),
  INDEX `fk_event_registry_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_registry_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_event_registry_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- -----------------------------------------------------
-- Inserts
-- -----------------------------------------------------

INSERT INTO `floor` (`number`)
VALUES (-2), (-1), (0), (1), (2), (3), (4);

INSERT INTO `room`(`tv`, `number`, `floor_id`)
VALUES
  (0,1,1), (0,2,1), (0,3,1), (0,4,1), (0,5,1), (1,6,1), (1,7,1), (1,8,1),
  (1,1,2), (1,2,2), (1,3,2), (1,4,2),
  (0,1,3), (0,2,3), (0,3,3), (0,4,3),
  (1,1,4), (1,2,4),
  (1,1,5), (1,2,5), (1,3,5), (1,4,5), (1,5,5),
  (1,1,6), (1,2,6), (1,3,6), (1,4,6), (1,5,6),
  (1,1,7), (1,2,7), (1,3,7), (1,4,7), (1,5,7);

INSERT INTO user (username, email, password, type) VALUES
  ('juanmsl', 'juanmsl_pk@hotmail.com', 'f3ba381b6baef526bf70ff220b1da4906989224b', 'admin'),
  ('luisdzc', 'luisdzc@gmail.com', 'f3ba381b6baef526bf70ff220b1da4906989224b', 'guest');