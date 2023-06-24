# Social Network App

## Description

This is a very early Makers Academy project using Ruby and PostgreSQL to create a social network app. It has no UI, not even a command line interface. It is a simple database with a few tables and some methods to interact with it.

## Getting Started

1. Clone this repo to your local machine.
2. Run `bundle install` to install dependencies.
3. Create databases for running and testing the app:
```bash
createdb social_network
createdb social_network_test
```
4. Create and seed the tables:
```bash
psql -h 127.0.0.1 social_network < spec/tables.sql
psql -h 127.0.0.1 social_network_test < spec/tables.sql
psql -h 127.0.0.1 social_network < spec/seeds_accounts.sql
psql -h 127.0.0.1 social_network < spec/seeds_posts.sql
psql -h 127.0.0.1 social_network_test < spec/seeds_accounts.sql
psql -h 127.0.0.1 social_network_test < spec/seeds_posts.sql
```

## Usage

Since there is no UI, including a command line interface, the only way to interact with the app is through the methods in the `lib` folder. 

The app.rb file contains code, mostly commented out that interacts with the database. You can uncomment the code and run `ruby app.rb` to see the results of the selected code.

At time of writing the app.rb file contains uncommeted code that will list all post objects in the termainal.

## Running Tests

Run `rspec` to run the tests.

