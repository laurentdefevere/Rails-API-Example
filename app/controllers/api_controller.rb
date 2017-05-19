class ApiController < ApplicationController
  before_action :validate_token, only: [:create]

  def new; end

  def create
    conn = Faraday.new("https://api.sandbox.trainingpeaks.com") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    response = conn.post do |req|
      req.url "/v1/metrics"
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{token.access_token}"
      req.params = {
        "scope": "metrics:write",
        "DateTime": DateTime.now.utc,
        "UploadClient": params[:upload_client],
        "Appetite": params[:appetite]
      }
      req.body = req.params.to_json
    end
    redirect_to new_post_path
  end

  private

  def validate_token
    if token.expired?
      token.refresh
    end
  end

  def token
    Token.first
  end
end
# pryhodatest2
