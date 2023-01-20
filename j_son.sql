-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2023 at 12:08 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `j_son`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `extract_names` ()   BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE name VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT json_data FROM json_table;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT JSON_EXTRACT(name, '$.name');
    END LOOP;
    CLOSE cur;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `extract_json_data` () RETURNS VARCHAR(255) CHARSET utf8mb4  BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE name VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT json_data FROM json_table;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET name = JSON_EXTRACT(name, '$.name');
    END LOOP;
    CLOSE cur;
    RETURN name;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `json_table`
--

CREATE TABLE `json_table` (
  `id` int(11) DEFAULT NULL,
  `json_data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `json_table`
--

INSERT INTO `json_table` (`id`, `json_data`) VALUES
(2, '{\"name\": \"Jane\", \"age\": 25, \"address\": {\"city\": \"Los Angeles\", \"state\": \"CA\"}}'),
(3, '{\"name\": \"Jay\", \"age\": 22, \"address\": {\"city\": \"San Diego\", \"state\": \"CA\"}}'),
(4, '{\"name\": \"John\", \"age\": 30, \"address\": {\"city\": \"New York\", \"state\": \"NY\"}}'),
(1, '{\"name\": \"Jack\", \"age\": 32, \"address\": {\"city\": \"New York\", \"state\": \"NY\"}}'),
(5, '{\"name\": \"Johan\", \"age\": 40, \"address\": {\"city\": \"New York\", \"state\": \"NY\"}}');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
