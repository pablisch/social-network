require_relative 'lib/database_connection'
require_relative 'lib/account_repository'

DatabaseConnection.connect('social_network')

# account_repository = AccountRepository.new

# account_repository.all.each { |item| p item }
# puts

# new_user = Account.new
# new_user.username = "Pablo"
# new_user.email_address = "fake@email.whatever"

# account_repository.create(new_user)
# account_repository.all.each { |item| p item }
# puts

# ac3 = account_repository.find(3)
# puts

# account_repository.delete(11)
# account_repository.delete(12)
# account_repository.delete(13)
# account_repository.delete(14)
# account_repository.delete(15)
# account_repository.delete(16)
# account_repository.delete(17)
# account_repository.delete(18)
# account_repository.all.each { |item| p item }
# puts

# ac3.username = "Sabina"
# ac3.email_address = "sabby@email.com"

# account_repository.update(ac3)
# account_repository.all.each { |item| p item }
# puts