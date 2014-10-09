require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User forgets password" do 

	before(:each) do 
		@user = User.create(:name => 'test',
								:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	end

	scenario "link exists" do 
		visit '/sessions/new'
		expect(page).to have_content("Forgotten password?")
	end

	scenario "link directs to page with form" do 
		visit '/sessions/new'
		click_link "Forgotten password?"
		expect(current_path).to eq('/users/reset_password')
	end

	scenario "and password reset page contains form for email" do 
		visit '/sessions/new'
		click_link "Forgotten password?"
		expect(current_path).to eq('/users/reset_password')
		expect(page).to have_content("Please enter your email address")
	end

	scenario "and enters an email" do 
		visit '/users/reset_password'
		enter_email('test@test.com')
		expect(page).to have_content("Your new password has been sent to your inbox")
		expect(current_path).to eq('/')
	end

	scenario "and a reset email is sent" do 
		visit '/users/reset_password'
		expect(Mailer).to receive(:send_email).with(@user)
		enter_email('test@test.com')
	end 


	# scenario "and the token is saved in the db" do 
	# 	enter_email
	# 	user = User.first(email: 'test@test.com' )
	# 	expect(user.password_token).to eq('test@test.com')
	# end

end