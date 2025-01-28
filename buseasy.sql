-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 28, 2025 at 07:30 AM
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
-- Database: `buseasy`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `contactid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedbackid` int(11) NOT NULL,
  `reservationid` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journey`
--

CREATE TABLE `journey` (
  `journeyid` int(11) NOT NULL,
  `route` varchar(255) NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `date` date NOT NULL,
  `fee` decimal(10,2) NOT NULL,
  `status` enum('scheduled','completed','cancelled') NOT NULL,
  `conductorid` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `journey`
--

INSERT INTO `journey` (`journeyid`, `route`, `departure_time`, `arrival_time`, `date`, `fee`, `status`, `conductorid`, `created_at`) VALUES
(4, 'colombo-jaffna', '09:30:00', '10:00:00', '2025-02-01', 450.00, 'completed', 5, '2025-01-23 15:01:31'),
(6, 'colombo-jaffna', '09:30:00', '10:00:00', '2025-02-01', 1500.00, 'scheduled', 5, '2025-01-23 16:00:26'),
(7, 'colombo-jaffna', '09:30:00', '10:00:00', '2025-02-08', 450.00, 'completed', 5, '2025-01-23 16:01:10'),
(8, 'Kaduwela-Maharagama', '06:00:00', '06:30:00', '2025-01-31', 200.00, 'completed', 5, '2025-01-23 16:01:50'),
(9, 'Hanwella-Pitakotuwa', '08:00:00', '10:00:00', '2025-01-31', 150.00, 'scheduled', 5, '2025-01-23 16:03:55');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `paymentid` int(11) NOT NULL,
  `reservationid` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `payment_method` enum('card','cash','online') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `reservationid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `journeyid` int(11) NOT NULL,
  `seats` varchar(100) NOT NULL,
  `payment_status` enum('pending','completed','failed') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`reservationid`, `userid`, `journeyid`, `seats`, `payment_status`, `created_at`) VALUES
(5, 3, 9, '4,5,20', 'completed', '2025-01-23 17:15:34'),
(6, 3, 9, '1,2', 'pending', '2025-01-23 18:58:57'),
(7, 3, 9, '3,6', 'pending', '2025-01-23 19:00:00'),
(8, 3, 9, '7,8', 'pending', '2025-01-23 19:02:13'),
(9, 3, 6, '1,2', 'pending', '2025-01-23 19:03:33'),
(10, 3, 9, '12,16', 'pending', '2025-01-23 19:10:02');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userid` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `contactnumber` varchar(15) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('conductor','passenger') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `firstname`, `lastname`, `contactnumber`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'SUNETH', 'hettiarachchi', '01232456789', 'ss', '$2y$10$1fw7uHLBDamtAlvqNHJpx.60i2Lfd0rJpSIPg3hM3uPM2giFQMk8C', 'passenger', '2025-01-19 16:07:41'),
(2, 'dd', 'dd', '123234', 'dd', '$2y$10$CbP5/bghiPmvJBT6lrRspuS1HwV6SW80nHwZDvY2Cp0ZgYx2/SQ1u', 'conductor', '2025-01-19 17:23:00'),
(3, 'ww', 'ww', '1111111111', 'ww', '$2y$10$0mwZpcl.tBZdovbum8P0IugMyhttBSf5DBkH4f89O7fYfo1k29MWC', 'passenger', '2025-01-19 17:54:03'),
(4, 'ee', 'ee', '0761856944', 'eee', '$2y$10$2t3krdUTlAvSDzd213OaXewGwtSCjNaxIJHdMEotqCzVOLrwaBesG', 'passenger', '2025-01-21 16:15:48'),
(5, 'rrr', 'rrr', '0778710050', 'rr', '$2y$10$mPcc6fjlkQnZ86R580NjUud5ZhCAuL/G7id4ywFiLk74..1F6ZY8K', 'conductor', '2025-01-21 16:16:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contactid`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedbackid`),
  ADD KEY `reservationid` (`reservationid`);

--
-- Indexes for table `journey`
--
ALTER TABLE `journey`
  ADD PRIMARY KEY (`journeyid`),
  ADD KEY `conductorid` (`conductorid`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`paymentid`),
  ADD KEY `reservationid` (`reservationid`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservationid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `journeyid` (`journeyid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `contactid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedbackid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journey`
--
ALTER TABLE `journey`
  MODIFY `journeyid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `paymentid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservationid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`reservationid`) REFERENCES `reservation` (`reservationid`);

--
-- Constraints for table `journey`
--
ALTER TABLE `journey`
  ADD CONSTRAINT `journey_ibfk_1` FOREIGN KEY (`conductorid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`reservationid`) REFERENCES `reservation` (`reservationid`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`journeyid`) REFERENCES `journey` (`journeyid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
