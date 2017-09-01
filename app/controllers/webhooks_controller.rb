class WebhooksController < ApplicationController

	skip_before_filter :verify_authenticity_token, :only => [:order_update, :order_cancellation]

	def order_update
		verified = verify_webhook(request.body.read, request.headers["HTTP_X_SHOPIFY_HMAC_SHA256"])

		if verified
			csv_file = Order_CSV.create(params)
			csv_filename = Order_CSV.filename

			csv_file.close

			ftp = Net::FTP.new('ftp.affiliatetraction.com', 'tasc_catalog', '?3rF0rM@nce')
			ftp.chdir('/correction')
			ftp.passive = true
			ftp.putbinaryfile(csv_file.path, csv_filename)

			ftp.close
		end

		head :ok, content_type: "text/html"
	end

	def order_cancellation
		verified = verify_webhook(request.body.read, request.headers["HTTP_X_SHOPIFY_HMAC_SHA256"])

		if verified
			csv_file = Order_CSV.cancel(params)
			csv_filename = Order_CSV.filename

			csv_file.close

			ftp = Net::FTP.new('ftp.affiliatetraction.com', 'tasc_catalog', '?3rF0rM@nce')
			ftp.chdir('/correction')
			ftp.passive = true
			ftp.putbinaryfile(csv_file.path, csv_filename)

			ftp.close
		end

		head :ok, content_type: "text/html"
	end

	private

		def verify_webhook(data, hmac_header)
			digest  = OpenSSL::Digest.new('sha256')
			calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, ENV["WEBHOOK_SECRET"], data)).strip
			if calculated_hmac == hmac_header
				puts Colorize.green("Verified!")
			else
				puts Colorize.red("Invalid verification!")
			end
			calculated_hmac == hmac_header
		end

end