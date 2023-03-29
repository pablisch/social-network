Multi Table Design Recipe Template
Copy this recipe template to design and create two related database tables from a specification.

## 1. Extract nouns from the user stories or specification

As a social network user,
So I can have my information registered,
I'd like to have a [user account] with my [email address].

As a social network user,
So I can have my information registered,
I'd like to have a user account with my [username].

As a social network user,
So I can write on my timeline,
I'd like to create [posts] associated with my [user account].

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a [title] and a [content].

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a [number of views].

> Nouns: user_account, email_address, username, posts, title, content, number_of_views

> Nouns: user_account => username, email_address
> Nouns: posts => title, content, views

## 2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

| Record	   | Properties              |
| ---------- | ----------------------- |
| account	   | username, email_address |
| posts  	   | title, content, views   |

## 3. Decide the column types.
Here's a full documentation of [PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

## 4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No) ---> If YES, TABLE TWO will have a foreign key relating to TABLE ONE
Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No) ---> If YES, TABLE ONE will have a foreign key relating to TABLE TWO
If YES to both then it is a many-to-many relationship

## 5. Write the SQL.
-- EXAMPLE
-- file: albums_table.sql

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username TEXT,
  email_address TEXT
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT,
  content TEXT,
  views INT,
-- The foreign key name is always {other_table_singular}_id
  account_id int,
  constraint fk_account foreign key(account_id)
    references accounts(id)
    on delete cascade
);
## 6. Create the table.
psql -h 127.0.0.1 database_name < account_table.sql