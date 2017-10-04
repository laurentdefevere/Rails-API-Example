module ApiService
	extend self

	self::ENDPOINTS = {
		'Post Metric' => 'v1/metrics',
		'Post File' => '/v1/file',
		'Post Plan' => 'v1/workouts/plan',
		'Post Event' => '/v1/events',
		'Get Workout' => "/v1/workouts",
		'Get Athlete Workout' => "/v1/workouts",
		'Get Wod' => "/v1/workouts/wod//#{Time.now.strftime("%Y-%m-%d")}",
		'Get Event' => "/v1/events",
		'Get File' => "/v1/workouts/wod/file",
		'Get Athletes' => "/v1/coach/athletes",
		'Get Profile' => "/v1/athlete/profile",
		'Get Athlete Workouts Since' => '/v1/workouts/changes',
		'Get Workouts Since' => '/v1/workouts/changes',
		'Get Coach Profile' => '/v1/coach/profile',
	}

	def post_data(api_action, post_data)
		response = conn.post do |req|
			req.url ENDPOINTS[api_action]
			params = {}
			params["UploadClient"] = ENV["client_id"]
			load_api_data_into_req(post_data, params)
			req.body = params.to_json
		end
		puts response.inspect;
		response.env
	end

	def get_workout(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:start_date]}/#{get_data[:end_date]}")
		response.env
	end

	def get_next_event(get_data)
		response = conn.get("#{ENDPOINTS['Get Event']}/next")
		response.env
	end

	def get_event_by_date(get_data)
		response = conn.get("#{ENDPOINTS['Get Event']}/#{get_data[:date]}")
		response.env
	end

	def get_athlete_workout(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:athleteid]}/#{get_data[:start_date]}/#{get_data[:end_date]}")
		response.env
	end

	def get_wod
		response = conn.get("#{ENDPOINTS['Get Wod']}")
		puts response.inspect
		response.env
	end

	def get_wods(get_data)
		response = conn.get("#{ENDPOINTS['Get Wod']}?numberOfDays=#{get_data[:number_of_days]}");
		response.env
	end

	def get_file(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:workout_id]}") do |req|
			req.params["format"] = get_data[:file_format]
		end
		response.env
	end

	def get_athletes
		response = conn.get(ENDPOINTS['Get Athletes'])
		response.env
	end
	
	def get_coach_profile
		response = conn.get(ENDPOINTS['Get Coach Profile'])
		response.env
	end
	
	def get_profile
		response = conn.get(ENDPOINTS['Get Profile'])
		response.env
	end

	def get_workout_since(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:since_date]}?pageSize=#{get_data[:page_size]}&page=#{get_data[:page]}")
		response.env
	end

	def get_athlete_workout_since(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:athleteid]}/#{get_data[:since_date]}?pageSize=#{get_data[:page_size]}&page=#{get_data[:page]}")
		response.env
	end

	private

	def conn
		puts token.inspect
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
