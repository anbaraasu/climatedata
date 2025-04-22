Schema for Academy Management System (Student, Faculty, Courses)
1. Students Table
Stores information about the students enrolled in the academy.
sql
CopyEdit
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    date_of_birth DATE,
    email VARCHAR2(100),
    phone_number VARCHAR2(15),
    address VARCHAR2(255),
    enrollment_date DATE
);
2. Faculty Table
Stores information about the faculty members.
sql
CopyEdit
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    phone_number VARCHAR2(15),
    department VARCHAR2(50)
);
3. Courses Table
Stores information about the courses offered in the academy.
sql
CopyEdit
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR2(100),
    course_description VARCHAR2(255),
    course_duration INT,  -- Duration in weeks
    course_fee DECIMAL(10, 2)
);
4. Enrollments Table
Stores information about student enrollments in courses.
sql
CopyEdit
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    status VARCHAR2(20),  -- For example, 'Active', 'Completed', 'Dropped'
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
5. Course_Assignment Table
Stores information about which faculty teaches which course.
sql
CopyEdit
CREATE TABLE course_assignment (
    assignment_id INT PRIMARY KEY,
    faculty_id INT,
    course_id INT,
    semester VARCHAR2(10),  -- For example, 'Spring 2025'
    year INT,
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert data into Students Table
INSERT INTO students (student_id, first_name, last_name, date_of_birth, email, phone_number, address, enrollment_date) VALUES
(1, 'John', 'Doe', TO_DATE('2000-05-15', 'YYYY-MM-DD'), 'john.doe@example.com', '1234567890', '1234 Elm St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(2, 'Jane', 'Smith', TO_DATE('2001-08-20', 'YYYY-MM-DD'), 'jane.smith@example.com', '2345678901', '5678 Oak St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(3, 'Michael', 'Brown', TO_DATE('1999-02-10', 'YYYY-MM-DD'), 'michael.brown@example.com', '3456789012', '9101 Pine St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(4, 'Sarah', 'Taylor', TO_DATE('2002-07-22', 'YYYY-MM-DD'), 'sarah.taylor@example.com', '4567890123', '2345 Birch St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(5, 'William', 'Lee', TO_DATE('2000-03-14', 'YYYY-MM-DD'), 'william.lee@example.com', '5678901234', '6789 Maple St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(6, 'Olivia', 'Davis', TO_DATE('2001-12-05', 'YYYY-MM-DD'), 'olivia.davis@example.com', '6789012345', '1234 Elm St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(7, 'Daniel', 'Clark', TO_DATE('2000-09-17', 'YYYY-MM-DD'), 'daniel.clark@example.com', '7890123456', '4321 Cedar St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD'));

-- Additional data for Students Table
INSERT INTO students (student_id, first_name, last_name, date_of_birth, email, phone_number, address, enrollment_date) VALUES
(8, 'Sophia', 'Miller', TO_DATE('2001-11-11', 'YYYY-MM-DD'), 'sophia.miller@example.com', '8901234567', '5678 Oak St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(9, 'James', 'Anderson', TO_DATE('2000-06-25', 'YYYY-MM-DD'), 'james.anderson@example.com', '9012345678', '9101 Pine St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD')),
(10, 'Emily', 'Harris', TO_DATE('2002-03-30', 'YYYY-MM-DD'), 'emily.harris@example.com', '1230984567', '6789 Maple St, Springfield', TO_DATE('2024-09-01', 'YYYY-MM-DD'));

-- Insert data into Faculty Table
INSERT INTO faculty (faculty_id, first_name, last_name, email, phone_number, department) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@academy.com', '9876543210', 'Computer Science'),
(2, 'Bob', 'Williams', 'bob.williams@academy.com', '8765432109', 'Mathematics'),
(3, 'Carol', 'Martinez', 'carol.martinez@academy.com', '7654321098', 'Physics'),
(4, 'David', 'Wilson', 'david.wilson@academy.com', '6543210987', 'Chemistry'),
(5, 'Emma', 'Scott', 'emma.scott@academy.com', '5432109876', 'English'),
(6, 'Frank', 'Moore', 'frank.moore@academy.com', '4321098765', 'History'),
(7, 'Grace', 'Taylor', 'grace.taylor@academy.com', '3210987654', 'Philosophy');

-- Additional data for Faculty Table
INSERT INTO faculty (faculty_id, first_name, last_name, email, phone_number, department) VALUES
(8, 'Henry', 'Adams', 'henry.adams@academy.com', '2109876543', 'Computer Science'),
(9, 'Isabella', 'White', 'isabella.white@academy.com', '3218765432', 'Mathematics');

-- Insert data into Courses Table
INSERT INTO courses (course_id, course_name, course_description, course_duration, course_fee) VALUES
(101, 'Introduction to Programming', 'A beginner course in programming', 10, 500.00),
(102, 'Calculus I', 'A basic course in calculus', 12, 400.00),
(103, 'Physics 101', 'An introductory course in physics', 14, 600.00),
(104, 'Chemistry I', 'A basic course in chemistry', 12, 550.00),
(105, 'English Literature', 'An introduction to English literature', 8, 300.00),
(106, 'History of Civilization', 'A course on world history', 16, 450.00),
(107, 'Philosophy 101', 'An introductory course in philosophy', 10, 400.00);

-- Additional data for Courses Table
INSERT INTO courses (course_id, course_name, course_description, course_duration, course_fee) VALUES
(108, 'Advanced Programming', 'An advanced course in programming', 12, 700.00),
(109, 'Linear Algebra', 'A course on linear algebra', 10, 500.00);

-- Insert data into Enrollments Table
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, status) VALUES
(1, 1, 101, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(2, 2, 102, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(3, 3, 103, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(4, 4, 104, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(5, 5, 105, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(6, 6, 106, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(7, 7, 107, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active');

-- Additional data for Enrollments Table
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, status) VALUES
(8, 8, 101, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(9, 9, 102, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(10, 10, 103, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(11, 1, 108, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active'),
(12, 2, 109, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Active');

-- Insert data into Course_Assignment Table
INSERT INTO course_assignment (assignment_id, faculty_id, course_id, semester, year) VALUES
(1, 1, 101, 'Spring', 2025),
(2, 2, 102, 'Spring', 2025),
(3, 3, 103, 'Spring', 2025),
(4, 4, 104, 'Spring', 2025),
(5, 5, 105, 'Spring', 2025),
(6, 6, 106, 'Spring', 2025),
(7, 7, 107, 'Spring', 2025); 

-- Additional data for Course_Assignment Table
INSERT INTO course_assignment (assignment_id, faculty_id, course_id, semester, year) VALUES
(8, 8, 108, 'Spring', 2025),
(9, 9, 109, 'Spring', 2025),
(10, 1, 102, 'Fall', 2025);

Day 2: 
1.	If  student '1' completes a course 101, how to update their enrollment status:

2.	If the academy decides to extend the duration by 2 more hours of a 103 course, how to update the course duration like this:

3.	Select Students Whose First Name is Longer Than 4 Characters

4.	to find faculty whose email address contains "academy" (case-insensitive).

5. Find student whose last name second letter is either a, e, i, o or u.

Day 3:
1.	 Find the Maximum and Minimum Fee for Each Course Type

2.	calculates the total number of students and their average age for each enrollment year.

3.	retrieves courses with more than 10 students enrolled and orders the results by student count in descending order.

4.	retrieves faculty members who are teaching more than 5 courses and orders them by the number of courses in descending order.

5.	calculates the average age of students enrolled in each year, ordered by enrollment year.


Day 5 with self join, left join, right join, full outer join with 4 tables 
1.	Find all students who have enrolled in courses taught by faculty members from the same department.
<SQL Solution> 

2.	Find all courses that have no students enrolled in them.
<SQL Solution> 

3.	Find all faculty members who are not teaching any courses.
<SQL Solution>

4.	Find all courses that have been assigned to faculty members but have no students enrolled in them.
<SQL Solution>

5. Find students who share the same address
<SQL Solution>