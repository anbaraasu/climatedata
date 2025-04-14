-- CREATE TABLES for AirliveMgmt
-- Airports Table
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY,
    airport_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    iata_code VARCHAR(3)
);

-- Flights Table
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(10),
    departure_airport_id INT,
    arrival_airport_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (departure_airport_id) REFERENCES Airports(airport_id),
    FOREIGN KEY (arrival_airport_id) REFERENCES Airports(airport_id)
);

-- Passengers Table
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

-- Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATETIME,
    seat_number VARCHAR(5),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10, 2),
    payment_date DATETIME,
    status VARCHAR(20),
    payment_method VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);


/*Write a sql query to find the flights that have bookings with successful payments above 300.
Display the flight number and payment amount
Sort the result in descending order of payment amount.
*/

SELECT DISTINCT f.flight_number, pay.amount
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'Success'
  AND pay.amount > 300
ORDER BY pay.amount DESC, f.flight_number;

/*
Write a sql query to List passengers who traveled after '2025-02-26' and  with PayPal as payment method.
Display the passenger's first name, last name, and email.
Sort the result by last name in ascending order.
*/

SELECT DISTINCT p.first_name, p.last_name, p.email
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date > '2025-02-26'
  AND pay.payment_method = 'Paypal'
ORDER BY p.last_name ASC;


/* 
Write a SQL to list all flights from 'USA' to 'UK' with departure after '2025-03-01'.
Display the flight number and departure time.
Sort the result by departure time descending.
*/

sql
Copy
Edit
SELECT f.flight_number, f.departure_time
FROM Flights f
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.country = 'USA'
  AND a2.country = 'UK'
  AND f.departure_time > '2025-03-01'
ORDER BY f.departure_time DESC;


/*
Write a SQL query to Get bookings with failed payments on flights marked as 'Cancelled'.
Display the booking ID and payment status.
Sort the result by booking ID in ascending order.
*/
SELECT b.booking_id, pay.status
FROM Bookings b
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE f.status = 'Cancelled'
  AND pay.status = 'Failed'
ORDER BY b.booking_id ASC;


/*
Write a SQL query to Get customer full name and bookings with failed payments on flights marked as 'Cancelled'.
Display the customer's full name, booking ID, and payment status.
Sort the result by booking ID in ascending order.
*/
SELECT CONCAT(p.first_name, ' ', p.last_name) AS full_name, b.booking_id, pay.status
FROM Bookings b
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Payments pay ON b.booking_id = pay.booking_id
JOIN Passengers p ON b.passenger_id = p.passenger_id
WHERE f.status = 'Cancelled'
  AND pay.status = 'Failed'
ORDER BY b.booking_id ASC;


/*
Write a SQL query to find all passengers who have more than one booking and have at least one failed payment.
Display the passenger's first name, last name, and total number of bookings.
Sort the result by total bookings in descending order and then by last name.
*/
SELECT p.first_name, p.last_name, COUNT(b.booking_id) AS total_bookings
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'Failed'
GROUP BY p.passenger_id, p.first_name, p.last_name
HAVING COUNT(b.booking_id) > 1
ORDER BY total_bookings DESC, p.last_name;

/*
Write a SQL query to get all flights booked by passengers whose last name ends with 'son' and payment was successful.
Display the flight number, passenger's last name, and payment status.
Sort the result by passenger's last name and flight number descending order.
*/
SELECT DISTINCT f.flight_number, p.last_name, pay.status
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_id
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE p.last_name LIKE '%son'
  AND pay.status = 'Success'
ORDER BY p.last_name, f.flight_number DESC;

/*
Write a SQL quert to find the top 2 passengers who have booked the most flights.
Display the passenger's first name, last name, and total number of flights booked.
Sort the result by total flights booked in descending order.
*/
SELECT p.first_name, p.last_name, COUNT(b.booking_id) AS total_flights_booked
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
WHERE f.status = 'On time'
GROUP BY p.passenger_id, p.first_name, p.last_name
HAVING COUNT(b.booking_id) > 0
ORDER BY total_flights_booked DESC
LIMIT 2;

/* 
Write a SQL query to List passengers who have booked flights departing from 'Dubai International' airport and arriving at 'Los Angeles Intl' airport.
Display the passenger's first name, last name, and flight number.
Sort the result by flight number in ascending order.
*/
SELECT p.first_name, p.last_name, f.flight_number
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.airport_name = 'Dubai International'
  AND a2.airport_name = 'Los Angeles Intl'
ORDER BY f.flight_number ASC;


/*
Write a SQL Query to list all passengers who booked flights arriving in cities where they’ve never flown to before.
Display the customer's first name, last name without duplications.

*/

SELECT DISTINCT p.first_name, p.last_name
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Airports a ON f.arrival_airport_id = a.airport_id
WHERE a.city NOT IN (
    SELECT DISTINCT a2.city
    FROM Bookings b2
    JOIN Flights f2 ON b2.flight_id = f2.flight_id
    JOIN Airports a2 ON f2.arrival_airport_id = a2.airport_id
    WHERE b2.passenger_id = p.passenger_id
);


-- DELETE existing data (Child to Parent order)
DELETE FROM Payments;
DELETE FROM Bookings;
DELETE FROM Passengers;
DELETE FROM Flights;
DELETE FROM Airports;

-- Delete existing data to clean up the tables
DELETE FROM Payments;
DELETE FROM Bookings;
DELETE FROM Passengers;
DELETE FROM Flights;
DELETE FROM Airports;

-- Insert new airports
INSERT INTO Airports (airport_id, airport_name, city, country, iata_code) VALUES
(1, 'John F. Kennedy', 'New York', 'USA', 'JFK'),
(2, 'Los Angeles Intl', 'Los Angeles', 'USA', 'LAX'),
(3, 'San Francisco Intl', 'San Francisco', 'USA', 'SFO'),
(4, 'Berlin Brandenburg', 'Berlin', 'Germany', 'BER'),
(5, 'Tokyo Haneda', 'Tokyo', 'Japan', 'HND');

-- Insert new flights
INSERT INTO Flights (flight_id, flight_number, departure_airport_id, arrival_airport_id, departure_time, arrival_time, status) VALUES
(101, 'AA100', 1, 3, '2025-03-10 08:00:00', '2025-03-10 12:00:00', 'On time'), -- JFK to SFO
(102, 'UA200', 3, 4, '2025-03-11 14:00:00', '2025-03-11 20:00:00', 'On time'), -- SFO to Berlin
(103, 'NH300', 3, 5, '2025-03-12 10:00:00', '2025-03-12 18:00:00', 'On time'); -- SFO to Tokyo Haneda

-- Insert new passengers
INSERT INTO Passengers (passenger_id, first_name, last_name, email, phone_number) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@email.com', '1231231234'),
(2, 'Bob', 'Smith', 'bob.smith@email.com', '4564564567');

-- Insert new bookings
INSERT INTO Bookings (booking_id, passenger_id, flight_id, booking_date, seat_number) VALUES
(1, 1, 101, '2025-03-09 10:00:00', '14A'), -- Alice books JFK to SFO
(2, 1, 102, '2025-03-10 15:00:00', '16B'), -- Alice books SFO to Berlin
(3, 2, 101, '2025-03-09 11:00:00', '15C'), -- Bob books JFK to SFO
(4, 2, 103, '2025-03-11 12:00:00', '18D'); -- Bob books SFO to Tokyo Haneda

-- Insert new payments
INSERT INTO Payments (payment_id, booking_id, amount, payment_date, status, payment_method) VALUES
(1, 1, 500, '2025-03-09 10:30:00', 'Success', 'Credit Card'),
(2, 2, 700, '2025-03-10 15:30:00', 'Success', 'Paypal'),
(3, 3, 450, '2025-03-09 11:30:00', 'Success', 'UPI'),
(4, 4, 800, '2025-03-11 12:30:00', 'Success', 'Credit Card');


/*
Write a SQL query to find passengers who have booked flights departing from their home city.
Display customer first name, last name, home city and flight number details.
Sort the result by last name in ascending order thne home city in descending order.
*/
SELECT p.first_name, p.last_name, a.city AS home_city, f.flight_number
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Airports a ON f.departure_airport_id = a.airport_id
WHERE a.city = p.city
ORDER BY p.last_name ASC, a.city DESC;


/* 
Write a SQL query to find the airports that have both incoming and outgoing flights scheduled on the same day. Show the airport name and the date.
Display the airport name and the date.
Sort the result by airport name in ascending order.
*/
SELECT a.airport_name, DATE(f1.departure_time) AS flight_date
FROM Airports a
JOIN Flights f1 ON a.airport_id = f1.departure_airport_id
JOIN Flights f2 ON a.airport_id = f2.arrival_airport_id
WHERE DATE(f1.departure_time) = DATE(f2.arrival_time)
GROUP BY a.airport_name, DATE(f1.departure_time);

/* 
Write a SQL query to find passengers who booked flights with departure times between '2025-03-01' and '2025-03-05' and payment status is 'Success'.
Display the passenger's first name, last name, flight number, and payment amount.
Sort the result by payment amount descending and passenger's last name ascending.
*/
SELECT p.first_name, p.last_name, f.flight_number, pay.amount
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE f.departure_time BETWEEN '2025-03-01' AND '2025-03-05'
  AND pay.status = 'Success'
ORDER BY pay.amount DESC, p.last_name ASC;

-- L1 
/* 
Write a SQL query to find flights where the departure airport city starts with 'D' and arrival airport city ends with 's'.
Display the flight number, departure city, and arrival city.
Sort the result by flight number ascending and arrival city descending.
*/
SELECT f.flight_number, a1.city AS departure_city, a2.city AS arrival_city
FROM Flights f
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.city LIKE 'D%' AND a2.city LIKE '%s'
ORDER BY f.flight_number ASC, a2.city DESC;

/* 
Write a SQL query to find list of seat numbers, their payment date where seat containing "A" and payment method is "Credit Card"
Display the seat number, and payment date.
Sort the result by seat number ascending and payment date descending.
*/
SELECT b.seat_number, pay.payment_method
FROM Bookings b
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE b.seat_number LIKE '%A%' AND pay.payment_method = 'Credit Card'
ORDER BY b.seat_number ASC, pay.payment_method DESC;

/* 
Write a SQL query to find flights where the departure airport country is 'USA' and the arrival airport country is not 'UK'.
Display the flight number, departure country, and arrival country.
Sort the result by departure country descending and flight number ascending.
*/
SELECT f.flight_number, a1.country AS departure_country, a2.country AS arrival_country
FROM Flights f
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.country = 'USA' AND a2.country != 'UK'
ORDER BY a1.country DESC, f.flight_number ASC;

/* 
Write a SQL query to find passengers who booked flights with booking dates before '2025-03-01' and payment amount greater than 1000.
Display the passenger's first name, last name, booking date, and payment amount.
Sort the result by booking date ascending and payment amount descending.
*/
SELECT p.first_name, p.last_name, b.booking_date, pay.amount
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date < '2025-03-01' AND pay.amount > 1000
ORDER BY b.booking_date ASC, pay.amount DESC;

/* 
Write a SQL query to find flights where the flight status is 'On time' and the arrival airport city contains 'o'.
Display the flight number, flight status, and arrival city.
Sort the result by flight status ascending and arrival city descending.
*/
SELECT f.flight_number, f.status AS flight_status, a2.city AS arrival_city
FROM Flights f
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE f.status = 'On time' AND a2.city LIKE '%o%'
ORDER BY f.status ASC, a2.city DESC;

/* 
Write a SQL query to find passengers who booked flights with payment status 'Failed' and flight status is 'Cancelled'.
Display the passenger's first name, last name, flight number, and payment status.
Sort the result by passenger's last name ascending and flight number descending.
*/
SELECT p.first_name, p.last_name, f.flight_number, pay.status AS payment_status
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'Failed' AND f.status = 'Cancelled'
ORDER BY p.last_name ASC, f.flight_number DESC;

/* 
Write a SQL query to find flights where the departure airport name contains 'International' and arrival airport name contains 'Intl'.
Display the flight number, departure airport name, and arrival airport name.
Sort the result by departure airport name descending and flight number ascending.
*/
SELECT f.flight_number, a1.airport_name AS departure_airport, a2.airport_name AS arrival_airport
FROM Flights f
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.airport_name LIKE '%International%' AND a2.airport_name LIKE '%Intl%'
ORDER BY a1.airport_name DESC, f.flight_number ASC;

/* 
Write a SQL query to find passengers who booked flights with departure times after '2025-03-05' and payment method is 'UPI'.
Display the passenger's first name, last name, flight number, and payment method.
Sort the result by flight number ascending and passenger's last name descending.
*/
SELECT p.first_name, p.last_name, f.flight_number, pay.payment_method
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE f.departure_time > '2025-03-05' AND pay.payment_method = 'UPI'
ORDER BY f.flight_number ASC, p.last_name DESC;

/* 
Write a SQL query to find flights where the departure airport country is 'Australia' and the arrival airport country is 'USA'.
Display the flight number, departure country, and arrival country.
Sort the result by arrival country ascending and flight number descending.
*/
SELECT f.flight_number, a1.country AS departure_country, a2.country AS arrival_country
FROM Flights f
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.country = 'Australia' AND a2.country = 'USA'
ORDER BY a2.country ASC, f.flight_number DESC;

/* 
Write a SQL query to find passengers who have booked the most flights with successful payments.
Display the passenger's full name, total successful payments, and total amount paid.
Sort the result by total successful payments descending and total amount paid descending.
*/
SELECT CONCAT(p.first_name, ' ', p.last_name) AS full_name, 
       COUNT(pay.payment_id) AS total_successful_payments, 
       SUM(pay.amount) AS total_amount_paid
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'Success'
GROUP BY p.passenger_id
HAVING COUNT(pay.payment_id) = (
    SELECT MAX(total_payments)
    FROM (
        SELECT COUNT(pay.payment_id) AS total_payments
        FROM Payments pay
        WHERE pay.status = 'Success'
        GROUP BY pay.booking_id
    ) subquery
)
ORDER BY total_successful_payments DESC, total_amount_paid DESC;

/* 
Write a SQL query to find the top 3 airports with the highest number of incoming flights.
Display the airport name, total incoming flights, and the most common departure country for those flights.
Sort the result by total incoming flights descending.
*/
SELECT a.airport_name, 
       COUNT(f.flight_id) AS total_incoming_flights, 
       (SELECT a2.country
        FROM Flights f2
        JOIN Airports a2 ON f2.departure_airport_id = a2.airport_id
        WHERE f2.arrival_airport_id = a.airport_id
        GROUP BY a2.country
        ORDER BY COUNT(f2.flight_id) DESC
        LIMIT 1) AS most_common_departure_country
FROM Airports a
JOIN Flights f ON a.airport_id = f.arrival_airport_id
GROUP BY a.airport_id
ORDER BY total_incoming_flights DESC
LIMIT 3;

/* 
Write a SQL query to find passengers who have booked flights to the most visited city.
Display the passenger's full name, the city name, and the total number of bookings to that city.
Sort the result by passenger's last name ascending.
*/
SELECT CONCAT(p.first_name, ' ', p.last_name) AS full_name, 
       most_visited_city.city_name, 
       COUNT(b.booking_id) AS total_bookings_to_city
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Airports a ON f.arrival_airport_id = a.airport_id
JOIN (
    SELECT a.city AS city_name, COUNT(f.flight_id) AS total_flights
    FROM Flights f
    JOIN Airports a ON f.arrival_airport_id = a.airport_id
    GROUP BY a.city
    ORDER BY total_flights DESC
    LIMIT 1
) most_visited_city ON a.city = most_visited_city.city_name
GROUP BY p.passenger_id, most_visited_city.city_name
ORDER BY p.last_name ASC;

/* 
Write a SQL query to find the flight with the highest total payment amount for successful bookings.
Display the flight number, total payment amount, and the number of successful bookings.
Sort the result by total payment amount descending.
*/
SELECT f.flight_number, 
       SUM(pay.amount) AS total_payment_amount, 
       COUNT(pay.payment_id) AS successful_bookings
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'Success'
GROUP BY f.flight_id
HAVING SUM(pay.amount) = (
    SELECT MAX(total_amount)
    FROM (
        SELECT SUM(pay.amount) AS total_amount
        FROM Payments pay
        WHERE pay.status = 'Success'
        GROUP BY pay.booking_id
    ) subquery
)
ORDER BY total_payment_amount DESC;

/* 
Write a SQL query to find passengers who have booked flights departing from their home city and arriving in a city they’ve never visited before.
Display the passenger's full name, home city, and the new city they visited.
Sort the result by passenger's last name ascending and new city descending.
*/
SELECT DISTINCT CONCAT(p.first_name, ' ', p.last_name) AS full_name, 
                home_city.city_name AS home_city, 
                new_city.city_name AS new_city
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Airports home_city ON f.departure_airport_id = home_city.airport_id
JOIN Airports new_city ON f.arrival_airport_id = new_city.airport_id
WHERE home_city.city_name = (
    SELECT a.city
    FROM Airports a
    WHERE a.city = home_city.city_name
)
AND new_city.city_name NOT IN (
    SELECT DISTINCT a2.city
    FROM Bookings b2
    JOIN Flights f2 ON b2.flight_id = f2.flight_id
    JOIN Airports a2 ON f2.arrival_airport_id = a2.airport_id
    WHERE b2.passenger_id = p.passenger_id
)
ORDER BY p.last_name ASC, new_city.city_name DESC;


-- using set operators 
/*
Write a SQL query to find passengers who have booked flights departing from 'New York' and arriving in 'Los Angeles' and vice versa.
Display the passenger's first name, last name, and flight number.
Sort the result by passenger's last name ascending and flight number descending.
*/
SELECT p.first_name, p.last_name, f.flight_number
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.city = 'New York' AND a2.city = 'Los Angeles'
UNION
SELECT p.first_name, p.last_name, f.flight_number
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Airports a1 ON f.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.city = 'Los Angeles' AND a2.city = 'New York'
ORDER BY p.last_name ASC, f.flight_number DESC;


/*
Write a SQL query to find passengers, onwards flight number and return flight number who booked return flights between 'New York' and 'Los Angeles'.
Display the passenger's first name, last name
Sort the result by passenger's last name ascending.
*/
SELECT p.first_name, p.last_name, f1.flight_number AS onward_flight, f2.flight_number AS return_flight
FROM Passengers p
JOIN Bookings b1 ON p.passenger_id = b1.passenger_id
JOIN Flights f1 ON b1.flight_id = f1.flight_id
JOIN Bookings b2 ON p.passenger_id = b2.passenger_id
JOIN Flights f2 ON b2.flight_id = f2.flight_id
JOIN Airports a1 ON f1.departure_airport_id = a1.airport_id
JOIN Airports a2 ON f1.arrival_airport_id = a2.airport_id
JOIN Airports a3 ON f2.departure_airport_id = a3.airport_id
JOIN Airports a4 ON f2.arrival_airport_id = a4.airport_id
WHERE (a1.city = 'New York' AND a2.city = 'Los Angeles' AND a3.city = 'Los Angeles' AND a4.city = 'New York')
   OR (a1.city = 'Los Angeles' AND a2.city = 'New York' AND a3.city = 'New York' AND a4.city = 'Los Angeles')
ORDER BY p.last_name ASC;

-- Clean up tables
DELETE FROM Payments;
DELETE FROM Bookings;
DELETE FROM Passengers;
DELETE FROM Flights;
DELETE FROM Airports;

-- Insert new airports
INSERT INTO Airports (airport_id, airport_name, city, country, iata_code) VALUES
(1, 'John F. Kennedy', 'New York', 'USA', 'JFK'),
(2, 'Los Angeles Intl', 'Los Angeles', 'USA', 'LAX');

-- Insert new flights
INSERT INTO Flights (flight_id, flight_number, departure_airport_id, arrival_airport_id, departure_time, arrival_time, status) VALUES
(101, 'NYLA100', 1, 2, '2025-03-10 08:00:00', '2025-03-10 12:00:00', 'On time'), -- New York to Los Angeles
(102, 'LANY200', 2, 1, '2025-03-11 14:00:00', '2025-03-11 18:00:00', 'On time'); -- Los Angeles to New York

-- Insert new passengers
INSERT INTO Passengers (passenger_id, first_name, last_name, email, phone_number) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@email.com', '1231231234'),
(2, 'Bob', 'Smith', 'bob.smith@email.com', '4564564567'),
(3, 'Charlie', 'Brown', 'charlie.brown@email.com', '7897897890'),
(4, 'David', 'Wilson', 'david.wilson@email.com', '3213214321'),
(5, 'Eve', 'Davis', 'eve.davis@email.com', '6546546543');

-- Insert new bookings
INSERT INTO Bookings (booking_id, passenger_id, flight_id, booking_date, seat_number) VALUES
(1, 1, 101, '2025-03-09 10:00:00', '14A'), -- Alice books New York to Los Angeles
(2, 1, 102, '2025-03-10 15:00:00', '16B'), -- Alice books Los Angeles to New York (return flight)
(3, 2, 101, '2025-03-09 11:00:00', '15C'), -- Bob books New York to Los Angeles
(4, 2, 102, '2025-03-10 16:00:00', '18D'), -- Bob books Los Angeles to New York (return flight)
(5, 3, 101, '2025-03-09 12:00:00', '20E'), -- Charlie books New York to Los Angeles (no return flight)
(6, 4, 101, '2025-03-09 13:00:00', '22F'), -- David books New York to Los Angeles
(7, 5, 102, '2025-03-10 17:00:00', '24G'),-- Eve books Los Angeles to New York (return flight)
(8, 5, 101, '2025-03-09 18:00:00', '26H'); -- Eve books New York to Los Angeles (no return flight)

-- Insert new payments
INSERT INTO Payments (payment_id, booking_id, amount, payment_date, status, payment_method) VALUES
(1, 1, 500, '2025-03-09 10:30:00', 'Success', 'Credit Card'),
(2, 2, 700, '2025-03-10 15:30:00', 'Success', 'Paypal'),
(3, 3, 450, '2025-03-09 11:30:00', 'Success', 'UPI'),
(4, 4, 600, '2025-03-10 16:30:00', 'Success', 'Credit Card'),
(5, 5, 300, '2025-03-09 12:30:00', 'Success', 'Paypal'),
(6, 6, 400, '2025-03-09 13:30:00', 'Success', 'UPI'),
(7, 7, 800, '2025-03-10 17:30:00', 'Success', 'Credit Card'),
(8, 8, 900, '2025-03-09 18:30:00', 'Success', 'Paypal');