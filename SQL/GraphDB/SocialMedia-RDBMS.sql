/*
Entities and Relationships:
User

Attributes: user_id (PK), name, email, profile_info, etc.

Post

Attributes: post_id (PK), content, timestamp

Relationship with User: A User can create many Posts (1-to-many relationship).

Comment

Attributes: comment_id (PK), content, timestamp

Relationships:

A User can make many Comments (1-to-many).

A Comment is associated with one Post (many-to-1).

Friendship

Attributes: user_id1 (FK), user_id2 (FK), status (active/pending).

Self-Referencing Relationship for Users: A User can be friends with many other Users (many-to-many relationship). This is implemented via the Friendship table, which is an associative table.
*/

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    profile_info VARCHAR2(255)
);
CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    content VARCHAR2(255),
    timestamp DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content VARCHAR2(255),
    timestamp DATE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE friendships (
    user_id1 INT,
    user_id2 INT,
    status VARCHAR2(20),
    PRIMARY KEY (user_id1, user_id2),
    FOREIGN KEY (user_id1) REFERENCES users(user_id),
    FOREIGN KEY (user_id2) REFERENCES users(user_id)
);

