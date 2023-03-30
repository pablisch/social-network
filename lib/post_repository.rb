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
      sql = 'INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4);'
      params = [post.title, post.content, post.views, post.account_id]
      DatabaseConnection.exec_params(sql, params)
    end
  
  # delete an xxx object identified by id. Returns nothing
    def delete(id)
      sql = 'DELETE FROM posts WHERE id = $1;'
      params = [id]
      DatabaseConnection.exec_params(sql, params)
    end
  
  # update an xxx object identified by id. Returns nothing
    def update(post)
      sql = ('UPDATE posts SET title = $1, content = $2, views = $3, account_id = $4 WHERE id = $5;')
      params = [post.title, post.content, post.views, post.account_id, post.id]
      DatabaseConnection.exec_params(sql, params)
    end
  end