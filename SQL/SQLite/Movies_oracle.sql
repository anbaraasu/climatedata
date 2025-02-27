-- Oracle DB
-- DROP tables
DROP TABLE MOVIE_ACTORS;
DROP TABLE REVIEWS;
DROP TABLE MOVIES;
DROP TABLE ACTORS;
DROP TABLE GENRES;

CREATE TABLE GENRES (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR2(100) NOT NULL
);

CREATE TABLE MOVIES (
    movie_id INT PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    release_year INT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES GENRES(genre_id)
);



CREATE TABLE ACTORS (
    actor_id INT PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL
);

CREATE TABLE MOVIE_ACTORS (
    movie_id INT,
    actor_id INT
    );

CREATE TABLE REVIEWS (
    review_id INT PRIMARY KEY,
    movie_id INT,
    rating INT,
    review VARCHAR2(100) NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES MOVIES(movie_id)
);

INSERT INTO GENRES (genre_id, genre_name) VALUES
(1, 'Sci-Fi'),
(2, 'Action'),
(3, 'Drama'),
(4, 'Romance');

INSERT INTO MOVIES (movie_id, title, release_year, genre_id) VALUES
(1, 'The Matrix', 1999, 1),
(2, 'Inception', 2010, 2),
(3, 'The Dark Knight', 2008, 2),
(4, 'Avatar', 2009, 1),
(5, 'The Godfather', 1972, 3),
(6, 'Pulp Fiction', 1994, 3),
(7, 'The Shawshank Redemption', 1994, 3),
(8, 'Titanic', 1997, 4);

INSERT INTO ACTORS (actor_id, first_name, last_name) VALUES
(1, 'Keanu', 'Reeves'),
(2, 'Leonardo', 'DiCaprio'),
(3, 'Christian', 'Bale'),
(4, 'Robert', 'Downey Jr.'),
(5, 'Marlon', 'Brando'),
(6, 'John', 'Travolta'),
(7, 'Tim', 'Robbins'),
(8, 'Kate', 'Winslet'),
(9, 'Morgan', 'Freeman');

INSERT INTO MOVIE_ACTORS (movie_id, actor_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

INSERT INTO REVIEWS (review_id, movie_id, rating, review) VALUES
(1, 1, 9, 'A groundbreaking sci-fi film!'),
(2, 2, 8, 'A mind-bending thriller!'),
(3, 3, 10, 'A masterpiece of action!'),
(4, 4, 7, 'Visually stunning, but slow.'),
(5, 5, 9, 'A timeless classic.'),
(6, 6, 8, 'Quirky, but unforgettable.'),
(7, 7, 10, 'One of the best dramas ever.'),
(8, 8, 8, 'A tear-jerker with great chemistry.'),
(9, 1, 7, 'A fun but confusing ride.'),
(10, 2, 9, 'Brilliant executed.'),
(11, 3, 10, 'A masterpiece of action!'),
(12, 4, 7, 'Visually stunning, but slow.'),
(13, 5, 9, 'A timeless classic.'),
(14, 6, 8, 'Quirky, but unforgettable.'),
(15, 7, 10, 'One of the best dramas ever.'),
(16, 8, 8, 'A tear-jerker with great chemistry.'),
(17, 1, 7, 'A fun but confusing ride.'),
(18, 2, 9, 'Brilliant executed.');

-- Need 2 queries involving min 3 tables JOINs and one nested subqueries
/*
You are tasked with generating a list of movies along with the names of the actors who starred in them. Additionally, for each movie, calculate how many reviews have a rating higher than 8. The list should be sorted by the number of high-rated reviews in descending order.

For each movie, show the movie title.
List the full names of the actors in that movie, separated by commas.
Include a count of reviews with a rating greater than 8 for each movie.
Ensure that each movie appears only once, even if it has multiple actors.
*/
SELECT m.title, 
       GROUP_CONCAT(a.first_name || ' ' || a.last_name) AS actors,
       COUNT(r.rating) AS high_rated_reviews
FROM MOVIES m
JOIN MOVIE_ACTORS ma ON m.movie_id = ma.movie_id
JOIN ACTORS a ON ma.actor_id = a.actor_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
WHERE r.rating > 8 
GROUP BY m.movie_id
ORDER BY high_rated_reviews DESC;
/*
The Godfather|Marlon Brando,Tim Robbins,Morgan Freeman|3                        
The Matrix|Keanu Reeves,Leonardo DiCaprio|2                                     
Inception|Leonardo DiCaprio,Christian Bale|2                                    
The Dark Knight|Christian Bale,Robert Downey Jr.|2                              
The Shawshank Redemption|Tim Robbins,Morgan Freeman|2                           
SQLite version 3.45.1 2024-01-30 16:01:20                                       
Enter ".help" for usage hints. 
*/

/*
You need to display the movie title along with the names of the actors who starred in them. Additionally, calculate the average rating for each movie based on the reviews is greater than 5.. The report should be sorted by the average rating in descending order.

For each movie, display the movie title.
List the full names of the actors in the movie, separated by commas.
Include the average rating of the movie based on the reviews is greater than 5.
Ensure that each movie appears only once, even if it has multiple actors.
*/
SELECT m.title, 
       GROUP_CONCAT(a.first_name || ' ' || a.last_name) AS actors,
       AVG(r.rating) AS average_rating
FROM MOVIES m
JOIN MOVIE_ACTORS ma ON m.movie_id = ma.movie_id
JOIN ACTORS a ON ma.actor_id = a.actor_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
GROUP BY m.movie_id
HAVING average_rating > 5
ORDER BY average_rating DESC;
/*
The Dark Knight|Christian Bale,Robert Downey Jr.|10.0
The Matrix|Keanu Reeves,Leonardo DiCaprio|9.0
The Godfather|Marlon Brando,Tim Robbins,Morgan Freeman|8.0
Inception|Leonardo DiCaprio,Christian Bale|8.0
The Shawshank Redemption|Tim Robbins,Morgan Freeman|8.0
Pulp Fiction|John Travolta,Marlon Brando|8.0
SQLite version 3.45.1 2024-01-30 16:01:20
Enter ".help" for usage hints.
sqlite> 
*/
-- Need 2 queries involving min 3 tables JOINs and one corelated subqueries

/*
Write a query to find all movies that have a rating higher than the average rating of their respective genre. The result should include the movie title, genre name, and its rating. The result should be sorted by the rating in descending order.

For each movie, display the movie title.
Show the genre name of the movie.
Include the rating of the movie.
Sort the result by the rating in descending order.
*/
SELECT m.title, 
       g.genre_name, 
       r.rating
FROM MOVIES m
JOIN GENRES g ON m.genre_id = g.genre_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
WHERE r.rating > (SELECT AVG(rating) 
                  FROM REVIEWS 
                  WHERE movie_id IN (SELECT movie_id 
                                     FROM MOVIES 
                                     WHERE genre_id = m.genre_id))
ORDER BY r.rating DESC;

/*
Case = You need to display the movie title along with the names of the actors who starred in them. Additionally, calculate the average rating for each movie based on the reviews is greater than 5.. The report should be sorted by the average rating in descending order.
Output=
The Dark Knight|Action|10
The Shawshank Redemption|Drama|10
The Matrix|Sci-Fi|9
SQLite version 3.45.1 2024-01-30 16:01:20
Enter ".help" for usage hints.
sqlite> 
*/

/*
Write a query to list all movies that have a rating higher than the rating of any movie starring a specific actor (e.g., "Leonardo DiCaprio"). The result should include the movie title, its rating, and the actor names for each movie.

For each movie, display the movie title.
Include the rating of the movie.
List the full names of the actors in the movie, separated by commas.
*/

SELECT m.title, 
       r.rating, 
       GROUP_CONCAT(a.first_name || ' ' || a.last_name) AS actors
FROM MOVIES m
JOIN MOVIE_ACTORS ma ON m.movie_id = ma.movie_id
JOIN ACTORS a ON ma.actor_id = a.actor_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
WHERE r.rating > (SELECT MAX(rating) 
                  FROM REVIEWS 
                  WHERE movie_id IN (SELECT movie_id 
                                     FROM MOVIE_ACTORS 
                                     WHERE actor_id = (SELECT actor_id 
                                                        FROM ACTORS 
                                                        WHERE first_name = 'Leonardo' 
                                                        AND last_name = 'DiCaprio')))
GROUP BY m.movie_id;