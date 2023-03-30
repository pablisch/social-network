require 'post_repository'

RSpec.describe PostRepository do

  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  it "all returns all Post objects in posts table" do
    repo = PostRepository.new
    posts = repo.all
    expect(posts.length).to eq(2)
    expect(posts[0].id).to eq('1')
    expect(posts.first.title).to eq('title_1')
    expect(posts[0].content).to eq('post_1_content')
    expect(posts[0].account_id).to eq('1')
  end

  it "find returns a single object from posts table" do
    repo = PostRepository.new
    id_to_find = 1
    post = repo.find(id_to_find)
    expect(post.id).to eq('1')
    expect(post.title).to eq('title_1')
    expect(post.content).to eq('post_1_content')
    expect(post.account_id).to eq('1')
  end

  it "creates a new Post object" do
    repo = PostRepository.new
    post = Post.new
    post.title = "New title"
    post.content = "New content"
    post.views = "13"
    post.account_id = "1"
    repo.create(post)
    id_to_find = 3
    post = repo.find(id_to_find)
    expect(post.id).to eq('3')
    expect(post.title).to eq('New title')
    expect(post.content).to eq('New content')
    expect(post.views).to eq('13')
    expect(post.account_id).to eq('1')
  end
end