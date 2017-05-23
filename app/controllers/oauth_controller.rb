class OauthController < ApplicationController
  def new
    # client = OAuth2::Client.new(<client_id goes here>, <client_secret goes here>, :site => 'https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/')
    # redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')

    request = OauthService.request_authorization
    redirect_to request.env.url.to_s
  end

  def create
    # client = OAuth2::Client.new(<client_id goes here>, <client_secret goes here>, :site => 'https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/')
    # client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')
    # token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/oauth2/callback')

    response = OauthService.receive_token(params[:code])
    parsed_body = JSON.parse(response.env.body, symbolize_names: true)
    create_update_token(parsed_body)

    redirect_to new_post_path
  end

  private

  def create_update_token(parsed_body)
    if Token.first.nil?
      token = Token.create(parsed_body)
      token.update(expires_at: expired_time)
    else
      Token.first.update(parsed_body)
      Token.first.update(expires_at: expired_time)
    end
    Token.first
  end

  def expired_time
    Time.now + 3300
  end

end
