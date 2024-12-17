-- Active: 1730718376459@@127.0.0.1@5432@postgres@public
-- change column type
ALTER TABLE users 
    ALTER COLUMN username TYPE varchar(50);
-- change column name
ALTER TABLE users 
    RENAME COLUMN username TO username;
-- Change column comment
COMMENT ON COLUMN users.username IS 'comment';