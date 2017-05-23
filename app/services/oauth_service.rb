module OauthService
  extend self

  def request_authorization
    conn.get do |req|
      req.url '/Oauth/Authorize'
      req.params = {
        'client_secret': "#{client_secret}",
        'client_id': "#{client_id}",
        'scope': 'metrics:write',
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
        'response_type': 'code'
      }
    end
  end

  def receive_token(authorization_code)
    conn.post do |req|
      req.url '/oauth/token'
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = {
        'client_id': "#{client_id}",
        'grant_type': 'authorization_code',
        'code': authorization_code,
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
        'client_secret': "#{client_secret}"
      }
    end
  end

  private

  def conn
    Faraday.new('https://oauth.sandbox.trainingpeaks.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def client_id
    client_id = 'quantisync'
  end

  def client_secret
    client_secret = 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ'
  end
end
