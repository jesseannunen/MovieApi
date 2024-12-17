-- Active: 1730718376459@@127.0.0.1@5432@postgres@public

CREATE TABLE Genre (
    GenreID SERIAL PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);

CREATE TABLE Movie (
    MovieID SERIAL PRIMARY KEY,
    GenreID INT REFERENCES Genre(GenreID),
    MovieName VARCHAR(100) NOT NULL,
    MovieYear INT NOT NULL
);



CREATE Table Users (
    UserID SERIAL PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    UserPassword VARCHAR(255) NOT NULL,
    BirthYear INT NOT NULL
);

ALTER TABLE Users
ADD CONSTRAINT unique_user_name UNIQUE (UserName);


CREATE TABLE Review (
    ReviewID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Stars INT NOT NULL CHECK (Stars >= 1 AND Stars <= 5),
    ReviewText TEXT,
    MovieID INT NOT NULL,
    FOREIGN KEY (UserName) REFERENCES Users(UserName),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

CREATE TABLE Favorite (
    FavoriteID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    MovieID INT NOT NULL,
    FOREIGN KEY (UserName) REFERENCES Users(UserName),
    Foreign Key (MovieID) REFERENCES Movie(MovieID)
);


CREATE TABLE table_name(  
    id int NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    create_time DATE,
    name VARCHAR(255)
);
COMMENT ON TABLE table_name IS '';
COMMENT ON COLUMN table_name.name IS '';