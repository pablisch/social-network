require_relative './account'

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
    def create(account)
      # executes the SQL query:
      # INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);
    end
  
  # delete an xxx object identified by id. Returns nothing
    def delete(id)
      # executes the SQL query:
      # DELETE FROM albums WHERE id = $1;
    end
  
  # update an xxx object identified by id. Returns nothing
    def update(account)
      # executes the SQL query:
      # UPDATE albums SET title = $1, release_year = $2 WHERE id = $3;
    end
  end