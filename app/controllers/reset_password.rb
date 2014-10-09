get '/users/reset_password' do 
	erb :"users/reset_password"
end

post '/users/reset_password' do 
	email = params[:email]
	user = User.first(:email => email)
	if user
		token = Mailer.create_token
		# user.password_token = email,
		# user.token_time_stamp = Mailer.create_time_stamp
		# user.save
		user.password_token = token
		user.token_time_stamp = Mailer.create_time_stamp
		# user.save(:password_token => email,
		# 						:token_time_stamp => Mailer.create_time_stamp)

		user.save

		Mailer.send_email(user)
		flash[:notice] = "Your new password has been sent to your inbox"
	else
		flash[:notice] = "Sorry, we don't recognise your email address"
	end
	redirect to('/')
end

get '/users/reset_password/:token' do
	user = User.first(:password_token => :password_token)
	# raise user
	erb :"users/new_password"
end

post '/users/new_password' do 
	user = User.first(:password_token => :password_token)
	p params[:new_password]
	p params[:new_password_confirmation]
	if 
		params[:new_password] == params[:new_password_confirmation]
	user = User.update(:password => params[:new_password],
							:password_confirmation => params[:new_password_confirmation])
	else
		flash[:notice] = "Your passwords did't match...please start again"
		redirect to('/')
	end
	flash[:notice] = "Your new password has been saved"
	redirect to('/sessions/new')
end


 





