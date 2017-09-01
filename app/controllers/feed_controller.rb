class FeedController < ApplicationController
	layout false

	def collection
		@response = open("https://www.tascperformance.com/collections/xml-google-shopping-feed-all").read
	end

end