require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'colorize'
require_relative 'post.rb'
require_relative 'comment.rb'

class Scraper

	def self.start(doc)
		title = doc.search('.title').map {|element| p element.inner_text}
		url = ARGV[0]
		p url
		points = doc.search('.subtext > span:first-child').map { |span| p span.inner_text}
		user_id = doc.search('.subtext > a:nth-child(3)').map {|link| p link['href'] }
		@post = Post.new(title, url, points, user_id)
		Scraper.scrape_for_comments(doc)
	end

	def self.scrape_for_comments(doc)
		counter = 0
		array = []
		author = []
		date = []
		body = []
		author = doc.css('.comhead > a:first-child').map { |element| element.text}
		date = doc.css('.comhead > a:nth-child(2)').map { |element| element.text}
		body = doc.css('.comment > font:first-child').map { |element| element.text}
		while counter < author.length
			array << [author[counter], date[counter], body[counter]]
			counter += 1
		end
		Scraper.printing(array)
	end
		
	def self.printing(array)
			array.each do |x,y,z|
			puts x.red
			puts y.blue
			puts z
			comment = Comment.new(x,y,z)
			@post.add_comment(comment)
		end
	end
end

@url = ARGV[0]
doc = Nokogiri::HTML(File.open(@url))
 #check unicode options, print unicode

Scraper.start(doc)


