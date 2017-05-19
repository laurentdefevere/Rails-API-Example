class PostController < ApplicationController
  # before_action
  def new; end

  def create
    conn = Faraday.new('https://api.sandbox.trainingpeaks.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    response = conn.post do |req|
      req.url '/v1/metrics'
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{$token.access_token}"
      req.params = {
        'scope': 'metrics:write',
        'DateTime': DateTime.parse(params.keys[2]).utc,
        'UploadClient': params[:upload_client],
        'Appetite': params[:appetite]
      }
      req.body = req.params.to_json
    end
    require 'pry'; binding.pry
  end
end
# pryhodatest2
