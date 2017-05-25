class OauthController < ApplicationController
  def new
    # This is an example of the oauth flow using the gem 'oauth2-client'
    # client = OAuth2::Client.new(ENV["client_id"], ENV["client_secret"], , :site => "#{ENV["oauth_base_url"]}/Oauth/Authorize")
    # redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')

    request = OauthService.request_authorization
    redirect_to request.env.url.to_s
  end

  def create
    # If using the gem 'oauth2-client' at this stage you would receive the
    # authorization code in the params, as params[:code]
    # client = OAuth2::Client.new(ENV["client_id"], ENV["client_secret"], , :site => "#{ENV["oauth_base_url"]}/Oauth/Authorize")
    # client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')
    # token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/oauth2/callback')
    response = OauthService.receive_token(params[:code])
    parsed_body = JSON.parse(response.env.body, symbolize_names: true)
    parsed_body[:expires_at] = expired_time
    create_update_token(parsed_body)

    redirect_to dashboard_path
  end
  private

  def create_update_token(parsed_body)
    if Token.first.nil?
      token = Token.create(parsed_body)
    else
      Token.first.update(parsed_body)
    end
    Token.first
  end

  def expired_time
    Time.now + 3300
  end

end
