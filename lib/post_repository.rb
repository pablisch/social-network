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
      sql = 'SELECT * FROM posts WHERE id = $1;'
      params = [id]
      results = DatabaseConnection.exec_params(sql, params)
      record = results[0]
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.account_id = record['account_id']
      return post
    end
  
  # Create a new xxx object. Returns nothing
    def create(post)
      sql = 'INSERT INTO posts'
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