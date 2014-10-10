post '/links' do 
	user = User.create(:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
	description = params["description"].to_s
	if user
		@user = session[:user_name]
	else
		@user = nil
	end
	Link.create(:url => url, :title => title, :tags => tags, :description => description, :user => @user)
	redirect to('/')
end

get '/links/new' do 
	erb :"links/new"
end


	