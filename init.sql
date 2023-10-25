CREATE TABLE IF NOT EXISTS ISBNs(
    ISBN_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Value VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Books (
    Book_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    ISBN_ID INT,
    FOREIGN KEY (ISBN_ID) REFERENCES ISBNs(ISBN_ID),
    Year INT NOT NULL,
    Available INT NOT NULL,
    Total INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Genres (
    Genre_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Customers (
    Customer_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    RegisteredDate DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders (
    Order_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    OrderDate DATE NOT NULL,
    Customer_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    ReturnDate DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Authors (
    Author_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Birthday DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Nationalities (
    Nationality_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Authors_Nationalities(
    Author_ID INT,
    Nationality_ID INT,
    PRIMARY KEY (Author_ID, Nationality_ID),
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID),
    FOREIGN KEY (Nationality_ID) REFERENCES Nationalities(Nationality_ID)
);

CREATE TABLE IF NOT EXISTS Authors_Books(
    Author_ID INT,
    Book_ID INT,
    PRIMARY KEY (Author_ID, Book_ID),
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

CREATE TABLE IF NOT EXISTS Orders_Books(
    Order_ID INT,
    Book_ID INT,
    PRIMARY KEY (Order_ID, Book_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

CREATE TABLE IF NOT EXISTS Genres_Books(
    Genre_ID INT,
    Book_ID INT,
    PRIMARY KEY (Genre_ID, Book_ID),
    FOREIGN KEY (Genre_ID) REFERENCES Genres(Genre_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

INSERT INTO ISBNs (Value) VALUES
    ('9087654321'),
    ('9087654320'),
    ('123456789');

INSERT INTO Books (Title, ISBN_ID, Year, Available, Total) VALUES
    ('Libro 1', 1, 2022, 5, 10),
    ('Libro 2', 2, 2022, 3, 14),
    ('Libro 3', 3, 2023, 10, 14);

INSERT INTO Genres (Name) VALUES
    ('Terror'),
    ('Ciencia Ficción'),
    ('Drama');

INSERT INTO Customers (FirstName, LastName, Email, RegisteredDate) VALUES
    ('Alan', 'Olvera', 'noe.olvera.ramos@gmail.com', '2023-10-05'),
    ('Joan', 'Sebastian', 'joan.sebastian@gmail.com', '2023-09-01'),
    ('Miguel', 'Hidalgo', 'miguel.hidalgo@gmail.com', '2023-09-15');

INSERT INTO Authors (FirstName, LastName, Birthday) VALUES
    ('Stephen', 'King', '1960-01-01'),
    ('Carlos', 'Trejo', '1968-10-01'),
    ('Stephen', 'Hawking', '1962-04-11');

INSERT INTO Nationalities (Name) VALUES
    ('Mexicano'),
    ('Inglés'),
    ('Estadounidense');

INSERT INTO Authors_Books (Author_ID, Book_ID) VALUES (1, 1), (1, 2), (2, 3);

DELIMITER //
CREATE PROCEDURE GetBooksByAuthor(IN authorFirstName VARCHAR(100), IN authorLastName VARCHAR(100))
BEGIN
    SELECT Books.Book_ID, Books.Title, Books.Year
    FROM Books
    INNER JOIN Authors_Books ON Books.Book_ID = Authors_Books.Book_ID
    INNER JOIN Authors ON Authors_Books.Author_ID = Authors.Author_ID
    WHERE LOWER(Authors.FirstName) = LOWER(authorFirstName) AND LOWER(Authors.LastName) = LOWER(authorLastName);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAllBooks()
BEGIN
    SELECT Books.Book_ID, Books.Title, Books.Year
    FROM Books;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAllAuthors()
BEGIN
    SELECT Authors.Author_ID, Authors.FirstName, Authors.LastName
    FROM Authors;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAuthorsByNameOrLastName(IN search VARCHAR(100))
BEGIN
    SELECT Authors.Author_ID, Authors.FirstName, Authors.LastName
    FROM Authors
    WHERE LOWER(Authors.FirstName) = LOWER(search) OR LOWER(Authors.LastName) = LOWER(search);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetAuthorsBySearch(IN search VARCHAR(100))
BEGIN
    SET @query = CONCAT(
        'SELECT * FROM Authors WHERE LOWER(Authors.FirstName) LIKE LOWER(''%',
        search, '%'') OR LOWER(Authors.LastName) LIKE LOWER(''%', search, '%'')');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetBooksByAuthorSearch(IN search VARCHAR(100))
BEGIN
    SET @query = CONCAT(
        'SELECT Books.Book_ID, Books.Title, Books.Year FROM Books INNER JOIN Authors_Books ON Books.Book_ID = Authors_Books.Book_ID INNER JOIN Authors ON Authors_Books.Author_ID = Authors.Author_ID WHERE LOWER(Authors.FirstName) LIKE LOWER(''%',
        search, '%'') OR LOWER(Authors.LastName) LIKE LOWER(''%', search, '%'')');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAuthorWithBooks(IN authorFirstName VARCHAR(100), IN authorLastName VARCHAR(100))
BEGIN
    SELECT a.Author_ID, a.FirstName, a.LastName, b.Book_ID, b.Title, b.Year
    FROM Authors a
    LEFT JOIN Authors_Books ab ON a.Author_ID = ab.Author_ID
    LEFT JOIN Books b ON ab.Book_ID = b.Book_ID
    WHERE a.FirstName = authorFirstName AND a.LastName = authorLastName;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetAllCustomers()
BEGIN
    SELECT *
    FROM Customers;
END //
DELIMITER ;