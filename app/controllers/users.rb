get '/users/new' do 
	@user = User.new
	#note the view is in views/users/new.erb
	#we need the quotes because otherwise
	#ruby would divide the symbol :user by the
	#variable new (which makes no sense)
	erb :"users/new"
end

post '/users' do 
	@user = User.new(:email => params[:email],
							:password => params[:password],
							:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end