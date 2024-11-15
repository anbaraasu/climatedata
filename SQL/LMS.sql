/*
*	Library Database management System
*   Squad: Wonderful Libra
*   Member(s): Anbu
*   Nomalization: 3NF
*/
-- Creating table for Librarians
-- Developed
CREATE TABLE Librarians (
    librarian_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    password VARCHAR2(100) NOT NULL
);

-- Inserting sample data into Librarians
INSERT INTO Librarians (librarian_id, name, password) VALUES (1, 'John Doe', 'password123');
INSERT INTO Librarians (librarian_id, name, password) VALUES (2, 'Jane Smith', 'password456');
COMMIT;

-- Creating table for Students
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    registration_date DATE,
    approved_by NUMBER,
    FOREIGN KEY (approved_by) REFERENCES Librarians(librarian_id)
);

-- Inserting sample data into Students
INSERT INTO Students (student_id, name, email, registration_date, approved_by) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', SYSDATE, 1);
INSERT INTO Students (student_id, name, email, registration_date, approved_by) VALUES
(2, 'Bob Brown', 'bob.brown@example.com', SYSDATE, 2);
COMMIT;

-- Creating table for Books
CREATE TABLE Books (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    author VARCHAR2(255) NOT NULL,
    genre VARCHAR2(100),
    published_date DATE,
    available_copies NUMBER
);

-- Inserting sample data into Books
-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', TO_DATE('1925-04-10', 'YYYY-MM-DD'), 5);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', TO_DATE('1960-07-11', 'YYYY-MM-DD'), 3);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(3, '1984', 'George Orwell', 'Dystopian', TO_DATE('1949-06-08', 'YYYY-MM-DD'), 4);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance', TO_DATE('1813-01-28', 'YYYY-MM-DD'), 6);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', TO_DATE('1951-07-16', 'YYYY-MM-DD'), 2);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(6, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', TO_DATE('1937-09-21', 'YYYY-MM-DD'), 7);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(7, 'Moby-Dick', 'Herman Melville', 'Adventure', TO_DATE('1851-10-18', 'YYYY-MM-DD'), 3);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(8, 'War and Peace', 'Leo Tolstoy', 'Historical', TO_DATE('1869-01-01', 'YYYY-MM-DD'), 4);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(9, 'The Odyssey', 'Homer', 'Epic', TO_DATE('800-01-01', 'YYYY-MM-DD'), 5);

-- Inserting sample data into Books
INSERT INTO Books (book_id, title, author, genre, published_date, available_copies) VALUES
(10, 'The Divine Comedy', 'Dante Alighieri', 'Epic', TO_DATE('1320-01-01', 'YYYY-MM-DD'), 2);
COMMIT;

-- Creating table for Book Issues
CREATE TABLE BookIssues (
    issue_id NUMBER PRIMARY KEY,
    book_id NUMBER,
    student_id NUMBER,
    issue_date DATE,
    return_date DATE,
    late_fee NUMBER,
    issued_by NUMBER,
    FOREIGN KEY (issued_by) REFERENCES Librarians(librarian_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)    
);

-- Inserting sample data into Book Issues
INSERT INTO BookIssues (issue_id, book_id, student_id, issue_date, return_date, late_fee,issued_by) VALUES
(1, 1, 1, SYSDATE - 10, SYSDATE - 5, 0,1);
INSERT INTO BookIssues (issue_id, book_id, student_id, issue_date, return_date, late_fee,issued_by) VALUES
(2, 2, 2, SYSDATE - 20, SYSDATE - 15, 0,2);
INSERT INTO BookIssues (issue_id, book_id, student_id, issue_date, return_date, late_fee,issued_by) VALUES
(3, 3, 1, SYSDATE - 20, NULL, NULL,2);
COMMIT;

-- Creating view for book issue history
CREATE OR REPLACE VIEW BookIssueHistory AS
-- Selecting issue details, book title, student name, issue date, number of days, return date, and late fee
SELECT 
    bi.issue_id,
    b.title AS book_title,
    s.name AS student_name,
    bi.issue_date,
    bi.return_date,
    -- Calculating the number of days the book has been issued
    CASE 
        WHEN bi.return_date IS NOT NULL THEN TRUNC(bi.return_date - bi.issue_date) 
        ELSE TRUNC(SYSDATE - bi.issue_date) 
    END AS num_of_days,
    
    bi.late_fee
FROM 
    BookIssues bi
-- Joining with Books table to get book details
JOIN 
    Books b ON bi.book_id = b.book_id
-- Joining with Students table to get student details
JOIN 
    Students s ON bi.student_id = s.student_id;
--SELECT * FROM BookIssueHistory ;

-- Calculation: books - # of days holding by the student, calc of late fee, number of books avaiable..

-- PLSQL function to calc late fee - if more than 1 week and less than 2 week - fee is Rs. 10
--- if more than 2 week and less than 3 week - fee is Rs. 15
-- greater than 3 weeks - for each day Re 1 is fine amount.

-- Creating a PL/SQL function to calculate late fee
CREATE OR REPLACE FUNCTION calculate_late_fee(issue_date DATE, return_date DATE) RETURN NUMBER IS
    late_fee NUMBER := 0;
    num_of_days NUMBER;
BEGIN
    -- Calculate the number of days the book has been issued
    num_of_days := TRUNC(return_date - issue_date);

    -- Calculate late fee based on the number of days
    IF num_of_days > 7 AND num_of_days <= 14 THEN
        late_fee := 10;
    ELSIF num_of_days > 14 AND num_of_days <= 21 THEN
        late_fee := 15;
    ELSIF num_of_days > 21 THEN
        late_fee := 15 + (num_of_days - 21);
    END IF;

    -- Return the calculated late fee
    RETURN late_fee;
END calculate_late_fee;
/

SELECT 
    bi.issue_id,
    b.title AS book_title,
    s.name AS student_name,
    bi.issue_date,
    bi.return_date,
    -- Calculating the number of days the book has been issued
    CASE 
        WHEN bi.return_date IS NOT NULL THEN TRUNC(bi.return_date - bi.issue_date) 
        ELSE TRUNC(SYSDATE - bi.issue_date) 
    END AS num_of_days,
    calculate_late_fee(bi.issue_date, CASE WHEN bi.return_date IS NOT NULL THEN bi.return_date ELSE SYSDATE END) late_fee
FROM 
    BookIssues bi
-- Joining with Books table to get book details
JOIN 
    Books b ON bi.book_id = b.book_id
-- Joining with Students table to get student details
JOIN 
    Students s ON bi.student_id = s.student_id;


CREATE OR REPLACE PACKAGE BOOK_PKG AS
	UNIVERSITY_NAME CHAR(3) := 'SSU';
	FUNCTION calculate_late_fee(issue_date DATE, return_date DATE) RETURN NUMBER;
	PROCEDURE issue_book(p_name VARCHAR2, p_student_id NUMBER, p_issued_by NUMBER);
END BOOK_PKG;
