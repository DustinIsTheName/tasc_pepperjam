class FeedController < ApplicationController
	layout false

	def collection   
		@response = open("https://www.tascperformance.com/collections/xml-google-shopping-feed-all").read

    @response = @response.gsub(/<head>(.|\n)*<\/head>/, '')
    @response = @response.gsub('<body>', '')
    @response = @response.gsub('</body>', '')

    puts @response
	end

end