/*
Tables have columns (fields) and rows (records).
*/

----------------------------------------------------------------
-- 				Database / User Management 					  --
----------------------------------------------------------------
-- Create a database if it doesn't exist
CREATE DATABASE IF NOT EXISTS my_database;

-- Delete a database
DROP DATABASE IF EXISTS my_database;

-- Create a user with password
CREATE USER IF NOT EXISTS 'my_user'@'%' IDENTIFIED BY 'mypassword';

-- Delete a user
DROP USER IF EXISTS 'my_user'@'%';

-- Grant privileges to a user on a database
GRANT ALL PRIVILEGES ON my_database.* TO 'my_user'@'%';

-- Revoke privileges
REVOKE ALL PRIVILEGES ON my_database.* FROM 'my_user'@'%';

-- Change root password
ALTER USER 'root'@'localhost' IDENTIFIED BY 'newpassword';

-- Apply changes
FLUSH PRIVILEGES;


----------------------------------------------------------------
-- 						Table Operations 					  --
----------------------------------------------------------------
-- Create a table
CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),

	post_author INT NOT NULL,
    FOREIGN KEY (post_author) REFERENCES users(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Delete a table
DROP TABLE IF EXISTS users;

-- Insert data
INSERT INTO users (username, password) VALUES ('alice', 'secret');

-- Insert multiple rows
INSERT INTO users (username, password) VALUES 
    ('bob', 'pass1'),
    ('carol', 'pass2');

-- Update rows
UPDATE users SET password='newpass' WHERE username='alice';

-- Delete rows
DELETE FROM users WHERE username='bob';

-- Select rows
SELECT * FROM users;
SELECT username FROM users WHERE id=1;
SELECT COUNT(*) FROM users;

-- Alter table (add/remove columns)
ALTER TABLE users ADD COLUMN email VARCHAR(100);
ALTER TABLE users DROP COLUMN email;

----------------------------------------------------------------
-- 				Basic Queries & Clauses 					  --
----------------------------------------------------------------
-- Filter rows
SELECT * FROM users WHERE username='alice';
SELECT user_login, user_email FROM wp_users WHERE ID = 2;

-- Order rows
SELECT * FROM users ORDER BY created_at DESC;

-- Limit results
SELECT * FROM users LIMIT 10;

-- Join tables
SELECT orders.id, users.username
FROM orders
JOIN users ON orders.user_id = users.id;

-- Grouping
SELECT COUNT(*), user_id FROM orders GROUP BY user_id;

-- Aggregate functions
SELECT MAX(id), MIN(id), AVG(id) FROM users;

----------------------------------------------------------------
-- RUN: mysql -u root -p < my_init.sql