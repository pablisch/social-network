require 'account_repository'

RSpec.describe AccountRepository do
  
  def reset_accounts_table
    seed_sql = File.read('spec/seeds_accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_accounts_table
  end

  it "returns all Account objects" do
    repo = AccountRepository.new
    accounts = repo.all # an array of Account objects
    expect(accounts.length).to eq(2) # => 2
    expect(accounts.first.id).to eq('1') # => '1'
    expect(accounts.first.username).to eq('user_1') # => 'user_1'
    expect(accounts.first.email_address).to eq('user1@email.com') # => 'user1@email.com'
  end

  it "returns all Account objects" do
    repo = AccountRepository.new
    accounts = repo.all # an array of Account objects
    expect(accounts.length).to eq(2) # => 2
    expect(accounts[1].id).to eq('2') # => '1'
    expect(accounts[1].username).to eq('another_user') # => 'user_1'
    expect(accounts[1].email_address).to eq('mail@email.co.uk') # => 'user1@email.com'
  end
  
  it "returns a single Account objects when searched by id" do
    repo = AccountRepository.new
    id_to_find = 1
    account = repo.find(id_to_find)
    expect(account.id).to eq('1')
    expect(account.username).to eq('user_1') 
    expect(account.email_address).to eq('user1@email.com') 
  end

  it "returns a single Account objects when searched by id" do
    repo = AccountRepository.new
    id_to_find = 2
    account = repo.find(id_to_find)
    expect(account.id).to eq('2')
    expect(account.username).to eq('another_user') 
    expect(account.email_address).to eq('mail@email.co.uk') 
  end

  it "creates a new Account object" do
    repo = AccountRepository.new
    account = Account.new
    account.username = 'new_user'
    account.email_address = 'new@new.com'
    repo.create(account)
    accounts = repo.all
    expect(accounts[-1].id).to eq('3')
    expect(accounts[-1].username).to eq('new_user') 
    expect(accounts[-1].email_address).to eq('new@new.com') 
  end

  it "delete an Account object" do
    repo = AccountRepository.new
    id_to_delete = 1
    repo.delete(id_to_delete)
    accounts = repo.all
    expect(accounts[0].id).to eq('2')
    expect(accounts[0].username).to eq('another_user') 
    expect(accounts[0].email_address).to eq('mail@email.co.uk') 
  end

  it "delete an Account object" do
    repo = AccountRepository.new
    id_to_delete = 2
    repo.delete(id_to_delete)
    accounts = repo.all
    expect(accounts[-1].id).to eq('1')
    expect(accounts[-1].username).to eq('user_1') 
    expect(accounts[-1].email_address).to eq('user1@email.com') 
  end

  it "updates an Account object" do
    repo = AccountRepository.new
    id_to_update = 1
    account = repo.find(id_to_update)
    account.username = 'old_user'
    account.email_address = 'old@new.com'
    repo.update(account)
    updated_account = repo.find(id_to_update)
    expect(updated_account.username).to eq('old_user') 
    expect(updated_account.email_address).to eq('old@new.com') 
  end
end