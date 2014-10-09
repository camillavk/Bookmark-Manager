require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :name, String, :required => true,
		:messages => {
			:presence => "We won't know who you are if you don't give us your name!"
		}
	property :email, String, :required => true, :unique => true, :format => :email_address,
	 :messages => {
	 	:presence => "We need your email addres",
	 	:is_unique => "This email is already taken",
	 	:format => "Doesn't look like an email address to me..."
	 		}
	# this will store both the password and the salt
	# it's text and not string because string holds
	# 50 characters by default
	# and it's not enough for the hash and the salt
	property :password_digest, Text, :required => true
	property :password_token, Text
	property :token_time_stamp, String

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password, :message => "Sorry, your passwords don't match"

	# attr_reader :new_password
	# attr_accessor :new_password_confirmation

	# validates_confirmation_of :new_password, :message => "Sorry, your passwords don't match"
	# validates_uniqueness_of :email



# when assigned the password, we don't store it directly,
# insted we generate a password digest and save it in the
# database. 
	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def new_password=(new_password)
		@new_password = new_password
		self.password_digest = BCrypt::Password.
		create(new_password)
	end

	def self.authenticate(email, password)
		user = first(:email => email)
		#if this user exists and the password provided matches
		#the one we have password_digest for, everything's fine.

		#The password.new returns an object that overrides the ==
		#method. Instead of comparing two passwords directly
		#(which is impossible because we only have a one-way hash)
		#the == method calculates the candidate password_digest from
		#the password given and compares it to the password_digest
		#it was initialised with.
		#To recap: THIS IS NOT A STRING COMPARISON
		if user && BCrypt::Password.new(user.password_digest) == password 
			#return this user
			user
		else
			nil
		end
	end
	
end