# This classs corresponds to a table in the database
# WE can use it to manipulate the data
class Link

	# This makes the instances of this class Datamapper resources
	include DataMapper::Resource 

	# This block describes what resources our model will have
	property :id,			Serial #Serial means that it will be auto-incremented for every record
	property :title,	String
	property :url,		String

	has n, :tags, :through => Resource

end

class Tag

	include DataMapper::Resource

	has n, :links, :through => Resource

	property :id, Serial
	property :text, String

end