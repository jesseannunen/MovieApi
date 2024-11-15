/* 2024-11-15 12:56:13 [34 ms] */ 
CREATE TABLE Genre (
    GenreID SERIAL PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);
/* 2024-11-15 13:02:08 [12 ms] */ 
CREATE TABLE Movie (
    MovieID SERIAL PRIMARY KEY,
    GenreID INT REFERENCES Genre(GenreID),
    MovieName VARCHAR(100) NOT NULL,
    MovieYear INT NOT NULL
);
/* 2024-11-15 13:10:47 [7 ms] */ 
CREATE Table Users (
    UserID SERIAL PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    UserPassword VARCHAR(255) NOT NULL,
    BirthYear INT NOT NULL
);
/* 2024-11-15 13:39:17 [6 ms] */ 
ALTER TABLE Users
ADD CONSTRAINT unique_user_name UNIQUE (UserName);
/* 2024-11-15 13:39:22 [10 ms] */ 
CREATE TABLE Review (
    ReviewID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Stars INT NOT NULL CHECK (Stars >= 1 AND Stars <= 5),
    ReviewText TEXT,
    MovieID INT NOT NULL,
    FOREIGN KEY (UserName) REFERENCES Users(UserName),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);
/* 2024-11-15 13:42:29 [6 ms] */ 
CREATE TABLE Favorite (
    FavoriteID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    MovieID INT NOT NULL,
    FOREIGN KEY (UserName) REFERENCES Users(UserName),
    Foreign Key (MovieID) REFERENCES Movie(MovieID)
);
/* 2024-11-15 13:48:22 [7 ms] */ 
INSERT INTO Genre (GenreName)  
VALUES ('drama'),('comedy'),('scifi'),('fantasy'),('action'),('triller');
/* 2024-11-15 14:00:58 [2 ms] */ 
SELECT genrename
from genre LIMIT 100;
/* 2024-11-15 14:14:54 [4 ms] */ 
SELECT GenreID, GenreName 
FROM Genre
WHERE GenreName IN ('Action', 'Drama', 'Sci-Fi', 'Comedy') LIMIT 100;
/* 2024-11-15 14:16:59 [5 ms] */ 
DELETE FROM Genre
WHERE GenreName IN ('Action', 'Drama', 'Sci-Fi', 'Comedy');
/* 2024-11-15 14:17:04 [1 ms] */ 
SELECT genrename
from genre LIMIT 100;
/* 2024-11-15 14:17:08 [2 ms] */ 
DELETE FROM Genre
WHERE GenreName IN ('Action', 'Drama', 'Sci-Fi', 'Comedy');
/* 2024-11-15 14:17:13 [2 ms] */ 
SELECT genrename
from genre LIMIT 100;
/* 2024-11-15 14:17:32 [3 ms] */ 
INSERT INTO Genre (GenreName)
VALUES 
('Action'), 
('Drama'), 
('Sci-Fi'), 
('Comedy')
RETURNING GenreID, GenreName;
/* 2024-11-15 14:19:48 [2 ms] */ 
SELECT GenreID, GenreName 
FROM Genre
WHERE GenreName IN ('Action', 'Drama', 'Sci-Fi', 'Comedy') LIMIT 100;
/* 2024-11-15 14:31:20 [5 ms] */ 
DELETE FROM Genre
WHERE GenreName IN ('Action', 'Drama', 'Sci-Fi', 'Comedy');
/* 2024-11-15 14:31:25 [1 ms] */ 
SELECT * FROM genre LIMIT 100;
/* 2024-11-15 14:31:41 [2 ms] */ 
SELECT GenreID, GenreName 
FROM Genre
WHERE GenreName IN ('Action', 'Drama', 'Sci-Fi', 'Comedy') LIMIT 100;
/* 2024-11-15 14:32:55 [5 ms] */ 
INSERT INTO Movie (MovieName, MovieYear, GenreID) 
VALUES 
('Inception', 2010, 5),
('The Terminator', 1984, 5),
('Tropic Thunder', 2008, 2),
('Borat', 2006, 2),
('Interstellar', 2014, 1),
('Joker', 2019, 1);
