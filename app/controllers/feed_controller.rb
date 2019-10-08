class FeedController < ApplicationController
	layout false

  def collection
    # @response = open("https://www.tascperformance.com/collections/xml-google-shopping-feed-all").read

   #  @response = @response.gsub(/<head>(.|\n)*<\/head>/, '')
   #  @response = @response.gsub('<body>', '')
   #  @response = @response.gsub('</body>', '')

    # @shop = Shop.first
    # @collection = Collection.first

    # @products = Product.all

    render :file => 'public/xml_feed.xml'
  end

end