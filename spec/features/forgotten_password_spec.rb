require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User forgets password" do 

	before(:each) do 
		User.create(:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	end

	scenario "password link exists" do 
		visit '/sessions/new'
		expect(page).to have_content("Forgotten password?")
	end

	scenario "password link directs to page with form" do 
		visit '/sessions/new'
		click_link "Forgotten password?"
		expect(current_path).to eq('/users/reset_password')
	end

	scenario "password reset page contains form for email" do 
		visit '/sessions/new'
		click_link "Forgotten password?"
		expect(current_path).to eq('/users/reset_password')
		expect(page).to have_content("Please enter your email address")
	end

	# scenario "entering email shows you a notice" do 
	# 	visit '/users/reset_password'
	# 	enter_email('test@test.com')

	# 	# expect(current_path).to eq('/users/users/reset_password')
	# 	expect(page).to have_content("Your new password has been sent to your inbox")
	# end

	scenario "enters an email" do 
		visit '/users/reset_password'
		enter_email('test@test.com')
		expect(page).to have_content("Your new password has been sent to your inbox")
		expect(current_path).to eq('/')
	end

end