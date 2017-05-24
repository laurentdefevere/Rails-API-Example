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
        "DateTime": date_time_to_utc(api_data[:date_time]),
        "UploadClient": ENV["client_id"],
        "Appetite": api_data[:metrics][:Appetite]
      }
      req.body = req.params.to_json
    end
  end

  private

  def date_time_to_utc(date_time)
    date_time.to_datetime.utc
  end
end
