module ApiService
  extend self

  def conn
    Faraday.new("https://api.sandbox.trainingpeaks.com") do |faraday|
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
        "scope": "metrics:write",
        "DateTime": date_time_to_utc(api_data[:date_time]),
        "UploadClient": api_data[:upload_client],
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
