module ApiService
	extend self

	self::ENDPOINTS = {
		'Post Metric' => 'v1/metrics',
		'Get Metrics' => 'v1/metrics',
		'Get Metrics For Athlete' => 'v1/metrics',
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
		'Get Assistant Coaches' => '/v1/coach/assistants',
		'Get Zones' => '/v1/athlete/profile/zones',
		'Get Workout By Id' => '/v1/workouts',
		'Get Workout Mean Maxes' => '/v1/workouts/id',
		'Get Workout Details' => '/v1/workouts/id',
		'Get Athlete Workout Mean Maxes' => '/v1/workouts',
		'Get Workout Time In Zones' => '/v1/workouts/id',
		'Get Athlete Workout Time In Zones' => '/v1/workouts'
	}

	def post_data(api_action, post_data)
		response = conn.post do |req|
			req.url ENDPOINTS[api_action]
			params = {}
			params["UploadClient"] = ENV["client_id"]
			load_api_data_into_req(post_data, params)
			req.body = params.to_json
		end
		response.env
	end

	def get_workout(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:start_date]}/#{get_data[:end_date]}")
		response.env
	end

	def get_metrics(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:start_date]}/#{get_data[:end_date]}");
		response.env
	end

	def get_athlete_metrics(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:athleteid]}/#{get_data[:start_date]}/#{get_data[:end_date]}");
		response.env
	end

	def get_workout_by_id(api_action, get_data)
		puts "#{ENDPOINTS[api_action]}/#{get_data[:id]}".inspect
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:id]}")
		response.env
	end

	def get_workout_meanmaxes(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:id]}/meanmaxes")
		response.env
	end

	def get_athlete_workout_meanmaxes(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:athleteid]}/id/#{get_data[:id]}/meanmaxes")
		response.env
	end

	def get_details(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:id]}/details")
		puts response.inspect
		response.env
	end

	def get_workout_timeinzones(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:id]}/timeinzones")
		response.env
	end

	def get_athlete_workout_timeinzones(api_action, get_data)
		response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:athleteid]}/id/#{get_data[:id]}/timeinzones")
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

	def get_assistant_coaches
		response = conn.get(ENDPOINTS['Get Assistant Coaches'])
		response.env
	end

	def get_assistant_coach(api_action, get_data)
		response = conn.get("#{ENDPOINTS['Get Assistant Coaches']}/#{get_data[:assistant_id]}")
		response.env
	end

	def get_assistant_coaches_atheltes(api_action, get_data)
		response = conn.get("#{ENDPOINTS['Get Assistant Coaches']}/#{get_data[:assistant_id]}/athletes")
		response.env
	end
	
	def get_profile
		response = conn.get(ENDPOINTS['Get Profile'])
		response.env
	end

	def get_zones
		response = conn.get(ENDPOINTS['Get Zones'])
		response.env
	end

	def get_zones_for_athlete(api_action, get_data)
		response = conn.get("#{ENDPOINTS['Get Athletes']}/#{get_data[:athleteid]}/zones")
		response.env
	end

	def get_zones_by_type(api_action, get_data)
		response = conn.get("#{ENDPOINTS['Get Zones']}/#{get_data[:type]}")
		response.env
	end

	def get_zones_by_type_for_athlete(api_action, get_data)
		response = conn.get("#{ENDPOINTS['Get Athletes']}/#{get_data[:athleteid]}/zones/#{get_data[:type]}")
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
