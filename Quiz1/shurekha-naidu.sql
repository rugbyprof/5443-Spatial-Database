# 5443 Quiz 1
# Surekha Kotiyala
# M20206704
# Answers

#(1)################################
CREATE TABLE IF NOT EXISTS `Planets` (
  `Name` varchar(15) DEFAULT NULL,
  `NumMoons` int(25) NOT NULL,
  `Type` varchar(15) NOT NULL,
  `LengthOfYear` float(8,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Planets`
--

INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES
('Mercury', 0, 'Rocky', 0.240),
('Venus', 0, 'Rocky', 0.620),
('Earth', 1, 'Rocky', 1.000),
('Mars', 2, 'Rocky', 1.880),
('Jupiter', 16, 'Gas', 11.860),
('Saturn', 18, 'Gas', 29.460),
('Pluto', 1, 'Rocky', 247.700);



#(2)###################################################
CREATE TABLE IF NOT EXISTS `Probes` (
  `name` varchar(25) NOT NULL,
  `year` int(20) NOT NULL,
  `dest` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Probes`
--

INSERT INTO `Probes` (`name`, `year`, `dest`) VALUES
('Pioneer 5', 1960, 'sun'),
('Mariner 10', 1974, 'Mercury'),
('Messenger', 2008, 'Mercury'),
('Zond', 1964, 'Venus'),
('Viking', 1976, 'Mars'),
('Cassini', 2000, 'Jupiter'),
('Galileo', 1995, 'Jupiter');



#(3) ##########################################
SELECT * FROM Planets
SELECT * FROM Probes
describe Planets
describe Probes




#####################################
#(4) ########how many planets in db
SELECT COUNT(*) FROM Planets



#####################################
#(5) ######### how many moons in db
SELECT SUM(NumMoons) FROM Planets



############################################
#(6) ########num of probes that went to mars
SELECT COUNT(name) FROM Probes where dest = 'Mars'





########################################
#(7) ########## names of probes
SELECT pr.name FROM Probes pr JOIN Planets pl ON (pr.dest=pl.Name) WHERE pl.NumMoons >0




#######################################
#(8) ############# to rocky
SELECT pr.name FROM Probes pr JOIN Planets pl ON (pr.dest=pl.Name) WHERE pl.Type='Rocky'




#########################################
#(9) ######Shortes
SELECT pr.name, MIN(pl.LengthOfYear) FROM Probes pr JOIN Planets pl ON (pr.dest=pl.Name)




########################################
#(10) ##########longest
SELECT Name, MAX(LengthOfYear) FROM Planets 




########################################
#(11) 
SELECT Name FROM Planets WHERE Type = 'Gas'





#################################
#(12)
SELECT Name FROM Planets WHERE NumMoons>0