require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String
	# this will store both the password and the salt
	# it's text and not string because string holds
	# 50 characters by default
	# and it's not enough for the hash and the salt
	property :password_digest, Text

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password

# when assigned the password, we don't store it directly,
# insted we generate a password digest and save it in the
# database. 
	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end
	
end