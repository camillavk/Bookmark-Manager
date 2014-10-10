# This classs corresponds to a table in the database
# WE can use it to manipulate the data
class Link

	# This makes the instances of this class Datamapper resources
	include DataMapper::Resource 

	has n, :tags, :through => Resource

	# This block describes what resources our model will have
	property :id,						Serial #Serial means that it will be auto-incremented for every record
	property :title,				String, :required => true,
		:messages => {
			:presence => "How will you remember the page if you don't give it a title?"
		}
	property :url,					String, :required => true, 
		:messages => {
			:presence => "It's hard to bookmark a page without a URL!"
		}
	property :description, 	Text
	# property :user,					String

end