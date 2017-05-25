module OauthService
  extend self

  def request_authorization
    conn.get do |req|
      req.url '/Oauth/Authorize'
      req.params = {
        'client_secret': ENV["client_secret"],
        'client_id': ENV["client_id"],
        'scope': ENV["scopes"],
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
        'client_id': ENV["client_id"],
        'grant_type': 'authorization_code',
        'code': authorization_code,
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
        'client_secret': ENV["client_secret"]
      }
    end
  end

  private

  def conn
    Faraday.new(ENV["oauth_base_url"]) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

end
