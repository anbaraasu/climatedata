-- Authoe: Anbu
/*
-- DDL for Amazome website

Customer				
ID	Name	DOB	EMAILID	MobileNumber



Address								
ID	Address1	Address2	Landmark	zipcode	city	state	country	Customer_ID

*/

CREATE TABLE Customer
(
    ID NUMBER(10) NOT NULL,
    Name VARCHAR2(50) NOT NULL,
    DOB DATE NOT NULL,
    EmailID VARCHAR2(50) NOT NULL,
    MobileNumber VARCHAR2(15) NOT NULL,
    PRIMARY KEY (ID)
);

-- MALE/FEMALE/OTHERS 

-- mem 1,000,000,000,000,000 * 1 

-- mem 1,000,000,000,000,000 * 5 

-- CHAR(1) - Male, Female,  Others
ALTER TABE Customer ADD GENDER CHAR(1);

CREATE TABLE Address
(
    ID NUMBER(10) NOT NULL,
    Address1 VARCHAR2(100) NOT NULL,
    Address2 VARCHAR2(100),
    Landmark VARCHAR2(50),
    Zipcode VARCHAR2(10) NOT NULL,
    City VARCHAR2(50) NOT NULL,
    State VARCHAR2(50) NOT NULL,
    Country VARCHAR2(50) NOT NULL,
    Customer_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(ID)
);