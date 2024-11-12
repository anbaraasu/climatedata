CREATE TABLE person (name VARCHAR(20),state VARCHAR(20),city VARCHAR(20));

SELECT * FROM person;

DECLARE
    myjson  varchar2(1000) := '[
  {"name": "AJson", "state": "New Delhi", "city": "New Delhi"},
  {"name": "BJson", "state": "Karnataka", "city": "Electronic City"},
  {"name": "CJson", "state": "Telangana", "city": "Hyderabad"}
]';
		
BEGIN
    INSERT INTO person
    SELECT * FROM json_table ( myjson, '$[*]'
      columns ( 
        name, state, city
      )
    );
END;
/
SELECT * FROM person;

CREATE TABLE person (name VARCHAR(20),state VARCHAR(20),city VARCHAR(20));

SELECT * FROM person;

ALTER TABLE person ADD AGE INT;

TRUNCATE TABLE person;

DECLARE
    myjson  varchar2(1000) := '[
  {"name": "AJson", "state": "New Delhi", "city": "New Delhi", "age":21},
  {"name": "BJson", "state": "Karnataka", "city": "Electronic City", "age":22},
  {"name": "CJson", "state": "Telangana", "city": "Hyderabad", "age":23}
]';
		
BEGIN
    INSERT INTO person
    SELECT * FROM json_table ( myjson, '$[*]'
      columns ( 
        name, state, city, age
      )
    );
END;
/
SELECT * FROM person;



--LOB - Large Object
-- CLOB - Character Large Object
-- NCLOB - National Character Large Object
-- BLOB - Binary Large Object
-- BFILE - Binary File

-- DEMO FOR CLOB 
DECLARE
    l_clob CLOB;
BEGIN
    l_clob := 'This is a CLOB';
    INSERT INTO person VALUES ('CLOB', 'CLOB', l_clob, 21);
    COMMIT;
END;
/

SELECT * FROM person;

-- DEMO FOR CLOB USING DBMS_LOB
DECLARE
    l_clob CLOB;
BEGIN
    l_clob := 'This is a CLOB';
    INSERT INTO person VALUES ('CLOB', 'CLOB', l_clob, 22);
    COMMIT;
    DBMS_LOB.WRITEAPPEND(l_clob, LENGTH(l_clob), ' appended text');
    UPDATE person SET clob_column = l_clob WHERE name = 'CLOB';
    COMMIT;    
END;
/

SELECT * FROM person;
