-- Events table
CREATE TABLE events (
    event_id NUMBER PRIMARY KEY,
    event_name VARCHAR2(100) NOT NULL,
    event_date DATE NOT NULL,
    location VARCHAR2(100),
    description VARCHAR2(255)
);

-- Participants table
CREATE TABLE participants (
    participant_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone_number VARCHAR2(15),
    registration_date DATE
);

-- Speakers table
CREATE TABLE speakers (
    speaker_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    bio VARCHAR2(255),
    email VARCHAR2(100) UNIQUE NOT NULL
);

-- Sessions table
CREATE TABLE sessions (
    session_id NUMBER PRIMARY KEY,
    event_id NUMBER REFERENCES events(event_id),
    speaker_id NUMBER REFERENCES speakers(speaker_id),
    session_name VARCHAR2(100),
    session_start_time DATE,
    session_end_time DATE
);

-- Registrations table
CREATE TABLE registrations (
    registration_id NUMBER PRIMARY KEY,
    participant_id NUMBER REFERENCES participants(participant_id),
    session_id NUMBER REFERENCES sessions(session_id),
    registration_date DATE
);

-- DELTE CHILD THEN PARENT TABLES
DELETE FROM registrations;
DELETE FROM sessions;
DELETE FROM speakers;
DELETE FROM participants;
DELETE FROM events;

-- Insert Multiple Events
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES (1, 'Tech Conference 2025', '2025-05-15', 'San Francisco', 'Tech conference covering AI, ML, and Blockchain');
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES(2, 'Business Summit 2025', '2025-06-10', 'New York', 'A summit for entrepreneurs and business leaders');
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES(3, 'Digital Marketing Expo', '2025-07-05', 'Los Angeles', 'Event focusing on digital marketing trends and strategies');
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES(4, 'Cybersecurity Forum', '2025-08-20', 'Chicago', 'Forum on the latest cybersecurity threats and solutions');
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES(5, 'HealthTech Innovation Summit', '2025-09-25', 'Boston', 'Summit showcasing innovations in healthcare technology');
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES(6, 'AI for Good 2025', '2025-10-15', 'Seattle', 'Conference exploring AI applications for social impact');
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES(7, 'Blockchain Summit 2025', '2025-11-10', 'Austin', 'Summit on blockchain technologies and the future of cryptocurrencies');
INSERT INTO events (event_id, event_name, event_date, location, description) VALUES
(8, 'Startup Expo 2025', '2025-12-01', 'San Francisco', 'Expo for new startup ventures and entrepreneurial networking'),
(9, 'Marketing Strategies 2025', '2025-12-15', 'Miami', 'Event focusing on innovative marketing strategies and digital trends'),
(10, 'AI in Healthcare 2025', '2025-12-20', 'Denver', 'Conference on the impact of AI in healthcare and medical research');


-- Insert Participants
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '2025-01-10');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2025-01-12');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-234-6789', '2025-01-15');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(4, 'Bob', 'Williams', 'bob.williams@example.com', '555-789-1234', '2025-01-20');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(5, 'Charlie', 'Brown', 'charlie.brown@example.com', '555-456-7890', '2025-01-22');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(6, 'David', 'White', 'david.white@example.com', '123-987-6543', '2025-01-25');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(7, 'Emily', 'Green', 'emily.green@example.com', '234-567-8901', '2025-01-28');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(8, 'George', 'King', 'george.king@example.com', '987-321-6540', '2025-02-01');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(9, 'Lucas', 'Lee', 'lucas.lee@example.com', '112-345-6789', '2025-02-05');
INSERT INTO participants (participant_id, first_name, last_name, email, phone_number, registration_date) VALUES 
(10, 'Sophia', 'Martinez', 'sophia.martinez@example.com', '223-456-7890', '2025-02-08');



-- Insert Speakers
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES 
(1, 'Dr. Sarah', 'Lee', 'Expert in AI and Machine Learning', 'sarah.lee@tech.com');
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES
(2, 'Mark', 'Taylor', 'Business strategist with 20 years of experience', 'mark.taylor@biz.com');
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES
(3, 'Jessica', 'Adams', 'Digital marketing expert and consultant', 'jessica.adams@marketing.com');
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES
(4, 'James', 'King', 'Cybersecurity analyst with expertise in threat management', 'james.king@security.com');
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES
(5, 'Dr. Emily', 'Parker', 'Innovator in health technology and digital health solutions', 'emily.parker@healthtech.com');
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES
(6, 'Dr. Michael', 'Rodriguez', 'AI researcher with a focus on healthcare applications', 'michael.rodriguez@ai.com');
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES
(7, 'David', 'Brown', 'Blockchain expert with industry-leading insights', 'david.brown@blockchain.com');
INSERT INTO speakers (speaker_id, first_name, last_name, bio, email) VALUES
(8, 'Karen', 'Robinson', 'Cybersecurity solutions provider for tech enterprises', 'karen.robinson@security.com');


-- Insert Sessions
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES 
(1, 1, 1, 'AI in 2025', '2025-05-15 10:00:00', '2025-05-15 11:00:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(2, 1, 3, 'The Future of Digital Marketing','2025-05-15 11:30:00', '2025-05-15 12:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(3, 2, 2, 'Entrepreneurship in the 21st Century', '2025-06-10 09:00:00', '2025-06-10 10:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(4, 3, 3, 'Maximizing ROI through Digital Strategies', '2025-07-05 11:00:00', '2025-07-05 12:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(5, 4, 4, 'Securing the Digital Future', '2025-08-20 10:00:00', '2025-08-20 11:00:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(6, 5, 5, 'Innovating Healthcare through Technology', '2025-09-25 09:00:00', '2025-09-25 10:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(7, 6, 6, 'AI for Social Good','2025-10-15 11:00:00', '2025-10-15 12:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(8, 7, 7, 'Blockchain Revolution', '2025-11-10 09:00:00', '2025-11-10 10:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(9, 8, 2, 'Building the Startup Ecosystem', '2025-12-01 10:00:00', '2025-12-01 11:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(10, 8, 3, 'Marketing for Startups','2025-12-01 12:00:00', '2025-12-01 13:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(11, 9, 1, 'Digital Marketing Trends 2025', '2025-12-15 09:00:00', '2025-12-15 10:30:00');
INSERT INTO sessions (session_id, event_id, speaker_id, session_name, session_start_time, session_end_time) VALUES
(12, 10, 6, 'AI in Healthcare Innovations', '2025-12-20 11:00:00', '2025-12-20 12:30:00');



-- Insert Registrations
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(1, 1, 1, '2025-01-10');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(2, 1, 2, '2025-01-12');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(3, 1, 3, '2025-01-15');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(4, 2, 4, '2025-01-20');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(5, 2, 5, '2025-01-22');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(6, 3, 6, '2025-01-23');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(7, 4, 7, '2025-01-25');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(8, 5, 8, '2025-01-28');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(9, 6, 9, '2025-02-01');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(10, 7, 10, '2025-02-05');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(11, 8, 1, '2025-02-10');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(12, 9, 2, '2025-02-12');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(13, 9, 3, '2025-02-14');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(14, 10, 4, '2025-02-18');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(15, 10, 5, '2025-02-20');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(16, 10, 6, '2025-02-22');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(17, 10, 7, '2025-02-25');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(18, 10, 8, '2025-02-28');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(19, 10, 9, '2025-03-01');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(20, 10, 10, '2025-03-05');
INSERT INTO registrations (registration_id, participant_id, session_id, registration_date) VALUES 
(21, 10, 11, '2025-03-10');

-- Write a SQL query to display the participant names and the total number of events they attended. Only include participants who attended more than 2 events. Sort the result in ascending order of participant first name.
SELECT p.first_name || ' ' || p.last_name AS participant_name, COUNT(DISTINCT e.event_id) AS total_events
FROM participants p
JOIN registrations r ON p.participant_id = r.participant_id
JOIN sessions s ON r.session_id = s.session_id
JOIN events e ON s.event_id = e.event_id
GROUP BY p.participant_id, p.first_name, p.last_name
HAVING COUNT(DISTINCT e.event_id) > 2
ORDER BY p.first_name ASC;

/*
1. Write a SQL query to display the event names and the total number of participants registered for each event.
   Only include events with more than 5 participants. Sort the result in descending order of total participants.
*/
SELECT e.event_name, COUNT(DISTINCT r.participant_id) AS total_participants
FROM events e
JOIN sessions s ON e.event_id = s.event_id
JOIN registrations r ON s.session_id = r.session_id
GROUP BY e.event_name
HAVING COUNT(DISTINCT r.participant_id) > 5
ORDER BY total_participants DESC;

/*
2. Write a SQL query to display the speaker names and the total number of sessions they conducted.
   Only include speakers who conducted more than 1 session. Sort the result in ascending order of speaker last name.
*/
SELECT sp.first_name || ' ' || sp.last_name AS speaker_name, COUNT(s.session_id) AS total_sessions
FROM speakers sp
JOIN sessions s ON sp.speaker_id = s.speaker_id
GROUP BY sp.speaker_id, sp.first_name, sp.last_name
HAVING COUNT(s.session_id) > 1
ORDER BY sp.last_name ASC;

/*
3. Write a SQL query to display the session names and the total number of participants registered for each session.
   Only include sessions with more than 3 participants. Sort the result in descending order of total participants.
*/
SELECT s.session_name, COUNT(r.participant_id) AS total_participants
FROM sessions s
JOIN registrations r ON s.session_id = r.session_id
GROUP BY s.session_id, s.session_name
HAVING COUNT(r.participant_id) > 3
ORDER BY total_participants DESC;

/*
4. Write a SQL query to display the participant names and the total number of sessions they registered for.
   Only include participants who registered for more than 2 sessions. Sort the result in ascending order of participant last name.
*/
SELECT p.first_name || ' ' || p.last_name AS participant_name, COUNT(r.session_id) AS total_sessions
FROM participants p
JOIN registrations r ON p.participant_id = r.participant_id
GROUP BY p.participant_id, p.first_name, p.last_name
HAVING COUNT(r.session_id) > 2
ORDER BY p.last_name ASC;

/*
5. Write a SQL query to display the event names and the average number of participants per session for each event.
   Sort the result in descending order of the average number of participants.
*/
SELECT e.event_name, AVG(session_participants) AS avg_participants_per_session
FROM (
    SELECT s.event_id, COUNT(r.participant_id) AS session_participants
    FROM sessions s
    LEFT JOIN registrations r ON s.session_id = r.session_id
    GROUP BY s.session_id
) sub
JOIN events e ON sub.event_id = e.event_id
GROUP BY e.event_name
ORDER BY avg_participants_per_session DESC;

/*
6. Write a SQL query to display the participant names and the total number of events they attended.
   Only include participants who attended more than 1 event. Sort the result in ascending order of participant first name.
*/
SELECT p.first_name || ' ' || p.last_name AS participant_name, COUNT(DISTINCT e.event_id) AS total_events
FROM participants p
JOIN registrations r ON p.participant_id = r.participant_id
JOIN sessions s ON r.session_id = s.session_id
JOIN events e ON s.event_id = e.event_id
GROUP BY p.participant_id, p.first_name, p.last_name
HAVING COUNT(DISTINCT e.event_id) > 1
ORDER BY p.first_name ASC;

/*
7. Write a SQL query to display the event names and the total duration of all sessions for each event (in hours).
   Sort the result in descending order of total duration.
*/
SELECT e.event_name, SUM((julianday(s.session_end_time) - julianday(s.session_start_time)) * 24) AS total_duration_hours
FROM events e
JOIN sessions s ON e.event_id = s.event_id
GROUP BY e.event_name
ORDER BY total_duration_hours DESC;

/*
8. Write a SQL query to display the speaker names and the total number of events they participated in.
   Only include speakers who participated in more than 1 event. Sort the result in ascending order of speaker first name.
*/
SELECT sp.first_name || ' ' || sp.last_name AS speaker_name, COUNT(DISTINCT s.event_id) AS total_events
FROM speakers sp
JOIN sessions s ON sp.speaker_id = s.speaker_id
GROUP BY sp.speaker_id, sp.first_name, sp.last_name
HAVING COUNT(DISTINCT s.event_id) > 1
ORDER BY sp.first_name ASC;

/*
9. Write a SQL query to display the session names and the total number of speakers for each event.
   Sort the result in descending order of total speakers.
*/
SELECT e.event_name, COUNT(DISTINCT s.speaker_id) AS total_speakers
FROM events e
JOIN sessions s ON e.event_id = s.event_id
GROUP BY e.event_name
ORDER BY total_speakers DESC;

/*
Write a SQL query to display the participant names and the total number of sessions they registered for in events located in "San Francisco".     Only include participants who registered for more than 1 session. Sort the result in ascending order of participant first name.
*/
SELECT p.first_name || ' ' || p.last_name AS participant_name, COUNT(r.session_id) AS total_sessions
FROM participants p
JOIN registrations r ON p.participant_id = r.participant_id
JOIN sessions s ON r.session_id = s.session_id
JOIN events e ON s.event_id = e.event_id
WHERE e.location = 'San Francisco'
GROUP BY p.participant_id, p.first_name, p.last_name
HAVING COUNT(r.session_id) > 1
ORDER BY p.first_name ASC;

