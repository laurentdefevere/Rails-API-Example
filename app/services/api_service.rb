module ApiService
  extend self

  def conn
    Faraday.new(ENV["base_api_url"]) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def post_metrics(api_data, token)
    conn.post do |req|
      req.url "/v1/metrics"
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{token.access_token}"
      req.params = {
        "scope": ENV["permissions"],
        "UploadClient": ENV["client_id"]
      }
      load_api_data_into_req(api_data, req)
      req.body = req.params.to_json
    end
  end

  private

  def load_api_data_into_req(api_data, req)
    api_data.each_pair do |metric, value|
      if metric.downcase == "datetime"
        req.params[metric] = value.to_datetime.utc
      elsif metric_ints.include?(metric.downcase)
        req.params[metric] = value.to_i
      elsif metric_floats.include?(metric.downcase)
        req.params[metric] = value.to_f
      else
        req.params[metric] = value
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
