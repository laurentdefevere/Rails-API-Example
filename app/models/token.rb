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
        'client_id': ENV['client_id'],
        'client_secret': ENV['client_secret'],
        'grant_type': 'refresh_token',
        'refresh_token': self.refresh_token,
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
      }
    end
    parsed_body = JSON.parse(response.env.body, symbolize_names: true)
    parsed_body[:expires_at] = expired_time
    self.update(parsed_body)
  end

  def expired?
    if Time.now >= self.expires_at
      true
    else
      false
    end
  end

  def expired_time
    Time.now + 3300
  end
end
