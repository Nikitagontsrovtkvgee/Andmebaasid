-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2025 at 03:01 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `retseptiraamatgontsarov`
--

-- --------------------------------------------------------

--
-- Table structure for table `kasutaja`
--

CREATE TABLE `kasutaja` (
  `kasutaja_id` int(11) NOT NULL,
  `eesnimi` varchar(50) DEFAULT NULL,
  `perenimi` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kasutaja`
--

INSERT INTO `kasutaja` (`kasutaja_id`, `eesnimi`, `perenimi`, `email`) VALUES
(1, 'Medik', 'Iz TF2', 'medik.TF2@edu.ee'),
(2, 'Mark', 'Mark', 'mark@tthk.ee'),
(3, 'Roman', 'Roman', 'roman@tthk.ee'),
(4, 'Lenin', 'Lenin', 'lenin.grazdanskajaoborona@edu.ee'),
(5, 'MOP', 'MOPOB', 'BOPOBODOB.MOP@email.com');

-- --------------------------------------------------------

--
-- Table structure for table `kategooria`
--

CREATE TABLE `kategooria` (
  `kategooria_id` int(11) NOT NULL,
  `kategooria_nimi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategooria`
--

INSERT INTO `kategooria` (`kategooria_id`, `kategooria_nimi`) VALUES
(1, 'majustused'),
(2, 'joogid'),
(3, 'köök'),
(4, 'külmikud'),
(5, 'praadi');

-- --------------------------------------------------------

--
-- Table structure for table `koostis`
--

CREATE TABLE `koostis` (
  `koostis_id` int(11) NOT NULL,
  `kogus` int(11) DEFAULT NULL,
  `retsept_retsept_id` int(11) DEFAULT NULL,
  `toiduaine_id` int(11) DEFAULT NULL,
  `yhik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `retsept`
--

CREATE TABLE `retsept` (
  `retsept_id` int(11) NOT NULL,
  `retsepti_nimi` varchar(100) DEFAULT NULL,
  `kirjeldus` varchar(200) DEFAULT NULL,
  `juhend` varchar(500) DEFAULT NULL,
  `sisestatud_kp` date DEFAULT NULL,
  `kasutaja_id` int(11) DEFAULT NULL,
  `kategooria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `retsept`
--

INSERT INTO `retsept` (`retsept_id`, `retsepti_nimi`, `kirjeldus`, `juhend`, `sisestatud_kp`, `kasutaja_id`, `kategooria_id`) VALUES
(1, 'Grill', 'nii soola', 'Kasuta Aerogrill', '2003-12-09', 4, 2),
(2, 'Mesi', 'liiga magus', 'varusta mesilased', '1914-06-25', 2, 3),
(3, 'Praed', 'vürtsikas', 'sea tapmine', '1936-03-30', 1, 2),
(4, 'külmik', 'külm', 'võtke siga rasva maha', '2008-08-10', 4, 1),
(5, 'cola', 'gaseeritud', 'muutunud diabeetiliseks', '1995-12-31', 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tehtud`
--

CREATE TABLE `tehtud` (
  `tehtud_kp` date DEFAULT NULL,
  `retsept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tehtud`
--

INSERT INTO `tehtud` (`tehtud_kp`, `retsept_id`) VALUES
('1957-06-04', 3),
('7561-08-12', 5),
('2759-08-26', 4),
('1946-10-27', 1),
('6863-04-09', 2);

-- --------------------------------------------------------

--
-- Table structure for table `toiduaine`
--

CREATE TABLE `toiduaine` (
  `toiduaine_Id` int(11) NOT NULL,
  `toiduaine_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `toiduaine`
--

INSERT INTO `toiduaine` (`toiduaine_Id`, `toiduaine_nimi`) VALUES
(1, 'vorst'),
(2, 'kurk'),
(3, 'liha'),
(4, 'blink'),
(5, 'pipar');

-- --------------------------------------------------------

--
-- Table structure for table `yhik`
--

CREATE TABLE `yhik` (
  `yhik_id` int(11) NOT NULL,
  `yhik_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `yhik`
--

INSERT INTO `yhik` (`yhik_id`, `yhik_nimi`) VALUES
(1, 'mg'),
(2, 'g'),
(3, 'kg'),
(4, 't'),
(5, 'c');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kasutaja`
--
ALTER TABLE `kasutaja`
  ADD PRIMARY KEY (`kasutaja_id`);

--
-- Indexes for table `kategooria`
--
ALTER TABLE `kategooria`
  ADD PRIMARY KEY (`kategooria_id`);

--
-- Indexes for table `koostis`
--
ALTER TABLE `koostis`
  ADD PRIMARY KEY (`koostis_id`),
  ADD KEY `retsept_retsept_id` (`retsept_retsept_id`),
  ADD KEY `toiduaine_id` (`toiduaine_id`),
  ADD KEY `yhik_id` (`yhik_id`);

--
-- Indexes for table `retsept`
--
ALTER TABLE `retsept`
  ADD PRIMARY KEY (`retsept_id`),
  ADD KEY `kasutaja_id` (`kasutaja_id`),
  ADD KEY `kategooria_id` (`kategooria_id`);

--
-- Indexes for table `tehtud`
--
ALTER TABLE `tehtud`
  ADD KEY `retsept_id` (`retsept_id`);

--
-- Indexes for table `toiduaine`
--
ALTER TABLE `toiduaine`
  ADD PRIMARY KEY (`toiduaine_Id`);

--
-- Indexes for table `yhik`
--
ALTER TABLE `yhik`
  ADD PRIMARY KEY (`yhik_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kasutaja`
--
ALTER TABLE `kasutaja`
  MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kategooria`
--
ALTER TABLE `kategooria`
  MODIFY `kategooria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `koostis`
--
ALTER TABLE `koostis`
  MODIFY `koostis_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `retsept`
--
ALTER TABLE `retsept`
  MODIFY `retsept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `toiduaine`
--
ALTER TABLE `toiduaine`
  MODIFY `toiduaine_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `yhik`
--
ALTER TABLE `yhik`
  MODIFY `yhik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `koostis`
--
ALTER TABLE `koostis`
  ADD CONSTRAINT `koostis_ibfk_1` FOREIGN KEY (`retsept_retsept_id`) REFERENCES `retsept` (`retsept_id`),
  ADD CONSTRAINT `koostis_ibfk_2` FOREIGN KEY (`toiduaine_id`) REFERENCES `toiduaine` (`toiduaine_Id`),
  ADD CONSTRAINT `koostis_ibfk_3` FOREIGN KEY (`yhik_id`) REFERENCES `yhik` (`yhik_id`);

--
-- Constraints for table `retsept`
--
ALTER TABLE `retsept`
  ADD CONSTRAINT `retsept_ibfk_1` FOREIGN KEY (`kasutaja_id`) REFERENCES `kasutaja` (`kasutaja_id`),
  ADD CONSTRAINT `retsept_ibfk_2` FOREIGN KEY (`kategooria_id`) REFERENCES `kategooria` (`kategooria_id`);

--
-- Constraints for table `tehtud`
--
ALTER TABLE `tehtud`
  ADD CONSTRAINT `tehtud_ibfk_1` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
