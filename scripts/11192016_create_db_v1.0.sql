-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema heroku_972f993ecef99cc
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `heroku_972f993ecef99cc` ;

-- -----------------------------------------------------
-- Schema heroku_972f993ecef99cc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `heroku_972f993ecef99cc` DEFAULT CHARACTER SET utf8 ;
USE `heroku_972f993ecef99cc` ;

-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`countries` (
  `country_id` INT NOT NULL,
  `country_name` VARCHAR(100) NULL,
  `country_short_code` VARCHAR(5) NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`cities` (
  `city_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `city_name` VARCHAR(100) NULL,
  `city_short_code` VARCHAR(5) NULL,
  PRIMARY KEY (`city_id`, `country_id`),
  INDEX `fk_cities_countries1_idx` (`country_id` ASC),
  CONSTRAINT `fk_cities_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `heroku_972f993ecef99cc`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`location` (
  `city_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `state` VARCHAR(45) NULL,
  `zipcode` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`city_id`, `country_id`),
  INDEX `fk_location_cities1_idx` (`city_id` ASC, `country_id` ASC),
  CONSTRAINT `fk_location_cities1`
    FOREIGN KEY (`city_id` , `country_id`)
    REFERENCES `heroku_972f993ecef99cc`.`cities` (`city_id` , `country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`person` (
  `person_id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `dob` DATE NULL,
  `gender` CHAR NULL,
  `permanent_address` VARCHAR(100) NULL,
  `city_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `primary_no` DECIMAL(10,0) NULL,
  `secondary_no` DECIMAL(10,0) NULL,
  `email` VARCHAR(45) NULL,
  `nationality` VARCHAR(45) NULL,
  PRIMARY KEY (`person_id`),
  INDEX `fk_person_location1_idx` (`city_id` ASC, `country_id` ASC),
  CONSTRAINT `fk_person_location1`
    FOREIGN KEY (`city_id` , `country_id`)
    REFERENCES `heroku_972f993ecef99cc`.`location` (`city_id` , `country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`moderator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`moderator` (
  `moderator_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`moderator_id`, `user_id`),
  INDEX `fk_moderator_person1_idx` (`user_id` ASC),
  CONSTRAINT `fk_moderator_person1`
    FOREIGN KEY (`user_id`)
    REFERENCES `heroku_972f993ecef99cc`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`passport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`passport` (
  `passport_no` VARCHAR(9) NOT NULL,
  `expiry_date` DATE NOT NULL,
  `country_of_issuance_code` INT NOT NULL,
  PRIMARY KEY (`passport_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`passenger` (
  `pnr` VARCHAR(10) NOT NULL,
  `user_id` INT NOT NULL,
  `passport_no` VARCHAR(9) NOT NULL,
  `cust_type` CHAR NULL COMMENT 'ADULT, CHILD, INFANT',
  `promo_code` VARCHAR(6) NULL,
  `meal_preference_code` INT NOT NULL,
  `frequent_flyer_id` INT NULL,
  PRIMARY KEY (`user_id`, `pnr`),
  INDEX `fk_passenger_person1_idx` (`user_id` ASC),
  CONSTRAINT `fk_passenger_passport`
    FOREIGN KEY (`passport_no`)
    REFERENCES `heroku_972f993ecef99cc`.`passport` (`passport_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_passenger_person1`
    FOREIGN KEY (`user_id`)
    REFERENCES `heroku_972f993ecef99cc`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`airport` (
  `airport_code` INT NOT NULL,
  `city_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `airport_name` VARCHAR(100) NULL,
  `coordinates` POINT NULL,
  PRIMARY KEY (`airport_code`),
  INDEX `fk_airport_location1_idx` (`city_id` ASC, `country_id` ASC),
  CONSTRAINT `fk_airport_location1`
    FOREIGN KEY (`city_id` , `country_id`)
    REFERENCES `heroku_972f993ecef99cc`.`location` (`city_id` , `country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`route` (
  `route_id` INT NOT NULL,
  `departure_airport_code` INT NOT NULL,
  `arrival_airport_code` INT NOT NULL,
  `distance` INT NULL,
  PRIMARY KEY (`route_id`),
  INDEX `fk_route_airport1_idx` (`departure_airport_code` ASC),
  INDEX `fk_route_airport2_idx` (`arrival_airport_code` ASC),
  CONSTRAINT `fk_route_airport1`
    FOREIGN KEY (`departure_airport_code`)
    REFERENCES `heroku_972f993ecef99cc`.`airport` (`airport_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_route_airport2`
    FOREIGN KEY (`arrival_airport_code`)
    REFERENCES `heroku_972f993ecef99cc`.`airport` (`airport_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`fare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`fare` (
  `route_id` INT NOT NULL,
  `special_code` VARCHAR(10) NOT NULL,
  `fare` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`route_id`, `special_code`),
  INDEX `fk_fare_route1_idx` (`route_id` ASC),
  CONSTRAINT `fk_fare_route1`
    FOREIGN KEY (`route_id`)
    REFERENCES `heroku_972f993ecef99cc`.`route` (`route_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`flight` (
  `flight_no` VARCHAR(5) NOT NULL,
  `no_of_stops` INT NULL DEFAULT 0,
  PRIMARY KEY (`flight_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`flight_leg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`flight_leg` (
  `leg_no` INT NOT NULL,
  `flight_no` VARCHAR(5) NOT NULL,
  `route_id` INT NOT NULL,
  `scheduled_arrival_time` TIMESTAMP NULL,
  `scheduled_departure_time` TIMESTAMP NULL,
  `leg_duration` INT NULL,
  PRIMARY KEY (`leg_no`, `flight_no`),
  INDEX `fk_flight_leg_flight1_idx` (`flight_no` ASC),
  INDEX `fk_flight_leg_route1_idx` (`route_id` ASC),
  CONSTRAINT `fk_flight_leg_flight1`
    FOREIGN KEY (`flight_no`)
    REFERENCES `heroku_972f993ecef99cc`.`flight` (`flight_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_leg_route1`
    FOREIGN KEY (`route_id`)
    REFERENCES `heroku_972f993ecef99cc`.`route` (`route_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`airplane_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`airplane_type` (
  `type_id` VARCHAR(25) NOT NULL,
  `total_seating_capacity` INT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`airplane`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`airplane` (
  `airplane_id` INT NOT NULL,
  `airplane_type_id` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`airplane_id`),
  INDEX `fk_airplane_airplane_type1_idx` (`airplane_type_id` ASC),
  CONSTRAINT `fk_airplane_airplane_type1`
    FOREIGN KEY (`airplane_type_id`)
    REFERENCES `heroku_972f993ecef99cc`.`airplane_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`leg_instance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`leg_instance` (
  `date_of_travel` DATE NOT NULL,
  `flight_no` VARCHAR(5) NOT NULL,
  `leg_no` INT NOT NULL,
  `assigned_airplane_id` INT NOT NULL,
  `arrival_time` TIMESTAMP NULL,
  `departure_time` TIMESTAMP NULL,
  `available_economy_seats` DECIMAL(10,0) NULL DEFAULT 0,
  `available_first_seats` DECIMAL(10,0) NULL DEFAULT 0,
  `available_business_seats` DECIMAL(10,0) NULL DEFAULT 0,
  PRIMARY KEY (`date_of_travel`, `flight_no`, `leg_no`),
  INDEX `fk_leg_instance_flight_leg1_idx` (`leg_no` ASC, `flight_no` ASC),
  INDEX `fk_leg_instance_airplane1_idx` (`assigned_airplane_id` ASC),
  CONSTRAINT `fk_leg_instance_flight_leg1`
    FOREIGN KEY (`leg_no` , `flight_no`)
    REFERENCES `heroku_972f993ecef99cc`.`flight_leg` (`leg_no` , `flight_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_leg_instance_airplane1`
    FOREIGN KEY (`assigned_airplane_id`)
    REFERENCES `heroku_972f993ecef99cc`.`airplane` (`airplane_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`aircraft_type_seat_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`aircraft_type_seat_class` (
  `class` VARCHAR(10) NOT NULL,
  `airplane_type_id` VARCHAR(25) NOT NULL,
  `total_seats` INT NULL,
  PRIMARY KEY (`class`, `airplane_type_id`),
  INDEX `fk_aircraft_type_seat_class_airplane_type1_idx` (`airplane_type_id` ASC),
  CONSTRAINT `fk_aircraft_type_seat_class_airplane_type1`
    FOREIGN KEY (`airplane_type_id`)
    REFERENCES `heroku_972f993ecef99cc`.`airplane_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`aircraft_type_seat_class_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`aircraft_type_seat_class_codes` (
  `class_code` VARCHAR(10) NOT NULL,
  `aircraft_type_seat_class` VARCHAR(10) NOT NULL,
  `aircraft_type_id` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`class_code`),
  INDEX `fk_aircraft_type_seat_class_codes_aircraft_type_seat_class1_idx` (`aircraft_type_seat_class` ASC, `aircraft_type_id` ASC),
  CONSTRAINT `fk_aircraft_type_seat_class_codes_aircraft_type_seat_class1`
    FOREIGN KEY (`aircraft_type_seat_class` , `aircraft_type_id`)
    REFERENCES `heroku_972f993ecef99cc`.`aircraft_type_seat_class` (`class` , `airplane_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`leg_instanace_seats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`leg_instanace_seats` (
  `seat_no` INT NOT NULL,
  `seat_class_code` VARCHAR(10) NOT NULL,
  `leg_instance_date_of_travel` DATE NOT NULL,
  `leg_instance_flight_no` VARCHAR(5) NOT NULL,
  `leg_instance_leg_no` INT NOT NULL,
  `assigned` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`seat_no`, `seat_class_code`, `leg_instance_date_of_travel`, `leg_instance_flight_no`, `leg_instance_leg_no`),
  INDEX `fk_leg_instanace_seats_leg_instance1_idx` (`leg_instance_date_of_travel` ASC, `leg_instance_flight_no` ASC, `leg_instance_leg_no` ASC),
  INDEX `fk_leg_instanace_seats_aircraft_type_seat_class_codes1_idx` (`seat_class_code` ASC),
  CONSTRAINT `fk_leg_instanace_seats_leg_instance1`
    FOREIGN KEY (`leg_instance_date_of_travel` , `leg_instance_flight_no` , `leg_instance_leg_no`)
    REFERENCES `heroku_972f993ecef99cc`.`leg_instance` (`date_of_travel` , `flight_no` , `leg_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_leg_instanace_seats_aircraft_type_seat_class_codes1`
    FOREIGN KEY (`seat_class_code`)
    REFERENCES `heroku_972f993ecef99cc`.`aircraft_type_seat_class_codes` (`class_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`ticket` (
  `ticket_no` DECIMAL(10,0) NOT NULL,
  `ticket_type` CHAR NULL,
  `status` CHAR NULL,
  PRIMARY KEY (`ticket_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`reservation` (
  `reservation_id` VARCHAR(45) NOT NULL,
  `reservation_date` DATETIME NOT NULL,
  `reservation_status` VARCHAR(45) NULL,
  `reservation_mode` CHAR NULL,
  `ticket_no` DECIMAL(10,0) NOT NULL,
  `passenger_user_id` INT NOT NULL,
  `passenger_pnr` VARCHAR(10) NOT NULL,
  `seat_no` INT NOT NULL,
  `seat_class_code` VARCHAR(10) NOT NULL,
  `date_of_travel` DATE NOT NULL,
  `flight_no` VARCHAR(5) NOT NULL,
  `leg_no` INT NOT NULL,
  INDEX `fk_reservation_ticket1_idx` (`ticket_no` ASC),
  INDEX `fk_reservation_passenger1_idx` (`passenger_user_id` ASC, `passenger_pnr` ASC),
  PRIMARY KEY (`reservation_id`),
  INDEX `fk_reservation_leg_instanace_seats1_idx` (`seat_no` ASC, `seat_class_code` ASC, `date_of_travel` ASC, `flight_no` ASC, `leg_no` ASC),
  CONSTRAINT `fk_reservation_ticket1`
    FOREIGN KEY (`ticket_no`)
    REFERENCES `heroku_972f993ecef99cc`.`ticket` (`ticket_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_passenger1`
    FOREIGN KEY (`passenger_user_id` , `passenger_pnr`)
    REFERENCES `heroku_972f993ecef99cc`.`passenger` (`user_id` , `pnr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_leg_instanace_seats1`
    FOREIGN KEY (`seat_no` , `seat_class_code` , `date_of_travel` , `flight_no` , `leg_no`)
    REFERENCES `heroku_972f993ecef99cc`.`leg_instanace_seats` (`seat_no` , `seat_class_code` , `leg_instance_date_of_travel` , `leg_instance_flight_no` , `leg_instance_leg_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`weekdays`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`weekdays` (
  `day_id` INT NOT NULL,
  `day_name` VARCHAR(45) NULL,
  PRIMARY KEY (`day_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_972f993ecef99cc`.`flight_workdays`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_972f993ecef99cc`.`flight_workdays` (
  `flight_no` VARCHAR(5) NOT NULL,
  `operating_day_id` INT NOT NULL,
  PRIMARY KEY (`flight_no`, `operating_day_id`),
  INDEX `fk_flight_workdays_flight1_idx` (`flight_no` ASC),
  CONSTRAINT `fk_flight_workdays_weekdays1`
    FOREIGN KEY (`operating_day_id`)
    REFERENCES `heroku_972f993ecef99cc`.`weekdays` (`day_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_workdays_flight1`
    FOREIGN KEY (`flight_no`)
    REFERENCES `heroku_972f993ecef99cc`.`flight` (`flight_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
