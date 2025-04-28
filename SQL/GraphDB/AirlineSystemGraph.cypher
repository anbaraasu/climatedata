// drop all nodes and relationships w.r.t stock 


// Create Airport nodes
CREATE (a1:Airport {code: 'JFK', name: 'John F. Kennedy International Airport'})
CREATE (a2:Airport {code: 'LAX', name: 'Los Angeles International Airport'})
CREATE (a3:Airport {code: 'ORD', name: 'OHare International Airport'})
CREATE (a4:Airport {code: 'ATL', name: 'Hartsfield-Jackson Atlanta International Airport'});


// add 1245 distance betwen JFK and LAX 
MATCH (a1:Airport {code: 'JFK'}), (a2:Airport {code: 'LAX'})
CREATE (a1)-[:FLIGHT {distance: 1245}]->(a2); // JFK to LAX

MATCH (a1:Airport {code: 'JFK'}), (a3:Airport {code: 'ORD'})
CREATE (a1)-[:FLIGHT {distance: 740}]->(a3); // JFK to ORD

// Query 1: Find all direct flights from JFK
MATCH (a:Airport {code: 'JFK'})-[:FLIGHT]->(b:Airport)
RETURN a.name AS From, b.name AS To;

// Query 2: Find the shortest path (by distance) between JFK and LAX
MATCH (start:Airport {code: 'JFK'}), (end:Airport {code: 'LAX'}),
      p = shortestPath((start)-[:FLIGHT*]-(end))
RETURN p, reduce(totalDistance = 0, r IN relationships(p) | totalDistance + r.distance) AS TotalDistance;

// Query 3: Find all airports reachable from JFK within 1000 miles
MATCH (a:Airport {code: 'JFK'})-[r:FLIGHT]->(b:Airport)
WHERE r.distance <= 1000
RETURN a.name AS From, b.name AS To, r.distance AS Distance;

// Query 4: Get the entire airline graph structure
MATCH (a:Airport)-[r:FLIGHT]->(b:Airport)
RETURN a, r, b;
