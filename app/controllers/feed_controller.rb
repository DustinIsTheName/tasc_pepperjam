class FeedController < ApplicationController
	layout false

  def collection
    # @response = open("https://www.tascperformance.com/collections/xml-google-shopping-feed-all").read

    # @response = @response.gsub(/<head>(.|\n)*<\/head>/, '')
    # @response = @response.gsub('<body>', '')
    # @response = @response.gsub('</body>', '')

    @shop = Shop.first
    @collection = Collection.first

    @products = Product.all

    # render xml: @products.to_xml

    # icount = 0 
    # xmlfeed = Nokogiri::XML(open("public/xml_feed.xml"))
    # items = xmlfeed.xpath("//item")
    # items.each do |item|
    #   text = item.children.children.first.text  
    #   if ( text =~ /99/ )
    #     icount += 1
    #   end
    # end

    # othercount = xmlfeed.xpath("//totalcount").inner_text.to_i - icount 

    # puts icount
    # puts othercount

    # render :xml => xmlfeed
  end

end