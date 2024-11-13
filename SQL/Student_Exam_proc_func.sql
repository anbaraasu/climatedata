-- Creating table for Students
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    registration_date DATE
);

-- Inserting sample data into Students
INSERT INTO Students (student_id, name, email, registration_date) VALUES (1, 'Alice Johnson', 'alice.johnson@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (2, 'Bob Brown', 'bob.brown@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (3, 'Charlie Davis', 'charlie.davis@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (4, 'Diana Evans', 'diana.evans@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (5, 'Evan Foster', 'evan.foster@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (6, 'Fiona Green', 'fiona.green@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (7, 'George Harris', 'george.harris@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (8, 'Hannah Irving', 'hannah.irving@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (9, 'Ian Johnson', 'ian.johnson@example.com', SYSDATE);
INSERT INTO Students (student_id, name, email, registration_date) VALUES (10, 'Jane King', 'jane.king@example.com', SYSDATE);

-- Creating table for Exams
CREATE TABLE Exams (
    exam_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    subject VARCHAR2(100) NOT NULL,
    exam_date DATE,
    score NUMBER,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Inserting sample data into Exams
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (1, 1, 'Mathematics', SYSDATE - 30, 85);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (2, 2, 'Science', SYSDATE - 28, 90);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (3, 3, 'History', SYSDATE - 25, 78);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (4, 4, 'Mathematics', SYSDATE - 20, 88);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (5, 5, 'Science', SYSDATE - 18, 92);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (6, 6, 'History', SYSDATE - 15, 80);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (7, 7, 'Mathematics', SYSDATE - 10, 87);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (8, 8, 'Science', SYSDATE - 8, 89);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (9, 9, 'History', SYSDATE - 5, 76);
INSERT INTO Exams (exam_id, student_id, subject, exam_date, score) VALUES (10, 10, 'Mathematics', SYSDATE - 2, 91);

-- Creating a PL/SQL function to find the grade level for each student
CREATE OR REPLACE FUNCTION find_grade_level(p_avg_score INT) RETURN VARCHAR2 IS
    grade_level VARCHAR2(2);
BEGIN
    
    -- Determine the grade level based on the average score
    IF p_avg_score >= 90 THEN
        grade_level := 'A';
    ELSIF p_avg_score >= 80 THEN
        grade_level := 'B';
    ELSIF p_avg_score >= 70 THEN
        grade_level := 'C';
    ELSIF p_avg_score >= 60 THEN
        grade_level := 'D';
    ELSE
        grade_level := 'F';
    END IF;

    -- Return the grade level
    RETURN grade_level;
END find_grade_level;
/


CREATE OR REPLACE FUNCTION find_rank(p_subject VARCHAR2, p_student_id INT) 
RETURN INT AS
    l_rank INT;
BEGIN
	SELECT RANK () OVER (PARTITION BY subject ORDER BY score DESC) INTO l_rank
	FROM exams WHERE subject = p_subject and student_id = p_student_id
    order by subject, score desc;
	RETURN l_rank;
END find_rank;
/
    
-- find the subject wise rank
CREATE OR REPLACE PROCEDURE display_subject_rank(p_student_id INT) AS 
	l_rank INT;
	l_subject exams.subject%TYPE;
	l_student_name students.name%TYPE;
	CURSOR stu_cur(c_student_id INT) IS 
    SELECT subject, name, find_rank(subject, s.student_id) rank
    INTO l_subject, l_student_name, l_rank 
    FROM students s
	JOIN exams E ON s.student_id = e.student_id 
    WHERE s.student_id = c_student_id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Student Name' || CHR(9) || 'Subject' || CHR(9) || 'Rank');
    FOR stu IN stu_cur(p_student_id) LOOP
        DBMS_OUTPUT.PUT_LINE(stu.name || CHR(9) || stu.subject || CHR(9) || stu.rank);
	END LOOP;
END display_subject_rank;
/

EXEC display_subject_rank(3);

