get '/users/reset_password' do 
	@user = User.new
	erb :"users/reset_password"
end

post '/users/reset_password' do 
	email = params[:email]
	user = User.first(:email => email)
	if user
		# token = Mailer.create_token
		user.update(:password_token => email,
								:token_time_stamp => Mailer.create_time_stamp)
		Mailer.send_email(user)
		flash[:notice] = "Your new password has been sent to your inbox"
	else
		flash[:notice] = "Sorry, we don't recognise your email address"
	end
	redirect to('/')
end

get '/users/reset_password/:token' do
	user = User.first(:password_token => :password_token)
	raise user
	erb :"users/new_password"
end

post '/users/new_password' do 
	user = User.first(:password_token => :password_token)
	user = User.save(:password => params[:new_password],
							:password_confirmation => params[:new_password_confirmation])
	flash[:notice] = "Your new password has been saved"
	redirect to('/sessions/new')
end


 





