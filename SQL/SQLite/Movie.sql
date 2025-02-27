-- Below is the schema for a movie database that contains information about movies, genres, actors, movie actors, and reviews. Use this schema to write queries to answer the following questions.

/*
Movies: 

movie_id 

title 

release_year 

genre_id 

1 

"The Matrix" 

1999 

1 

2 

"Inception" 

2010 

2 

3 

"The Dark Knight" 

2008 

2 

4 

"Avatar" 

2009 

1 

5 

"The Godfather" 

1972 

3 

6 

"Pulp Fiction" 

1994 

3 

7 

"The Shawshank Redemption" 

1994 

3 

8 

"Titanic" 

1997 

4 

Genres: 

genre_id 

genre_name 

1 

Sci-Fi 

2 

Action 

3 

Drama 

4 

Romance 

Actors: 

actor_id 

first_name 

last_name 

1 

Keanu 

Reeves 

2 

Leonardo 

DiCaprio 

3 

Christian 

Bale 

4 

Robert 

Downey Jr. 

5 

Marlon 

Brando 

6 

John 

Travolta 

7 

Tim 

Robbins 

8 

Kate 

Winslet 

9 

Morgan 

Freeman 

Movie_Actors: 

movie_id 

actor_id 

1 

1 

2 

2 

3 

3 

4 

4 

5 

5 

6 

6 

7 

7 

8 

8 

1 

2 

2 

3 

3 

4 

6 

5 

7 

9 

5 

9 

Reviews: 

review_id 

movie_id 

rating 

review_text 

1 

1 

9 

"A groundbreaking sci-fi film!" 

2 

2 

8 

"A mind-bending thriller!" 

3 

3 

10 

"A masterpiece of action!" 

4 

4 

7 

"Visually stunning, but slow." 

5 

5 

9 

"A timeless classic." 

6 

6 

8 

"Quirky, but unforgettable." 

7 

7 

10 

"One of the best dramas ever." 

8 

8 

8 

"A tear-jerker with great chemistry." 

9 

1 

7 

"A fun but confusing ride." 

10 

2 

9 

"Brilliantly executed." 

*/

CREATE TABLE MOVIES (
    movie_id INT PRIMARY KEY,
    title TEXT NOT NULL,
    release_year INT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES GENRES(genre_id)
);

CREATE TABLE GENRES (
    genre_id INT PRIMARY KEY,
    genre_name TEXT NOT NULL
);

CREATE TABLE ACTORS (
    actor_id INT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE MOVIE_ACTORS (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES MOVIES(movie_id),
    FOREIGN KEY (actor_id) REFERENCES ACTORS(actor_id)
);

CREATE TABLE REVIEWS (
    review_id INT PRIMARY KEY,
    movie_id INT,
    rating INT,
    review_text TEXT NOT NULL,
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

INSERT INTO REVIEWS (review_id, movie_id, rating, review_text) VALUES
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
(13, 5, 10, 'A timeless classic.'),
(14, 6, 9, 'Quirky, but unforgettable.'),
(15, 7, 10, 'One of the best dramas ever.'),
(16, 8, 9, 'A tear-jerker with great chemistry.'),
(17, 1, 6, 'A fun but confusing ride.'),
(18, 2, 10, 'Brilliant executed.');

/*
You are tasked with generating a list of movies along with the names of the actors who starred in them. Additionally, for each movie, calculate how many reviews have a rating higher than 8. The list should be sorted by the number of high-rated reviews in descending order.

For each movie, show the movie title.
Full name of the actor in that movie, separated by single space.
Include a count of reviews with a rating greater than 8 for each movie.
Ensure that each movie appears only once, even if it has multiple actors.
*/
SELECT m.title, 
       (a.first_name || ' ' || a.last_name) AS actor_full_name,
       COUNT(r.rating) AS high_rated_reviews
FROM MOVIES m
JOIN MOVIE_ACTORS ma ON m.movie_id = ma.movie_id
JOIN ACTORS a ON ma.actor_id = a.actor_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
WHERE r.rating > 8 
GROUP BY m.title, (a.first_name || ' ' || a.last_name)
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
You need to display the movie title along with the full name of the actor who starred in them. Additionally, calculate the average rating for each movie based on the reviews is greater than 5.. The report should be sorted by the average rating in descending order.

For each movie, display the movie title.
Full name of the actor in the movie, separated by single space.
Include the average rating of the movie based on the reviews is greater than 5.
Ensure that each movie appears only once, even if it has multiple actors.
Sort the result by the average rating in descending order.
*/
SELECT m.title, 
       (a.first_name || ' ' || a.last_name) AS actor_full_name,
       AVG(r.rating) AS average_rating
FROM MOVIES m
JOIN MOVIE_ACTORS ma ON m.movie_id = ma.movie_id
JOIN ACTORS a ON ma.actor_id = a.actor_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
GROUP BY m.title, (a.first_name || ' ' || a.last_name)
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
Write a query to find all unique movies that have a rating higher than the average rating of their respective genre. The result should include the movie title, genre name, and its rating. The result should be sorted by the rating in descending order.

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
Case = You need to display the unique movie title along with the names of the actors who starred in them. Additionally, calculate the average rating for each movie based on the reviews is greater than 5.. The report should be sorted by the average rating in descending order.
Output=
The Dark Knight|Action|10
The Shawshank Redemption|Drama|10
The Matrix|Sci-Fi|9
SQLite version 3.45.1 2024-01-30 16:01:20
Enter ".help" for usage hints.
sqlite> 
*/

/*
Write a query to list all movies that have equal rating of any movie starring a specific actor ("Leonardo DiCaprio"). The result should include the movie title, its rating, and the actor names for each movie.

For each movie, display the movie title.
Include the rating of the movie.
Full name of the actor in the movie, separated by single space.
Sort the result by the rating in descending order.
*/

SELECT 
    m.title AS movie_title,
    r.rating AS movie_rating,
    (a.first_name || ' ' || a.last_name) AS actor_names
FROM MOVIES m
JOIN MOVIE_ACTORS ma ON m.movie_id = ma.movie_id
JOIN ACTORS a ON ma.actor_id = a.actor_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
WHERE r.rating = (
    SELECT MAX(r2.rating)
    FROM MOVIES m2
    JOIN MOVIE_ACTORS ma2 ON m2.movie_id = ma2.movie_id
    JOIN REVIEWS r2 ON m2.movie_id = r2.movie_id
    JOIN ACTORS a2 ON ma2.actor_id = a2.actor_id
    WHERE a2.first_name = 'Leonardo' AND a2.last_name = 'DiCaprio'
)
GROUP BY movie_title, actor_names
ORDER BY movie_title DESC, movie_rating DESC;


/*
Write a query to find actors who have appeared in movies with a rating higher than their own average movie rating. The result should list the actor's name and the movie titles they appeared in.

For each actor, display the full name of the actor, separated by single space.
Show the movie title of the movie the actor appeared in.
Sort the result by the actor's full name in ascending, title in descending order.
*/

SELECT 
    (a.first_name || ' ' || a.last_name) AS actor_full_name,
    m.title AS movie_title
FROM ACTORS a
JOIN MOVIE_ACTORS ma ON a.actor_id = ma.actor_id
JOIN MOVIES m ON ma.movie_id = m.movie_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
WHERE r.rating > (
    SELECT AVG(r2.rating)
    FROM MOVIE_ACTORS ma2
    JOIN MOVIES m2 ON ma2.movie_id = m2.movie_id
    JOIN REVIEWS r2 ON m2.movie_id = r2.movie_id
    WHERE ma2.actor_id = a.actor_id
)
ORDER BY actor_full_name ASC, movie_title DESC;

/*
Case = Write a query to find actors who have appeared in movies with a rating higher than their own average movie rating. The result should list the actor's name and the movie titles they appeared in.
Output=
John Travolta|Pulp Fiction                                                      
Kate Winslet|Titanic                                                            
Keanu Reeves|The Matrix                                                         
Leonardo DiCaprio|Inception                                                     
Marlon Brando|The Godfather                                                     
SQLite version 3.45.1 2024-01-30 16:01:20                                       
Enter ".help" for usage hints.                                                  
sqlite>                                                                         
*/                                                                      
          

/*
Write a query to find the movie title, full name of the actor, genre name, average rating of the movie, and the average rating of the genre. The result should be sorted by the movie title in ascending order and the rating in descending order.

For each movie, display the movie title.
Full name of the actor in the movie, separated by single space.
Show the genre name of the movie.
Include the average rating of the movie.
Include the average rating of the genre.
Sort the result by the movie title in ascending order and the rating in descending order.
*/

SELECT 
    m.title AS movie_title,
    (a.first_name || ' ' || a.last_name) AS actor_full_name,
    g.genre_name,
    AVG(r.rating) AS movie_avg_rating,
    (SELECT AVG(r2.rating)
     FROM MOVIES m2
     JOIN REVIEWS r2 ON m2.movie_id = r2.movie_id
     WHERE m2.genre_id = m.genre_id) AS genre_avg_rating
FROM MOVIES m
JOIN MOVIE_ACTORS ma ON m.movie_id = ma.movie_id
JOIN ACTORS a ON ma.actor_id = a.actor_id
JOIN GENRES g ON m.genre_id = g.genre_id
JOIN REVIEWS r ON m.movie_id = r.movie_id
GROUP BY m.title, (a.first_name || ' ' || a.last_name), g.genre_name
ORDER BY m.title ASC, movie_avg_rating DESC;

/*
Case = Write a query to find the movie title, full name of the actor, genre name, average rating of the movie, and the average rating of the genre. The result should be sorted by the movie title in ascending order and the rating in descending order.
Output=
Avatar|Robert Downey Jr.|Sci-Fi|7.0|7.2                                         
Inception|Leonardo DiCaprio|Action|9.0|9.4                                      
Pulp Fiction|John Travolta|Drama|8.5|9.33333333333333                           
The Dark Knight|Christian Bale|Action|10.0|9.4                                  
The Godfather|Marlon Brando|Drama|9.5|9.33333333333333                          
The Matrix|Keanu Reeves|Sci-Fi|7.33333333333333|7.2                             
The Shawshank Redemption|Tim Robbins|Drama|10.0|9.33333333333333                
Titanic|Kate Winslet|Romance|8.5|8.5                                            
SQLite version 3.45.1 2024-01-30 16:01:20                                       
Enter ".help" for usage hints.                                                  
sqlite>                                                                         
*/