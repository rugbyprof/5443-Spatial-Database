# 5443 Quiz 1
# Vinesh Thummala

# 1 ##################################

		Create TABLE Planets
		(
		Name varchar(32),
		NumMoons int(8),
		Type varchar(32),
		LengthOfYear float(4,2)
		);
		
		INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Mercury', 0, 'Rocky', 0.240);
		INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Venus', 0, 'Rocky', 0.620);
		INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Earth', 1, 'Rocky', 1.000);
		INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Mars', 2, 'Rocky', 1.880);
		INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Jupiter', 16, 'Gas', 11.860);
		INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Satrun', 18, 'Gas', 29.460);
		INSERT INTO `Planets` (`Name`, `NumMoons`, `Type`, `LengthOfYear`) VALUES('Pluto', 1, 'Rocky', 247.700);
# 2 ##################################		

		Create TABLE Probes
		(
		name varchar(32),
		year int(8),
		dest varchar(32)
		);
		
		
		INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Pioneer 5', 1960, 'Sun');
		INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Mariner 10', 1974, 'Mercury');
		INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Messenger', 2008, 'Mercury');
		INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Zond', 1964, 'Venus');
		INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Viking', 1976, 'Mars');
		INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Cassini', 2000, 'Jupiter');
		INSERT INTO `Probes` (`name`, `Year`, `dest`) VALUES('Galileo', 1995, 'Jupiter');
		
# 3 ##################################

		SELECT * FROM Planets; 
		DESC Planets;
		SELECT * FROM Probes; 
		DESC Probes;		
		
# 4 ##################################

		SELECT Count(Name)
		FROM Planets;
		
# 5 ##################################

		SELECT Sum(NumMoons)
		FROM Planets;	
		
# 6 ##################################

		SELECT count(dest)
		FROM Probes 	
		WHERE dest = 'Mars';
		
# 7 ##################################		

		SELECT 	Probes.name
		FROM Planets 
		JOIN Probes 
		ON (Planets.Name=Probes.dest)
		WHERE NumMoons > 0;
	
# 8 ##################################	

		SELECT 	Probes.name
		FROM Planets 
		JOIN Probes 
		ON (Planets.Name=Probes.dest)
		WHERE Type = 'Rocky';
		
# 9 ##################################

		SELECT Probes.name
		FROM Probes 
		WHERE dest IN (SELECT Planets.Name 
						FROM Planets
						WHERE LengthOfYear <= ALL(SELECT LengthOfYear FROM Planets));	
			
			
# 10 ##################################

		SELECT Name
		FROM Planets
		WHERE LengthOfYear = (SELECT MAX(LengthOfYear) FROM Planets);


# 11 ##################################

		SELECT Name 
		FROM Planets 
		WHERE Type = 'Gas';


# 12 ##################################	

		SELECT Name 
		FROM Planets 
		WHERE NumMoons > 0;
		
# 13 ##################################
		
		SELECT Planets.Name,Probes.name
		From Planets
		LEFT JOIN Probes
		ON (Planets.Name=Probes.dest);
		
		
		
		
		
		
		
		