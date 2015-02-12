class Comment
	attr_accessor :name, :date, :body
	def initialize(name, date, body)
		@name = name
		@date = date
		@body = body 
	end
end
