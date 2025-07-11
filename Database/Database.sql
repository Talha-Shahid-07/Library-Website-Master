CREATE TABLE CategoryTable
(
    CategoryID INT PRIMARY KEY,
    CategoryDescription VARCHAR(20)
);

CREATE TABLE UsersTable
(
    Username VARCHAR(20) PRIMARY KEY,
    Password VARCHAR(100) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    Surname VARCHAR(20) NOT NULL,
    AddressLine1 VARCHAR(50) NOT NULL,
    AddressLine2 VARCHAR(50) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Telephone VARCHAR(20) NOT NULL,
    Mobile VARCHAR(20) NOT NULL,
    
    CONSTRAINT Users_Telephone_Num_chk CHECK (Telephone REGEXP '^[0-9]+$'),
    CONSTRAINT Users_Telephone_Len_chk CHECK (LENGTH(Telephone) >= 7),
    CONSTRAINT Users_Mobile_Num_chk CHECK (Mobile REGEXP '^[0-9]+$'),
    CONSTRAINT Users_Mobile_Len_chk CHECK (LENGTH(Mobile) >= 7)
);

CREATE TABLE BookTable
(
    ISBN VARCHAR(20) PRIMARY KEY,
    BookTitle VARCHAR(50) NOT NULL,
    Author VARCHAR(40) NOT NULL,
    Edition INT,
    Year INT,
    Category INT,
    Reserved BOOLEAN,
    
    FOREIGN KEY (Category) REFERENCES CategoryTable(CategoryID)
);

CREATE TABLE BookReserve
(
    ISBN VARCHAR(20),
    Username VARCHAR(20),
    ReservedDate DATE,
    
    PRIMARY KEY (ISBN, Username),
    FOREIGN KEY (ISBN) REFERENCES BookTable(ISBN),
    FOREIGN KEY (Username) REFERENCES UsersTable(Username)
);

/* Category Table Details */
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (1, 'Health');
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (2, 'Business');
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (3, 'Biography');
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (4, 'Technology');
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (5, 'Travel');
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (6, 'Self-Help');
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (7, 'Cookery');
INSERT INTO CategoryTable (CategoryID, CategoryDescription) VALUES (8, 'Fiction');

/* UsersTable Details */
INSERT INTO UsersTable (Username, Password, FirstName, Surname, AddressLine1, AddressLine2, City, Telephone, Mobile)
VALUES ('alanjmckenna', 't1234s', 'Alan', 'McKenna', '38 Carnley Road', 'Fairview', 'Dublin', '0009998377', '00856625567');
INSERT INTO UsersTable (Username, Password, FirstName, Surname, AddressLine1, AddressLine2, City, Telephone, Mobile)
VALUES ('joecrotty', 'kj7899', 'Joseph', 'Crotty', 'Apt 5 Clyde Road', 'Donnybrook', 'Dublin', '0008887889', '08767338782');
INSERT INTO UsersTable (Username, Password, FirstName, Surname, AddressLine1, AddressLine2, City, Telephone, Mobile)
VALUES ('tommy100', '123456', 'Tom', 'Behan', '14 Hyde Road', 'Dalkey', 'Dublin', '0009983747', '08767387820');

/* Book Table Details */
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('093-403992', 'Computers in Business', 'Alicia Oneill', 3, 1997, 2, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('23472-8792', 'Exploring Peru', 'Stephanie Birchi', 4, 2005, 5, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('237-34823', 'Business Strategy', 'Joe Peppard', 2, 2002, 2, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('23u8-923849', 'A Guide to Nutrition', 'John Thorpe', 2, 1997, 1, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('2983-3494', 'Cooking For Children', 'Anabelle Sharper', 1, 2003, 7, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('82n8-308', 'Computers for Idiots', 'Susan Oneill', 5, 1998, 4, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('9823-23984', 'My Life in Picture', 'Kevin Graham', 8, 2004, 1, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('9823-2403-0', 'DaVinci Code', 'Dan Brown', 1, 2003, 8, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('98234-029384', 'My Ranch in Texas', 'George Bush', 1, 2005, 1, 1);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('9823-98345', 'How to Cook Italian Food', 'Jamie Oliver', 2, 2005, 7, 1);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('9823-98487', 'Optimising Your Business', 'Cleo Blair', 1, 2001, 2, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('988745-234', 'Tara Road', 'Maeve Binchy', 4, 2002, 8, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('993-004-00', 'My Life in Bits', 'John Smith', 1, 2001, 1, 0);
INSERT INTO BookTable (ISBN, BookTitle, Author, Edition, Year, Category, Reserved)
VALUES ('9987-0039882', 'Shooting History', 'Jon Snow', 1, 2003, 1, 0);

/* Reserved Books Table Details */
INSERT INTO BookReserve (ISBN, Username, ReservedDate)
VALUES ('98234-029384', 'joecrotty', '2008-10-11');
INSERT INTO BookReserve (ISBN, Username, ReservedDate)
VALUES ('9823-98345', 'tommy100', '2008-10-11');

/* 1. Create indexes for faster queries */
CREATE INDEX idx_booktitle ON BookTable(BookTitle);
CREATE INDEX idx_author ON BookTable(Author);
CREATE INDEX idx_category ON BookTable(Category);
CREATE INDEX idx_reserved ON BookTable(Reserved);

/* 2. Create a view for easier book search with category name */
CREATE VIEW BookWithCategory AS
SELECT 
    b.ISBN,
    b.BookTitle,
    b.Author,
    b.Edition,
    b.Year,
    c.CategoryDescription,
    b.Reserved
FROM BookTable b
JOIN CategoryTable c ON b.Category = c.CategoryID;

/* 3. Create a stored procedure for searching books */
DELIMITER //
CREATE PROCEDURE SearchBooks(
    IN p_title VARCHAR(50),
    IN p_author VARCHAR(40),
    IN p_category INT
)
BEGIN
    SELECT b.*, c.CategoryDescription
    FROM BookTable b
    JOIN CategoryTable c ON b.Category = c.CategoryID
    WHERE (p_title IS NULL OR LOWER(b.BookTitle) = LOWER(p_title))
      AND (p_author IS NULL OR LOWER(b.Author) = LOWER(p_author))
      AND (p_category IS NULL OR b.Category = p_category);
END;
DELIMITER ;