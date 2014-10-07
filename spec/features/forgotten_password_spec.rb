require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User forgets password" do 

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

end