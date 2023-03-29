require_relative './account'

class AccountRepository
# return all xxx objects from table
  def all
    sql = 'SELECT * FROM accounts;'
    results = DatabaseConnection.exec_params(sql, [])
    # p results
    accounts = []
    results.each do |record|
      # p record
      account = Account.new
      account.id = record['id']
      account.username = record['username']
      account.email_address = record['email_address']
      accounts << account
    end
    return accounts
  end

# Find and return a single xxx object
  def find(id)
    sql = 'SELECT * FROM accounts WHERE id = $1'
    params = [id]
    results = DatabaseConnection.exec_params(sql, params)

    record = results[0]
    
    account = Account.new
    account.id = record['id']
    account.username = record['username']
    account.email_address = record['email_address']
    return account
  end

# Create a new xxx object. Returns nothing
  def create(account)
    sql = 'INSERT INTO accounts (username, email_address) VALUES ($1, $2);'
    params = [account.username, account.email_address]
    DatabaseConnection.exec_params(sql, params)
  end

# delete an xxx object identified by id. Returns nothing
  def delete(id)
    sql = 'DELETE FROM accounts WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end

# update an xxx object identified by id. Returns nothing
  def update(account)
    sql = 'UPDATE accounts SET username = $1, email_address = $2 WHERE id = $3;'
    params = [account.username, account.email_address, account.id]
    DatabaseConnection.exec_params(sql, params)
  end
end