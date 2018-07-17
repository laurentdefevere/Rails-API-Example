module ApiService
	extend self

	protected

	def conn
		ssl_verify = true
		if Rails.env.test?
			ssl_verify = false
		end
		Faraday.new(ENV["api_base_url"], :ssl => {:verify => ssl_verify}) do |faraday|
			faraday.request :url_encoded
			faraday.options[:timeout] = 300
			faraday.headers["Content-Type"] = "application/json"
			faraday.headers["Authorization"] = "Bearer #{token.access_token}"
			faraday.adapter Faraday.default_adapter
		end
	end

	def load_api_data_into_req(post_data, params)
		post_data.each_pair do |key, value|
			next if value.blank?

			if key.downcase == "datetime"
				params[key] = value.to_datetime.utc
			elsif metric_ints.include?(key.downcase)
				params[key] = value.to_i
			elsif metric_floats.include?(key.downcase)
				params[key] = value.to_f
			elsif key.downcase == 'data'
				params[key] = Base64.encode64(value.read)
				params["filename"] = value.original_filename
			else
				params[key] = value
			end
		end
	end

	def metric_ints
		%w(diastolic pulse steps systolic).freeze
	end

	def metric_floats
		%w(bmi hrv musclemass numbertimeswoken percentfat sleepelevationinmeters sleephours spo2 timeindeepsleep timeinlightsleep timeinremsleep totaltimeawake waterpercent weightinkilograms).freeze
	end

	def token
		Token.first
	end
end
