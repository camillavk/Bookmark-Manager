get '/users/reset_password' do 
	@user = User.new
	erb :"users/reset_password"
end

post '/users/reset_password' do 
	email = params[:email]
	user = User.first(:email => email)
	if user
		token = create_token
		user.update(:password_token => token,
			:token_time_stamp => create_time_stamp)
		send_email(user, token)
		flash[:notice] = "Your new password has been sent to your inbox"
		redirect to('/')
	end
end




def create_token
	(1..64).map{('A'..'Z').to_a.sample}.join
end	

def create_time_stamp
	Time.now
end

