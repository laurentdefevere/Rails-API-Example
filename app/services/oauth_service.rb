module OauthService
  extend self

  def request_authorization
    conn.get do |req|
      req.url '/Oauth/Authorize'
      req.params = {
        'client_secret': ENV["client_secret"],
        'client_id': ENV["client_id"],
        'scope': ENV["scopes"],
        'redirect_uri': ENV["redirect_uri"],
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
        'redirect_uri': ENV["redirect_uri"],
        'client_secret': ENV["client_secret"]
      }
    end
  end

  private

  def conn
    ssl_verify = true
    if Rails.env.test?
      ssl_verify = false
    end
    Faraday.new(ENV["oauth_base_url"], :ssl => {:verify => ssl_verify}) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def token
   Token.first
  end
end
