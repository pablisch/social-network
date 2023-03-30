require_relative './post'

class PostRepository
  # return all xxx objects from table
    def all
      sql = 'SELECT * FROM posts;'
      results = DatabaseConnection.exec_params(sql, [])
      posts = []
      results.each do |record|
        post = Post.new
        post.id = record['id']
        post.title = record['title']
        post.content = record['content']
        post.views = record['views']
        post.account_id = record['account_id']
        posts << post
      end
      return posts
    end
  
  # Find and return a single xxx object
    def find(id)
      # executes the SQL query:
      # SELECT id, title, release_year, artist_id FROM artists WHERE id = $1;
      # returns an array of album objects as hashes
    end
  
  # Create a new xxx object. Returns nothing
    def create(post)
      # executes the SQL query:
      # INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);
    end
  
  # delete an xxx object identified by id. Returns nothing
    def delete(id)
      # executes the SQL query:
      # DELETE FROM albums WHERE id = $1;
    end
  
  # update an xxx object identified by id. Returns nothing
    def update(post)
      # executes the SQL query:
      # UPDATE albums SET title = $1, release_year = $2 WHERE id = $3;
    end
  end