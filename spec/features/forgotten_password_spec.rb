require 'spec_helper'
require_relative 'helpers/session'
# require_relative './app/models/mailer'

include SessionHelpers

feature "User forgets password" do 

	before(:each) do 
		@user = User.create(:email => "test@test.com",
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

	scenario "and the token is saved in the db" do 
		# enter_email('test@test.com')
		# expect(Mailer).to receive(:create_token)
		enter_email
		user = User.first(email: 'test@test.com' )
		expect(user.password_token).to eq('test@test.com')
	end

  # scenario 'fills out reset form' do
  #   token = send_email(user)
  #   new_password = 'newpassword!'
  #   new_password_confirmation = 'newpassword!'
  #   visit '/users/reset_password(:token => token)'
  #   fill_in :password, :with => params[:new_password]
  #   fill_in :password_confirmation, :with => params[:new_password_confirmation]
  #   click_button 'Change my password'
  #   expect(page).to have_content('Your password was changed successfully. You are now signed in.')
  # end


end