class Token < ApplicationRecord

  def refresh
    conn = Faraday.new('https://oauth.sandbox.trainingpeaks.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    response = conn.post do |req|
      req.url '/oauth/token'
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = {
        'client_id': 'quantisync',
        'client_secret': 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ',
        'grant_type': 'refresh_token',
        'refresh_token': refresh_token,
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
      }
    end
    parsed_body = JSON.parse(response.env.body, symbolize_names: true)
    @access_token = parsed_body[:access_token]
  end

  def expired?
    if Time.now == self.expires_at
      true
    else
      false
    end
  end
end
