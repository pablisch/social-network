{{🦠DATABASE : 🦠TABLE }} Model and Repository Classes Design Recipe.

## NOTES:

> Make sure that the {DATABASE NAME} has been entered into the appropriate places in:
> spec_helper.rb > DatabaseConnection.connect('your_database_name_test')

## 1. Design and create the Table

| Record	   | Properties              |
| ---------- | ----------------------- |
| account	   | username, email_address |
| posts  	   | title, content, views   |

🦠 Create the table AND table_test and insert data from seed: 
```bash
psql -h 127.0.0.1

pablo=# CREATE DATABASE music_library
pablo=# CREATE DATABASE music_library_test

psql -h 127.0.0.1 your_database_name < {table_name}.sql
psql -h 127.0.0.1 your_database_name_test < {table_name}.sql
```

## 2. Create Test SQL seeds

-- (file: spec/seeds_{table_name}.sql)
>> spec/seeds_albums.sql

```sql
TRUNCATE TABLE accounts RESTART IDENTITY; -- 🦠 TABLE NAME! 🦠 replace with your own table name.

INSERT INTO accounts (username, email_address) VALUES ('user_1', 'user1@email.com');
INSERT INTO accounts (username, email_address) VALUES ('another_user', 'mail@email.co.uk');
```
```sql
TRUNCATE TABLE posts RESTART IDENTITY; -- 🦠 TABLE NAME! 🦠 replace with your own table name.

INSERT INTO posts (title, content, views, account_id) VALUES ('title_1', 'post_1_content', 10, 1);
INSERT INTO posts (title, content, views, account_id) VALUES ('another_title', 'another_content', 3, 2);
```

To insert this data into your test database => psql -h 127.0.0.1 <your_database_name>_test < seeds_{table_name}.sql

## 3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# model class FILE lib/xxx.rb
class Account
end

# repository class FILE lib/xxx_repository.rb
class AccountRepository
end

# model class FILE lib/yyy.rb
class Post
end

# repository class FILE lib/yyy_repository.rb
class PostRepository
end
```

## 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Account
  attr_accessor :username, :email_address
end

class Post
  attr_accessor :title, :content, :views, :account_id
end
```

## 5. Define the Repository Class interface
```ruby
# 1 repository class FILE lib/xxx_repository.rb
class AccountRepository
# return all xxx objects from table
  def all
    # executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM artists;
    # returns an array of album objects as hashes
  end

# Find and return a single xxx object
  def find(id)
    # executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM artists WHERE id = $1;
    # returns an array of album objects as hashes
  end
end

# Create a new xxx object. Returns nothing
  def create(album)
    # executes the SQL query:
    # INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);
  end

# delete an xxx object identified by id. Returns nothing
  def delete(id)
    # executes the SQL query:
    # DELETE FROM albums WHERE id = $1;
  end

# update an xxx object identified by id. Returns nothing
  def update(album)
    # executes the SQL query:
    # UPDATE albums SET title = $1, release_year = $2 WHERE id = $3;
  end
end
```

## 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.
```ruby
# 1 return all
repo = AccountRepository.new
accounts = repo.all # an array of Albums objects
accounts.length # => 2
accounts.first.id # => '1'
accounts.first.username # => 'user_1'
accounts.first.email_address # => 'user1@email.com'

# 2 find a single xxx by id
repo = AlbumRepository.new
id_to_find = 1
account = repo.find(id_to_find) # an array of xxx objects
account.first.id # => '1'
account.first.username # => 'user_1'

# 3 create new xxx
repo = AlbumRepository.new
account = Album.new
account.username = 'new_user'
account.email_address = 'new@new.com'
repo.create(account)
accounts = repo.all
expect(accounts[-1].username).to eq 'new_user'
expect(accounts[-1].email_address).to eq 'new@new.com'
expect(accounts[-1].id).to eq '3'

# 4 delete xxx
repo = AccountRepository.new
id_to_delete = 1
repo.delete(id_to_delete)
accounts = repo.all # returns an array of all xxx
accounts.length # => 1
accounts[0].id # => '2'

# 5 update xxx
repo = AccountRepository.new
id_to_update = 1
account = repo.find(id_to_update)
account.username = "sameButDifferent"
account.email_address = "folk@gmail.co.uk"
repo.update(account)
updated_account = repo.find(id_to_update)
updated_account.username # => 
updated_account.email_address # => 
```

## 7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.
```ruby
require 'artist_repository'

RSpec.describe ArtistRepository do

  def reset_artists_table # reload method
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_artists_table # reloads for each test
  end

  it "" do # first test
  end
end
```

end

## 8. CHECK:

> That all the relevant requires are in place:
> {table}_repository.rb > require_relative '{table}'
> {table}_repository_spec.rb > require '{table}_repository'
> app.rb > require_relative 'lib/database_connection'
         & require_relative 'lib/{table}_repository'
> spec_helper.rb > database_connection.rb
> database_connection.rb > require 'pg'

## 9. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.