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

  it "returns all Post objects in posts table" do
    repo = PostRepository.new
    p repo
    posts = repo.all
    p posts
    p posts.first
    expect(posts.length).to eq(2)
    expect(posts[0].id).to eq('1')
    expect(posts.first.title).to eq('title_1')
    expect(posts[0].content).to eq('post_1_content')
    expect(posts[0].account_id).to eq('1')
  end
end