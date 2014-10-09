require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User adds a new link" do 

	before(:each) do 
		User.create(:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	end

	scenario "when browsing the homepage" do 
		expect(Link.count).to eq(0)
		visit '/'
		add_link("http://www.makersacademy.com/", "Makers Academy")
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.url).to eq("http://www.makersacademy.com/")
		expect(link.title).to eq("Makers Academy")
	end

	scenario "with a few tags" do 
		visit '/'
		add_link("http://wwww.makersacademy.com/",
			"Makers Academy",
			['education', 'ruby'])
		link = Link.first
		expect(link.tags.map(&:text)).to include("education")
		expect(link.tags.map(&:text)).to include("ruby")
	end

	scenario "and it saves them as the author" do 
		visit '/'
		sign_in('test@test.com', 'test')
		add_link("http://www.google.com/",
						"Google",
						['search'])
		link = Link.first
		expect(link.user).to eq("3")
	end

	def add_link(url, title, tags = [])
			visit 'links/new' 
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			fill_in 'tags', :with => tags.join(' ')
			click_button 'Add link'
	end
end