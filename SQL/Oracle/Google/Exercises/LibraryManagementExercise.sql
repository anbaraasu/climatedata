-- Schema for Library Management System (Books, Members, Authors, Borrowing, Staff)

-- 1. Authors Table
-- Stores information about the authors of the books.
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    nationality VARCHAR2(50)
);

-- 2. Books Table
-- Stores information about the books available in the library.
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR2(100),
    author_id INT,
    genre VARCHAR2(50),
    publication_year INT,
    copies_available INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- 3. Members Table
-- Stores information about the library members.
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    date_of_birth DATE,
    email VARCHAR2(100),
    phone_number VARCHAR2(15),
    address VARCHAR2(255),
    membership_date DATE
);

-- 4. Borrowing Table
-- Stores information about book borrowings by members.
CREATE TABLE borrowing (
    borrowing_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    status VARCHAR2(20), -- For example, 'Borrowed', 'Returned', 'Overdue'
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- 5. Staff Table
-- Stores information about the library staff.
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    phone_number VARCHAR2(15),
    role VARCHAR2(50)
);

-- Insert data into Authors Table
INSERT INTO authors (author_id, first_name, last_name, nationality) VALUES
(1, 'Harper', 'Lee', 'American'),
(2, 'George', 'Orwell', 'British'),
(3, 'Herman', 'Melville', 'American'),
(4, 'Jane', 'Austen', 'British'),
(5, 'F. Scott', 'Fitzgerald', 'American');

-- Insert data into Books Table
INSERT INTO books (book_id, title, author_id, genre, publication_year, copies_available) VALUES
(1, 'To Kill a Mockingbird', 1, 'Fiction', 1960, 5),
(2, '1984', 2, 'Dystopian', 1949, 3),
(3, 'Moby Dick', 3, 'Adventure', 1851, 4),
(4, 'Pride and Prejudice', 4, 'Romance', 1813, 6),
(5, 'The Great Gatsby', 5, 'Fiction', 1925, 2);

-- Insert data into Members Table
INSERT INTO members (member_id, first_name, last_name, date_of_birth, email, phone_number, address, membership_date) VALUES
(1, 'Alice', 'Brown', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'alice.brown@example.com', '1234567890', '123 Elm St, Springfield', TO_DATE('2023-01-01', 'YYYY-MM-DD')),
(2, 'Bob', 'Smith', TO_DATE('1985-08-20', 'YYYY-MM-DD'), 'bob.smith@example.com', '2345678901', '456 Oak St, Springfield', TO_DATE('2023-01-01', 'YYYY-MM-DD')),
(3, 'Charlie', 'Johnson', TO_DATE('1995-02-10', 'YYYY-MM-DD'), 'charlie.johnson@example.com', '3456789012', '789 Pine St, Springfield', TO_DATE('2023-01-01', 'YYYY-MM-DD'));

-- Insert data into Borrowing Table
INSERT INTO borrowing (borrowing_id, member_id, book_id, borrow_date, return_date, status) VALUES
(1, 1, 1, TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Returned'),
(2, 2, 2, TO_DATE('2023-03-05', 'YYYY-MM-DD'), NULL, 'Borrowed'),
(3, 3, 3, TO_DATE('2023-03-10', 'YYYY-MM-DD'), NULL, 'Overdue');

-- Insert data into Staff Table
INSERT INTO staff (staff_id, first_name, last_name, email, phone_number, role) VALUES
(1, 'David', 'Wilson', 'david.wilson@library.com', '9876543210', 'Librarian'),
(2, 'Emma', 'Taylor', 'emma.taylor@library.com', '8765432109', 'Assistant Librarian');

-- Day 2 Exercises
-- 1. Update the status of a borrowing record when a book is returned.
-- 2. Increase the number of copies available for a book by 2.
-- 3. Select members whose first name is longer than 4 characters.
-- 4. Find staff whose email address contains "library" (case-insensitive).
-- 5. Find staff who fourth letter is a,e,i,o or u.

-- Day 3 Exercises
-- 1. Find the maximum and minimum publication year for each genre.
-- 2. Calculate the total number of members and their average age for each membership year.
-- 3. Retrieve books borrowed by more than 2 members and order the results by borrow count in descending order.
-- 4. Retrieve staff members who have processed more than 5 borrowings and order them by the number of borrowings in descending order.
-- 5. Calculate the average age of members who borrowed books in each year, ordered by borrow year.

-- Day 4 Execises
-- 1. Find all members who borrowed books written by authors of the same nationality.
-- 2. Find all books that have not been borrowed by any member.
-- 3. Find all staff members who have not processed any borrowings.
-- 4. Find all books that have been authored but have no copies available.
-- 5. Find members who share the same address.

