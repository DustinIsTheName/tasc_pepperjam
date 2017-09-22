class Order_CSV
	def self.create(params)

		file = Tempfile.new('8671_transactions_corrected_'+Time.now.strftime('%Y%m%d%H%M%S')+'.csv')

		csv_string = CSV.generate do |writer|
			writer << ["PROGRAM_ID","ORDER_ID","ITEM_ID","ITEM_PRICE","QUANTITY","COUPON"]
			discount_codes = params["discount_codes"] ? params["discount_codes"].join('|') : ""

		  params["line_items"].each do |line_item|
		    writer << ["8671", params["number"], line_item["sku"], line_item["price"].to_i * line_item["quantity"], line_item["quantity"], discount_codes]
		  end
		end

		file.write(csv_string)

		file
	end

	def self.cancel(params)

		file = Tempfile.new('8671_transactions_corrected_'+Time.now.strftime('%Y%m%d%H%M%S')+'.csv')

		csv_string = CSV.generate do |writer|
			writer << ["PROGRAM_ID","ORDER_ID","ITEM_ID","ITEM_PRICE","QUANTITY","COUPON"]
			discount_codes = params["discount_codes"] ? params["discount_codes"].join('|') : ""

		  params["line_items"].each do |line_item|
		    writer << ["8671", params["number"], line_item["sku"], 0, 0, discount_codes]
		  end
		end

		file.write(csv_string)

		file
	end

	def self.filename
		'8671_transactions_corrected_'+Time.now.strftime('%Y%m%d%H%M%S')+'.csv'
	end
end