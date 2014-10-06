require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"
#We're telling datamapper to use a postgres database on localhost. THe name will be "bookmark_manager"
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link' # this needs to be done after datamapper is initialised

#After declaring your models, you should finalise them
DataMapper.finalize

#However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!

	set :root, File.dirname(__FILE__)
	set :views, File.join(File.dirname(__FILE__), "views")

get '/' do 
	@links = Link.all 
	erb :index
end

post '/links' do 
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
	Link.create(:url => url, :title => title, :tags => tags)
	redirect to('/')
end

get '/tags/:text' do 
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.links : []
	erb :index
end



