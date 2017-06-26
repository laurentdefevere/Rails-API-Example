module ApiService
  extend self

  self::ENDPOINTS = {
    'Post Metric' => 'v1/metrics',
    'Post File' => '/v1/file',
    'Post Plan' => 'v1/workouts/plan',
    'Get Workout' => "/v1/workouts",
    'Get Wod' => "/v1/workouts/wod/#{Time.now.strftime("%Y-%m-%d")}",
    'Get File' => "/v1/workouts/wod/file",
    'Get Athletes' => "/v1/coach/athletes"
  }

  def post_data(api_action, post_data)
    response = conn.post do |req|
      req.url ENDPOINTS[api_action]
      req.params["UploadClient"] = ENV["client_id"]
      load_api_data_into_req(post_data, req)
      req.body = req.params.to_json
    end
    response.env
  end

  def get_workout(api_action, get_data)
    response = conn.get("#{ENDPOINTS[api_action]}/#{get_data[:start_date]}/#{get_data[:end_date]}")
    response.env
  end

  def get_wod
    response = conn.get("#{ENDPOINTS['Get Wod']}")
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

  private

  def conn
    Faraday.new(ENV["api_base_url"]) do |faraday|
      faraday.request :url_encoded
      faraday.headers["Content-Type"] = "application/json"
      faraday.headers["Authorization"] = "Bearer #{token.access_token}"
      faraday.params = { "scope": token.scope }
      faraday.adapter Faraday.default_adapter
    end
  end

  def load_api_data_into_req(post_data, req)
    post_data.each_pair do |key, value|
      if key.downcase == "datetime"
        req.params[key] = value.to_datetime.utc
      elsif metric_ints.include?(key.downcase)
        req.params[key] = value.to_i
      elsif metric_floats.include?(key.downcase)
        req.params[key] = value.to_f
      elsif key.downcase == 'data'
        req.params[key] = Base64.encode64(value)
      else
        req.params[key] = value
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
