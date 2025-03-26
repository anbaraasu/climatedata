/*

Name           Null?    Type          
-------------- -------- ------------- 
ID             NOT NULL NUMBER        
ATHLETE_NAME   NOT NULL VARCHAR2(255) 
ATHLETE_GENDER NOT NULL VARCHAR2(10)  




Name       Null?    Type   
---------- -------- ------ 
ID         NOT NULL NUMBER 
ATHLETE_ID NOT NULL NUMBER 
GAME_ID    NOT NULL NUMBER 
NATION_ID  NOT NULL NUMBER 




Name          Null?    Type         
------------- -------- ------------ 
ID            NOT NULL NUMBER       
DISCIPLINE_ID NOT NULL NUMBER       
EVENT         NOT NULL VARCHAR2(60) 




Name       Null?    Type         
---------- -------- ------------ 
ID         NOT NULL NUMBER       
SPORT_ID   NOT NULL NUMBER       
DISCIPLINE NOT NULL VARCHAR2(30) 



Name          Null?    Type        
------------- -------- ----------- 
ID            NOT NULL NUMBER      
BASE_EVENT_ID NOT NULL NUMBER      
EVENT_GENDER  NOT NULL VARCHAR2(1) 




Name   Null?    Type         
------ -------- ------------ 
ID     NOT NULL NUMBER       
YEAR   NOT NULL NUMBER       
SEASON NOT NULL VARCHAR2(10) 
CITY   NOT NULL VARCHAR2(30) 




Name            Null?    Type         
--------------- -------- ------------ 
ID              NOT NULL NUMBER       
EVENT_ID        NOT NULL NUMBER       
ATHLETE_GAME_ID NOT NULL NUMBER       
MEDAL           NOT NULL VARCHAR2(10) 




Name   Null?    Type        
------ -------- ----------- 
ID     NOT NULL NUMBER      
NATION NOT NULL VARCHAR2(3) 




Name  Null?    Type         
----- -------- ------------ 
ID    NOT NULL NUMBER       
SPORT NOT NULL VARCHAR2(30) 
*/

-- CREATE ALL TABLES

-- Create table ATHLETE
CREATE TABLE ATHLETE (
    ID NUMBER NOT NULL,
    ATHLETE_NAME VARCHAR2(255) NOT NULL,
    ATHLETE_GENDER VARCHAR2(10) NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table ATHLETE_GAME
CREATE TABLE ATHLETE_GAME (
    ID NUMBER NOT NULL,
    ATHLETE_ID NUMBER NOT NULL,
    GAME_ID NUMBER NOT NULL,
    NATION_ID NUMBER NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table EVENT
CREATE TABLE EVENT (
    ID NUMBER NOT NULL,
    DISCIPLINE_ID NUMBER NOT NULL,
    EVENT VARCHAR2(60) NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table DISCIPLINE
CREATE TABLE DISCIPLINE (
    ID NUMBER NOT NULL,
    SPORT_ID NUMBER NOT NULL,
    DISCIPLINE VARCHAR2(30) NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table BASE_EVENT
CREATE TABLE BASE_EVENT (
    ID NUMBER NOT NULL,
    BASE_EVENT_ID NUMBER NOT NULL,
    EVENT_GENDER VARCHAR2(1) NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table GAME
CREATE TABLE GAME (
    ID NUMBER NOT NULL,
    YEAR NUMBER NOT NULL,
    SEASON VARCHAR2(10) NOT NULL,
    CITY VARCHAR2(30) NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table RESULT
CREATE TABLE RESULT (
    ID NUMBER NOT NULL,
    EVENT_ID NUMBER NOT NULL,
    ATHLETE_GAME_ID NUMBER NOT NULL,
    MEDAL VARCHAR2(10) NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table NATION
CREATE TABLE NATION (
    ID NUMBER NOT NULL,
    NATION VARCHAR2(3) NOT NULL,
    PRIMARY KEY (ID)
);

-- Create table SPORT
CREATE TABLE SPORT (
    ID NUMBER NOT NULL,
    SPORT VARCHAR2(30) NOT NULL,
    PRIMARY KEY (ID)
);