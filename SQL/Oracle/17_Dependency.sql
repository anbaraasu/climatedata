
-- PROC to insert error log
CREATE TABLE DUMMY(ID INT, NAME VARCHAR2(100));

CREATE OR REPLACE VIEW DUMMY_VIEW AS SELECT * FROM DUMMY;

ALTER VIEW DUMMY_VIEW COMPILE;

SELECT * FROM USER_OBJECTS WHERE STATUS = 'INVALID';

DROP TABLE DUMMY;

-- PROC to insert record into DUMMY table
CREATE OR REPLACE PROCEDURE insert_dummy(p_id IN INT, p_name IN VARCHAR2) AS
BEGIN
    INSERT INTO DUMMY(ID,NAME) VALUES(p_id, p_name);
END insert_dummy;
/


-- find all the invalid objects in the schema
SELECT * FROM USER_OBJECTS WHERE STATUS = 'INVALID';

-- alter dummy table with age
ALTER TABLE DUMMY ADD AGE NUMBER;


-- compile all the db object
EXEC DBMS_UTILITY.compile_schema(USER, FALSE);

-- find all the invalid objects in the schema
SELECT * FROM USER_OBJECTS WHERE STATUS = 'INVALID';


-- find the error about the invalid db object
SELECT * FROM USER_ERRORS WHERE NAME IN 
(SELECT OBJECT_NAME FROM USER_OBJECTS WHERE STATUS = 'INVALID');

-- Meta tables/view
-- USER_OBJECTS  - contain all the db object created in the user schema
-- USER_ERRORS   - contain all the error related to the db object
-- USER_TABLES   - contain all the tables created in the user schema
-- USER_VIEWS    - contain all the views created in the user schema
-- USER_TRIGGERS - contain all the triggers created in the user schema
-- USER_PROCEDURES - contain all the procedures created in the user schema
-- USER_CONSTRAINTS - contain all the constraints created in the user schema
-- USER_INDEXES - contain all the indexes created in the user schema
-- USER_TAB_COLUMNS - contain all the columns created in the user schema