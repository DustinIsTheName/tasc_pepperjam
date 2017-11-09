class Order_CSV

	def self.save_update(params)
		discount_codes = params["discount_codes"] ? params["discount_codes"].map{|x| x["code"]}.join('|') : ""

	  params["line_items"].each do |line_item|
	  	fulfilled_amount = 0;

	  	params["fulfillments"]&.each do |f|
	  		l = f["line_items"].select{|i| i["id"] == line_item["id"]}.first
	  		fulfilled_amount += l["quantity"] if l
	  	end

	  	old_order = Order.where(order_id: params["name"].gsub('#7000', ''), item_id: line_item["sku"]).last
	  	puts Colorize.orange(old_order&.quantity)
	  	puts Colorize.purple(line_item["fulfillable_quantity"] + fulfilled_amount)
	  	if old_order.nil? or old_order.quantity != line_item["fulfillable_quantity"] + fulfilled_amount

		  	order = Order.new
		  	order.program_id = "8671"
				order.order_id = params["name"].gsub('#7000', '')
				order.item_id = line_item["sku"]
				order.item_price = line_item["price"].to_i * (line_item["fulfillable_quantity"] + fulfilled_amount)
				order.quantity = line_item["fulfillable_quantity"] + fulfilled_amount
				order.coupon = discount_codes
				order.uploaded = false

				order.save

			end
	  end
	end

	def self.save_cancel(params)
		discount_codes = params["discount_codes"] ? params["discount_codes"].map{|x| x["code"]}.join('|') : ""

	  params["line_items"].each do |line_item|
	  	order = Order.new
	  	order.program_id = "8671"
			order.order_id = params["name"].gsub('#7000', '')
			order.item_id = line_item["sku"]
			order.item_price = 0
			order.quantity = 0
			order.coupon = discount_codes
			order.uploaded = false

			order.save
	  end
	end

	def self.create_csv
		file = Tempfile.new('8671_transactions_corrected_'+Time.now.strftime('%Y%m%d%H%M%S')+'.csv')

		csv_string = CSV.generate do |writer|
			writer << ["PROGRAM_ID","ORDER_ID","ITEM_ID","ITEM_PRICE","QUANTITY","COUPON"]
			orders_to_upload = Order.where("created_at >= ? and uploaded = ?", (Date.current - 1).beginning_of_day, false)

			if orders_to_upload.size > 0
			  orders_to_upload.each do |order|
			    writer << [order.program_id, order.order_id, order.item_id, order.item_price, order.quantity, order.coupon]
			    order.uploaded = true
			    order.save
			  end
			else
				return false
			end
		end

		file.write(csv_string)

		file
	end

	def self.filename
		'8671_transactions_corrected_'+Time.now.strftime('%Y%m%d%H%M%S')+'.csv'
	end

	def self.send_csv
		csv_file = create_csv
		csv_filename = filename

		if csv_file
			csv_file.close

			puts Colorize.magenta('before connection')

			# ftp = Net::FTP.new('72.47.244.117', 'ftp@sevenfiguresavings.com', 'Sate!1ite')
			# ftp.chdir('/')
			ftp = Net::FTP.new('ftp.affiliatetraction.com', 'tasc_catalog', '?3rF0rM@nce')
			ftp.chdir('/correction')
			ftp.passive = true
			ftp.putbinaryfile(csv_file.path, csv_filename)

			ftp.close

			puts Colorize.cyan('after connection')
		else
			puts Colorize.blue('skipped')
		end
	end
end


















