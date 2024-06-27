SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
CREATE DATABASE IF NOT EXISTS `login_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `login_db`;
CREATE TABLE `login` (
  `ID` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `login` (`ID`, `username`, `password`, `name`, `level`) VALUES
(1, '111', '111', 'waiyawut', 'admin'),
(2, '222', '222', 'devtai', 'member');
ALTER TABLE `login`
  ADD PRIMARY KEY (`ID`);
ALTER TABLE `login`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;
