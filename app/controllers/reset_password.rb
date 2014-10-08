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
		send_email(user)
		flash[:notice] = "Your new password has been sent to your inbox"
	else
		flash[:notice] = "Sorry, we don't recognise your email address"
	end
	redirect to('/')
end






def create_token
	(1..64).map{('A'..'Z').to_a.sample}.join
end	

def create_time_stamp
	Time.now
end

def send_email(user)
  RestClient.post "https://api:key-b7bce9032df9bb87220aa96a4ce7f9e4"\
  "@api.mailgun.net/v2/sandbox552f08dacc5e4423ac3ba9a9c1a6fa01.mailgun.org/messages",
  :from => "Bookmark Manager <bookmarks@email.com>",
  :to => user.email,
  :subject => "Password Reset",
  :text => "Hi, #{user.email}. You requested a password reset. Please click on the link to reset your password.
  					http://localhost:9292/users/reset_password/<%= user.token %>
  					If you did not request a password reset please ignore this message. Kind regards"
end

