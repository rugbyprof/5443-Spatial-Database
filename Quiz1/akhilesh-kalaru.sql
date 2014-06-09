/* CMPS 5443 - Spatial Database Quiz 1 Solutions */
/* AKHILESH KALARU */
/* Part one Solution 1 */
 Table structure for table `Plantes`
--

CREATE TABLE IF NOT EXISTS `Plantes` (
  `Name` varchar(8) NOT NULL,
  `NumMoons` int(3) NOT NULL,
  `Type` varchar(8) NOT NULL,
  `LengthofYear` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Plantes`
--

INSERT INTO `Plantes` (`Name`, `NumMoons`, `Type`, `LengthofYear`) VALUES
('Mercury', 0, 'Rocky', 0.24),
('Venus', 0, 'Rocky', 0.62),
('Earth', 1, 'Rocky', 1),
('Mars', 2, 'Rocky', 1.88),
('Jupiter', 16, 'Gas', 11.86),
('Saturn', 18, 'Gas', 29.46),
('Pluto', 1, 'Rocky', 247.7);


/* Part one Solution 2 */


Table structure for table `probes`
--

CREATE TABLE IF NOT EXISTS `probes` (
  `name` varchar(13) NOT NULL,
  `year` int(4) NOT NULL,
  `dest` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `probes`
--

INSERT INTO `probes` (`name`, `year`, `dest`) VALUES
('Pioneer 5', 1960, 'sun'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter ');

/* Part two Solution 3 */
SELECT * FROM `Plantes` ;
Describe Plantes;
SELECT * FROM `probes`;
Describe Probes;
/* Part two Solution 4 */
SELECT count(Name) FROM `Plantes`;
/* Part two Solution 5 */
SELECT sum(NumMoons) from `Plantes`;
/* Part two Solution 6 */
SELECT count(name) FROM `probes` WHERE dest = 'Mars'
/* Part two Solution 7 */
SELECT name FROM `probes` WHERE dest in (SELECT Name FROM `Plantes` WHERE NumMoons > 0 );
/* Part two Solution 8 */
SELECT name FROM `probes` WHERE dest IN (SELECT Name FROM `Plantes` WHERE type = 'Rocky')
/* Part two Solution 9 */
SELECT name FROM `probes` WHERE dest IN
(SELECT Name FROM `Plantes` WHERE LengthofYear = ( select MIN(LengthofYear) from `Plantes`));
/* Part two Solution 10 */
SELECT Name FROM `Plantes` WHERE LengthofYear = ( SELECT MAX(LengthofYear) FROM `Plantes`); 
/* Part two Solution 11 */
SELECT Name FROM `Plantes` WHERE Type = 'Gas' ;
/* Part two Solution 12 */
SELECT Name FROM `Plantes` WHERE NumMoons >= 1 ; 
