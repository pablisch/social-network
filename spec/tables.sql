DROP TABLE IF EXISTS accounts; 

-- Table Definition
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    username text,
    email_address varchar
);

DROP TABLE IF EXISTS posts;

-- Table Definition
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title text,
    content text,
    views int,
    account_id int
);