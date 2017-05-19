class Token

  attr_reader :access_token, :token_type, :expires_in, :refresh_token, :scope

  def initialize(attributes)
    @access_token = attributes[:access_token]
    @token_type = attributes[:token_type]
    @expires_in = attributes[:expires_in]
    @refresh_token = attributes[:refresh_token]
    @scope = attributes[:scope]
  end

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
    body_as_json = JSON.parse(response.env.body, symbolize_names: true)
    @access_token = body_as_json[:access_token]
  end

end
