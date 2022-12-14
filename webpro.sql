-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 25, 2022 at 08:20 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10



/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webpro`
--
CREATE DATABASE webpro;
USE webpro;
-- --------------------------------------------------------

--
-- Table structure for table `user`
--

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `departID` varchar(255),
  `name` varchar(255) DEFAULT NULL,
  `departAva` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`departID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- --------------------------------------------------------
CREATE TABLE department_seq(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

DELIMITER $$

CREATE TRIGGER generate_departID
BEFORE INSERT ON `department`
FOR EACH ROW
BEGIN
  INSERT INTO department_seq VALUES (NULL);
  SET NEW.departID = CONCAT('DE', LPAD(LAST_INSERT_ID(), 4, '0'));
END$$
DELIMITER ;
--
-- Table structure for table `user`
--
CREATE TABLE `account` (
  `username` varchar(255),
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `employee` (
  `employeeID` varchar(255),
  `username` varchar(255),
  `name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `salary` int(255) DEFAULT 1000,
  `startDate` date DEFAULT NOW(),
  `departID` varchar(255),
  `avatar` varchar(255),
  PRIMARY KEY (`employeeID`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE,
  FOREIGN KEY (`departID`) REFERENCES `department` (`departID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE employee_seq(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

DELIMITER $$

CREATE TRIGGER generate_employeeID
BEFORE INSERT ON `employee`
FOR EACH ROW
BEGIN
  INSERT INTO employee_seq VALUES (NULL);
  SET NEW.employeeID = CONCAT('EM', LPAD(LAST_INSERT_ID(), 4, '0'));
END$$
DELIMITER ;
-- --------------------------------------------------------

--
-- Table structure for table `request`
--


CREATE TABLE `request` (
  `requestID` varchar(255),
  `type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) DEFAULT 'pending',
  `datesent` date DEFAULT NOW(),
  `datedecided` date DEFAULT NULL,
  `lowerID` varchar(255) DEFAULT NULL,
  `upperID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`requestID`),
  FOREIGN KEY (`lowerID`) REFERENCES `employee` (`employeeID`) ON DELETE CASCADE,
  FOREIGN KEY (`upperID`) REFERENCES `employee` (`employeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE request_seq(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);
DELIMITER $$
CREATE TRIGGER generate_requestID
BEFORE INSERT ON `request`
FOR EACH ROW
BEGIN
  INSERT INTO request_seq VALUES (NULL);
  SET NEW.requestID = CONCAT('REQ', LPAD(LAST_INSERT_ID(), 4, '0'));
END$$
DELIMITER ;

CREATE TABLE `request_absence` (
  `absenceID` varchar(255),
  `date_start_absence` date DEFAULT NULL,
  `date_end_absence` date DEFAULT NULL,
  PRIMARY KEY (`absenceID`),
  FOREIGN KEY (`absenceID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `request_salary` (
  `salaryID` varchar(255),
  `amount` int(255) DEFAULT NULL,
  PRIMARY KEY (`salaryID`),
  FOREIGN KEY (`salaryID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--
CREATE TABLE `task` (
  `taskID` varchar(255),
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) DEFAULT 'assigned',
  `assignedDate` date DEFAULT NOW(),
  `deadline` date DEFAULT NULL,
  `checkinDate` date DEFAULT NULL,
  `checkoutDate` date DEFAULT NULL,
  `submitFile` varchar(255) DEFAULT NULL,
  `lowerID` varchar(255) DEFAULT NULL,
  `upperID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`taskID`),
  FOREIGN KEY (`lowerID`) REFERENCES `employee` (`employeeID`) ON DELETE CASCADE,
  FOREIGN KEY (`upperID`) REFERENCES `employee` (`employeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE task_seq(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);
DELIMITER $$
CREATE TRIGGER generate_taskID
BEFORE INSERT ON `task`
FOR EACH ROW
BEGIN
  INSERT INTO task_seq VALUES (NULL);
  SET NEW.taskID = CONCAT('TAS', LPAD(LAST_INSERT_ID(), 4, '0'));
END$$
DELIMITER ;

-- Table noti
CREATE TABLE `announce` (
  `announceID` varchar(255),
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `announceDate` date DEFAULT NOW(),
  `upperID` varchar(255) DEFAULT NULL,
  `departID` varchar(255),
  `announceFile` varchar(255),
  PRIMARY KEY (`announceID`),
  FOREIGN KEY (`upperID`) REFERENCES `employee` (`employeeID`) ON DELETE CASCADE,
  FOREIGN KEY (`departID`) REFERENCES `department` (`departID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE announce_seq(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);
DELIMITER $$
CREATE TRIGGER generate_annouceID
BEFORE INSERT ON `announce`
FOR EACH ROW
BEGIN
  INSERT INTO announce_seq VALUES (NULL);
  SET NEW.announceID = CONCAT('AN', LPAD(LAST_INSERT_ID(), 4, '0'));
END$$
DELIMITER ;

-- Insert CEO and Admin department
INSERT INTO `department` (`name`) VALUES
('Ceo'),
('Admin');
-- Insert department
INSERT INTO `department` (`name`, `departAva`) VALUES
('Konoha', './files/departmentAvatars/konoha.svg'),
('Suna', './files/departmentAvatars/suna.svg'),
('Kumo', './files/departmentAvatars/kumo.svg'),
('Kiri', './files/departmentAvatars/kiri.svg'),
('Iwa', './files/departmentAvatars/iwa.svg');
-- -- --------------------------------------------------------
-- Insert admin and head account
INSERT INTO `account` (`username`, `password`, `role`) VALUES
('ceo','ceo','ceo'),
('admin', 'admin', 'admin'),
('hokage', 'hokage', 'head'),
('kazekage', 'kazekage', 'head'),
('raikage', 'raikage', 'head'),
('mizukage', 'mizukage', 'head'),
('tsuchikage', 'tsuchikage', 'head');

-- Insert ceo, admin, head employee
INSERT INTO `employee` (`username`, `name`, `gender`, `dob`,`nationality`, `address`, `phone`, `salary`, `startDate`, `departID`, `avatar`) VALUES
('ceo','Hagoromo','male','2002-10-10','vnese','ceo','0900000000','10000','2020-01-01','DE0001','https://fandom.vn/wp-content/uploads/2019/04/naruto-hagoromo-otsutsuki-1.jpg'),
('admin', 'admin', 'male', '2002-10-10', 'vnese', 'admin', '090000000','1000','2020-01-01','DE0002','https://previews.123rf.com/images/ylivdesign/ylivdesign2004/ylivdesign200402733/144989837-global-admin-icon-outline-global-admin-vector-icon-for-web-design-isolated-on-white-background.jpg'),
('hokage', 'Hokage', 'female', '2002-10-10', 'vnese','langla',  '0900000000','1000','2020-01-01', 'DE0003','https://pbs.twimg.com/media/EkUBRodXcAEILDa.jpg'),
('kazekage', 'Kazekage', 'male', '2002-10-10', 'vnese','langcat',  '0900000000','1000','2020-01-01', 'DE0004','https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Kazekage_hat_%28Naruto%2C_manga%29.svg/1200px-Kazekage_hat_%28Naruto%2C_manga%29.svg.png'),
('raikage', 'Raikage', 'male', '2002-10-10', 'vnese','langmay',  '0900000000','1000','2020-01-01', 'DE0005','https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Raikage_hat_%28Naruto%2C_manga%29.svg/1200px-Raikage_hat_%28Naruto%2C_manga%29.svg.png'),
('mizukage', 'Mizukage', 'female', '2002-10-10', 'vnese','langsuongmu',  '0900000000','1000','2020-01-01', 'DE0006','https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Mizukage_hat_%28Naruto%2C_manga%29.svg/1575px-Mizukage_hat_%28Naruto%2C_manga%29.svg.png'),
('tsuchikage', 'Tsuchikage', 'male', '2002-10-10', 'vnese','langda',  '0900000000','1000','2020-01-01', 'DE0007','https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Tsuchikage_hat_%28Naruto%2C_manga%29.svg/1575px-Tsuchikage_hat_%28Naruto%2C_manga%29.svg.png');

-- Insert Konoha officer account
INSERT INTO `account` (`username`, `password`, `role`) VALUES
('naruto', 'naruto', 'officer'),
('sasuke', 'sasuke', 'officer'),
('sakura', 'sakura', 'officer'),
('kakashi', 'kakashi', 'officer');

-- Insert Konoha officer employee
INSERT INTO `employee` (`username`, `name`, `gender`, `dob`,`nationality`, `address`, `phone`, `salary`, `startDate`, `departID`, `avatar`) VALUES
('naruto', 'Uzumaki Naruto', 'male', '2002-10-10', 'vnese','langla',  '0900000000','1000','2020-01-01', 'DE0003', 'https://staticg.sportskeeda.com/editor/2022/08/53e15-16596004347246.png'),
('sasuke', 'Uchiha Sasuke', 'male', '2002-10-10', 'vnese','langla',  '0900000000','1000','2020-01-01', 'DE0003', 'https://i.pinimg.com/originals/05/2a/23/052a23ab1c6742fe4b13fd751c2ed425.png'),
('sakura', 'Haruno Sakura', 'female', '2002-10-10', 'vnese','langla',  '0900000000','1000','2020-01-01', 'DE0003', 'https://manga-kun.com/wp-content/uploads/2020/11/Sakura.png'),
('kakashi', 'Hatake Kakashi', 'male', '2002-10-10', 'vnese','langla',  '0900000000','1000','2020-01-01', 'DE0003', 'https://i.pinimg.com/originals/38/b1/71/38b171304731a9cc8a8f25f7b40c2a7a.jpg');

-- Insert Suna officer account
INSERT INTO `account` (`username`, `password`, `role`) VALUES
('gaara', 'gaara', 'officer'),
('temari', 'temari', 'officer'),
('kankuro', 'kankuro', 'officer');

-- Insert Suna officer employee
INSERT INTO `employee` (`username`, `name`, `gender`, `dob`,`nationality`, `address`, `phone`, `salary`, `startDate`, `departID`, `avatar`) VALUES
('gaara', 'Gaara', 'male', '2002-10-10', 'vnese','langcat',  '0900000000','1000','2020-01-01', 'DE0004', 'https://staticg.sportskeeda.com/editor/2022/07/7ffdc-16590925062039.png'),
('temari', 'Temari', 'female', '2002-10-10', 'vnese','langcat',  '0900000000','1000','2020-01-01', 'DE0004', 'https://static.fandomspot.com/images/03/29080/00-featured-naruto-shippuden-temari-screenshot.jpg'),
('kankuro', 'Kankuru', 'male', '2002-10-10', 'vnese','langcat',  '0900000000','1000','2020-01-01', 'DE0004', 'https://i.pinimg.com/564x/8e/b4/9d/8eb49dc673861fac1dcb7d4bf3c81a39.jpg');

-- Insert Kumo officer account
INSERT INTO `account` (`username`, `password`, `role`) VALUES
('raikagea', 'raikagea', 'officer'),
('killerb', 'killerb', 'officer');

-- Insert Kumo officer employee
INSERT INTO `employee` (`username`, `name`, `gender`, `dob`,`nationality`, `address`, `phone`, `salary`, `startDate`, `departID`, `avatar`) VALUES
('raikagea', 'Raikage A', 'male', '2002-10-10', 'vnese','langmay',  '0900000000','1000','2020-01-01', 'DE0005', 'https://genk.mediacdn.vn/2019/10/22/photo-1-15717315890591912656601.jpg'),
('killerb', 'Killer B', 'male', '2002-10-10', 'vnese','langmay',  '0900000000','1000','2020-01-01', 'DE0005', 'https://www.animesoulking.com/wp-content/uploads/2021/04/naruto-killer-bee-740x414.jpg');

-- Insert Kiri officer account
INSERT INTO `account` (`username`, `password`, `role`) VALUES
('mei', 'mei', 'officer'),
('chojuro', 'chojuro', 'officer');

-- Insert Kiri officer employee
INSERT INTO `employee` (`username`, `name`, `gender`, `dob`,`nationality`, `address`, `phone`, `salary`, `startDate`, `departID`, `avatar`) VALUES
('mei', 'Mei', 'female', '2002-10-10', 'vnese','langsuongmu',  '0900000000','1000','2020-01-01', 'DE0006', 'https://i0.wp.com/rei.animecharactersdatabase.com/uploads/chars/12602-485632184.png'),
('chojuro', 'Chojuro', 'male', '2002-10-10', 'vnese','langsuongmu',  '0900000000','1000','2020-01-01', 'DE0006', 'https://i.pinimg.com/originals/77/6f/ec/776fec89e78e790b8ce11ea60cbafc62.png');

-- Insert Kiri officer account
INSERT INTO `account` (`username`, `password`, `role`) VALUES
('onoki', 'onoki', 'officer'),
('kurotsuchi', 'kurotsuchi', 'officer');

-- Insert Kiri officer employee
INSERT INTO `employee` (`username`, `name`, `gender`, `dob`,`nationality`, `address`, `phone`, `salary`, `startDate`, `departID`, `avatar`) VALUES
('onoki', 'Onoki', 'male', '2002-10-10', 'vnese','langda',  '0900000000','1000','2020-01-01', 'DE0007', 'https://staticg.sportskeeda.com/editor/2022/09/08997-16625499011834.png'),
('kurotsuchi', 'Kurotsuchi', 'female', '2002-10-10', 'vnese','langda',  '0900000000','1000','2020-01-01', 'DE0007', 'https://staticg.sportskeeda.com/editor/2022/09/b511d-16632473097456.png');


-- Insert Head task
INSERT INTO `task` (`title`, `description`, `status`, `deadline`, `lowerID`, `upperID`) VALUES
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0003', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0003', 'EM0001'),


('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0004', 'EM0001'),


('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0005', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0005', 'EM0001'),



('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0006', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0006', 'EM0001'),



('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'assigned', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'in progress', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'pending', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'completed', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0007', 'EM0001'),
('taskTitle', 'taskDescript', 'overdue', '2022-12-30', 'EM0007', 'EM0001');

-- Insert Konoha task
INSERT INTO `task` (`title`, `description`, `status`, `deadline`, `lowerID`, `upperID`) VALUES
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0008', 'EM0002'),

('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0009', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0009', 'EM0002'),


('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0010', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0010', 'EM0002'),


('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'assigned' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'in progress' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'pending' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'completed' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0011', 'EM0002'),
('taskTitle', 'taskDescript', 'overdue' , '2022-12-30', 'EM0011', 'EM0002');


-- insert request from head
INSERT INTO `request` (`type`,`title`, `description`, `status`, `lowerID`, `upperID`) VALUES
('other', 'requestTitle', 'requestDescript', 'pending','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0003','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0003','EM0001'),


('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0004','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0004','EM0001'),


('other', 'requestTitle', 'requestDescript', 'pending','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0005','EM0001'),

('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0006','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0006','EM0001'),

('other', 'requestTitle', 'requestDescript', 'pending','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0007','EM0001'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0007','EM0001');


-- insert request from konoha
INSERT INTO `request` (`type`,`title`, `description`, `status`, `lowerID`, `upperID`) VALUES
('other', 'requestTitle', 'requestDescript', 'pending','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0008','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0008','EM0003'),


('other', 'requestTitle', 'requestDescript', 'pending','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0009','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0009','EM0003'),


('other', 'requestTitle', 'requestDescript', 'pending','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0010','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0010','EM0003'),

('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'accepted','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'pending','EM0011','EM0003'),
('other', 'requestTitle', 'requestDescript', 'rejected','EM0011','EM0003');


INSERT INTO `announce` (`title`, `description`, `upperID`, `departID`, `announceFile`) VALUES
('[HAPPY NEW YEAR]', 'Happy new year everyone. Wish you good health', 'EM0001', 'DE0001','../files/announceFiles/announce.txt'),
('[HAPPY VALENTINE]', 'Happy valentine everyone. Wish you could find someone you love', 'EM0003', 'DE0003','../files/announceFiles/announce.txt'),
('[NEW PROJECT]', 'This is new project for department Konoha. Please view your work', 'EM0001', 'DE0001','../files/announceFiles/announce.txt'),
('[MERRY CHIRSTMAS]', 'Merry christmas everyone. Wish you happy with your family', 'EM0001', 'DE0001','../files/announceFiles/announce.txt'),
('[TEAM BUILDING]', 'This sunday we will go team building at Phan thiet. Please prepare', 'EM0004', 'DE0004','../files/announceFiles/announce.txt'),
('[WORK ABROAD]', 'Want to work abroad at USA? View this file', 'EM0005', 'DE0005','../files/announceFiles/announce.txt'),
('[TET HOLIDAY]', 'This is our plan fot Tet holiday. please prepare', 'EM0003', 'DE0003','../files/announceFiles/announce.txt'),
('[SUMMER VACATION]', 'This summer we will go team building in Nha Trang. Please prepare', 'EM0003', 'DE0003','../files/announceFiles/announce.txt'),
('[PROJECT PHOENIX]', 'Our department gonna conduct a new project. All officers please view this file', 'EM0006', 'DE0006','../files/announceFiles/announce.txt'),
('[WORK ABROAD]', 'Next month our department will work abroad in Singapore. Please fill this form if you want to participate.', 'EM0007', 'DE0007','../files/announceFiles/announce.txt'),
('[INDEPENDENCE DAY]', 'This is the schedule for Independence Day. Please have a fun holiday', 'EM0003', 'DE0003','../files/announceFiles/announce.txt');

-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
-- /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
-- /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
