module ApiService
  extend self

  self::ENDPOINTS = {
    'Post Metric' => 'v1/metrics',
    'Post File' => '/v1/file',
    'Get Workout' => "/v1/workouts",
    'Get Wod' => "/v1/workouts/wod/#{Time.now.strftime("%Y-%m-%d")}",
    'Get File' => "/v1/workouts/wod/file"
  }

  def conn
    Faraday.new(ENV["api_base_url"]) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def post_data(api_action, api_data, token)
    response = conn.post do |req|
      req.url ENDPOINTS[api_action]
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{token.access_token}"
      req.params = { "scope": ENV["scopes"], "UploadClient": ENV["client_id"] }
      load_api_data_into_req(api_data, req)
      req.body = req.params.to_json
    end
    response.env
  end

  def get_workout(api_action, api_data, token)
    response = Faraday.get("#{ENV["api_base_url"]}#{ENDPOINTS[api_action]}/#{api_data[:start_date]}/#{api_data[:end_date]}") do |req|
      req.headers["Authorization"] = "Bearer #{token.access_token}"
      req.params = { "scope": ENV["scopes"] }
    end
    response.env
  end

  def get_wod(token)
    response = Faraday.get("#{ENV["api_base_url"]}#{ENDPOINTS['Get Wod']}") do |req|
      req.headers["Authorization"] = "Bearer #{token.access_token}"
      req.params = { "scope": ENV["scopes"] }
    end
    response.env
  end

  def get_file(api_action, api_data, token)
    response = Faraday.get("#{ENV["api_base_url"]}#{ENDPOINTS[api_action]}/#{api_data[:workout_id]}") do |req|
      req.headers["Authorization"] = "Bearer #{token.access_token}"
      req.params = { "scope": ENV["scopes"], "format": api_data[:file_format] }
    end
    response.env
  end

  private

  def load_api_data_into_req(api_data, req)
    api_data.each_pair do |key, value|
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
end
