require './app/models/link'
require './app/models/tag'
require './app/models/user'

env = ENV["RACK_ENV"] || "development"
#We're telling datamapper to use a postgres database on localhost. THe name will be "bookmark_manager"
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/bookmark_manager_development')

#{"postgres://lpenudetaoyzar:tmGzdzN_KKWem0bRAGl2RZ6IYc@ec2-54-204-43-139.compute-1.amazonaws.com:5432/das4rcsild029d")
#{}"postgres://localhost/bookmark_manager_#{env}"}

 # this needs to be done after datamapper is initialised

#After declaring your models, you should finalise them
DataMapper.finalize

#However, the database tables don't exist yet. Let's tell datamapper to create them
# DataMapper.auto_upgrade!
