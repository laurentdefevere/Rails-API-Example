class OauthController < ApplicationController
  def new
    # client = OAuth2::Client.new('quantisync', 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ', :site => 'https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/')
    # redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')

    conn = Faraday.new('https://oauth.sandbox.trainingpeaks.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    request = conn.get do |req|
      req.url '/Oauth/Authorize'
      req.params = {
        'client_secret': 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ',
        'client_id': 'quantisync',
        'scope': 'metrics:write',
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
        'response_type': 'code'
      }

    end
    redirect_to request.env.url.to_s
  end

  def create
    # client = OAuth2::Client.new('quantisync', 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ', :site => 'https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/')
    # client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')
    # token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/oauth2/callback')

    conn = Faraday.new('https://oauth.sandbox.trainingpeaks.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    response = conn.post do |req|
      req.url '/oauth/token'
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = {
        'client_id': 'quantisync',
        'grant_type': 'authorization_code',
        'code': params[:code],
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
        'client_secret': 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ'
      }
    end
    body_as_json = JSON.parse(response.env.body, symbolize_names: true)
     
    $token = Token.new(body_as_json)

    redirect_to new_post_path
  end
end
