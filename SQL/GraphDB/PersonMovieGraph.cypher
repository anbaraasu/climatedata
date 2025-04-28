
CREATE (g:Genre {name: 'Science Fiction'})
WITH g
MATCH (m:Movie {title: 'The Devil\'s Advocate'})
MERGE (m)-[:BELONGS_TO]->(g);

-- delete above relationship and node 
MATCH (m:Movie {title: 'The Devil\'s Advocate'})-[r:BELONGS_TO]->(g:Genre {name: 'Science Fiction'})
DELETE r, g;

// Create Genre nodes
MERGE (g1:Genre {name: 'Mystery'})
MERGE (g2:Genre {name: 'Thriller'})
MERGE (g3:Genre {name: 'Science Fiction'})
// Connect "The Da Vinci Code" to the genres
WITH g1, g2, g3
MATCH (m:Movie {title: 'The Da Vinci Code'})
MERGE (m)-[:BELONGS_TO]->(g1)
MERGE (m)-[:BELONGS_TO]->(g2)
MERGE (m)-[:BELONGS_TO]->(g3);

// single genres to multiple movies 
MERGE (g1)-[:BELONGS_TO]->(m:Movie {title: 'Inception'})
WITH g1, m
MATCH (m2:Movie {title: 'The Dark Knight'})
MERGE (g1)-[:BELONGS_TO]->(m2)
WITH g1, m2
MATCH (m3:Movie {title: 'Interstellar'})
MERGE (g1)-[:BELONGS_TO]->(m3);

// show the person who has any relatoinships of hcltech  stock
MATCH (p:Person)-[r]->(s:Stock {name: 'HCLTECH'})
RETURN p.name AS Person, type(r) AS Relationship, s.name AS Stock;

// find person anbu and his investments in stocks 
MATCH (p:Person {name: 'Anbu'})-[r]->(s:Stock)
RETURN p.name AS Person, type(r) AS Relationship, s.name AS Stock;

// drop all stocks and relationships w.r.t HCLTECH and INFY stocks
MATCH (s:Stock {name: 'HCLTECH'})-[r]->(p:Person)
DELETE r, s;

// Stock as Node, Person as a node
CREATE (s:Stock {name: 'HCLTECH'})
WITH s
MATCH (p:Person {name: 'Anbu'})
MERGE (p)-[:INVESTED_IN]->(s);

// associate above stock to vipin 
MERGE (s:Stock {name: 'HCLTECH'})
WITH s
MATCH (p:Person {name: 'Vipin'})
MERGE (p)-[:INVESTED_IN]->(s);

// find the persons who invested in HCLTECH
MATCH (p:Person)-[:INVESTED_IN]->(s:Stock {name: 'HCLTECH'})
RETURN p.name AS Investor, s.name AS Stock;



// find all genres for "The Da Vinci Code"
MATCH (m:Movie {title: 'The Da Vinci Code'})-[:BELONGS_TO]->(g:Genre)
RETURN m.title AS Movie, g.name AS Genre;

// drop entire genre node and relationships w.r.t The Da Vinci Code and Inception movies
MATCH (m:Movie {title: 'The Da Vinci Code'})-[r:BELONGS_TO]->(g:Genre)
DELETE r, g
WITH m
MATCH (m)-[r:BELONGS_TO]->(g:Genre {name: 'Mystery'})
DELETE r, g
WITH m
MATCH (m:Movie {title: 'Inception'})-[r:BELONGS_TO]->(g:Genre)
DELETE r, g
WITH m
MATCH (m)-[r:BELONGS_TO]->(g:Genre {name: 'Thriller'})
DELETE r, g
WITH m
MATCH (m:Movie {title: 'Inception'})-[r:BELONGS_TO]->(g:Genre)
DELETE r, g
WITH m
MATCH (m)-[r:BELONGS_TO]->(g:Genre {name: 'Drama'})
DELETE r, g
WITH m
MATCH (m:Movie {title: 'The Da Vinci Code'})-[r:BELONGS_TO]->(g:Genre)
DELETE r, g;

MATCH (g:Genre {name: 'Science Fiction'})-[r:BELONGS_TO]->(m:Movie {title: 'Inception'})
DELETE r, g;

// Use cases for querying the graph

// 1. Find all movies a person has acted in
MATCH (p:Person {name: 'Leonardo DiCaprio'})-[:ACTED_IN]->(m:Movie)
RETURN p.name AS Actor, m.title AS Movie;

// 2. Find all people who directed a specific movie
MATCH (p:Person)-[:DIRECTED]->(m:Movie {title: 'The Matrix'})
RETURN p.name AS Director, m.title AS Movie;

// 3. Find all followers of a specific person
MATCH (p1:Person)-[:FOLLOWS]->(p2:Person {name: 'Leonardo DiCaprio'})
RETURN p1.name AS Follower, p2.name AS Followed;

// 4. Find all movies produced by a person
MATCH (p:Person {name: 'Christopher Nolan'})-[:PRODUCED]->(m:Movie)
RETURN p.name AS Producer, m.title AS Movie;

// 5. Find all reviews for a specific movie
MATCH (p:Person)-[r:REVIEWED]->(m:Movie {title: 'The Social Network'})
RETURN p.name AS Reviewer, r.rating AS Rating, r.comment AS Comment;

// 6. Find all movies written by a person
MATCH (p:Person {name: 'Aaron Sorkin'})-[:WROTE]->(m:Movie)
RETURN p.name AS Writer, m.title AS Movie;

// 7. Find all relationships of a specific person
MATCH (p:Person {name: 'Leonardo DiCaprio'})-[r]->(n)
RETURN p.name AS Person, type(r) AS Relationship, n.title AS RelatedTo;

// 8. Find all people who worked on a specific movie
MATCH (p:Person)-[r]->(m:Movie {title: 'Inception'})
RETURN p.name AS Person, type(r) AS Role, m.title AS Movie;

// 9. Get the entire graph structure (all nodes and relationships)
MATCH (n)-[r]->(m)
RETURN n, r, m;

// 10. Get all nodes and relationships related to a specific person
MATCH (p:Person {name: 'Leonardo DiCaprio'})-[r]->(n)
RETURN p, r, n;

// 11. Get all nodes and relationships for a specific movie
MATCH (m:Movie {title: 'Inception'})<-[r]-(p)
RETURN p, r, m;

// 12. Get the subgraph of people who follow each other
MATCH (p1:Person)-[r:FOLLOWS]->(p2:Person)
RETURN p1, r, p2;

// 13. Get the subgraph of people who worked on a specific movie
MATCH (p:Person)-[r]->(m:Movie {title: 'The Matrix'})
RETURN p, r, m;

// 14. Get the subgraph of all movies reviewed by people
MATCH (p:Person)-[r:REVIEWED]->(m:Movie)
RETURN p, r, m;

// 15. Get the subgraph of all relationships for a specific person
MATCH (p:Person {name: 'Aaron Sorkin'})-[r]->(n)
RETURN p, r, n;
