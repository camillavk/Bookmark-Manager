require 'sinatra'
require 'data_mapper'
require './lib/link'
require './lib/tag'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

	set :root, File.dirname(__FILE__)
	set :views, File.join(File.dirname(__FILE__), "views")
	enable :sessions
	set :session_secret, 'super secret'

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

get '/users/new' do 
	#note the view is in views/users/new.erb
	#we need the quotes because otherwise
	#ruby would divide the symbol :user by the
	#variable new (which makes no sense)
	erb :"users/new"
end

post '/users' do 
	user = User.create(:email => params[:email],
							:password => params[:password],
							:password_confirmation => params[:password_confirmation])
	session[:user_id] = user.id
	redirect to('/')
end


