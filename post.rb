class Post
	attr_accessor :title, :url, :points, :item_id
	def initialize(title, url, points, item_id)
		@title = title
		@url = url
		@points = points
		@item_id = item_id
		@comments = []
	end

	def comments
		return @comments
	end

	def add_comment(comment)
		@comments << comment
	end
end

