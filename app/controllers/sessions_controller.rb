class SessionsController < ApplicationController
  def new
    client = OAuth2::Client.new('quantisync', 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ', :site => 'https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/')
    redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')
    # require 'pry'; binding.pry
    # # => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

    # token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:8080/oauth2/callback', :headers => {'Authorization' => 'Basic some_password'})
    # response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
    # response.class.name
    # => OAuth2::Response
    # redirect_to "https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/?response_type=code&client_id=quantisync&scope=metrics:write&redirect_uri=http://localhost:3000"
  end

  def create
    # conn = Faraday.post
    # require 'pry'; binding.pry
  end

# Last step, is for the application to exchange the authorization code for access token and refresh tokens. The application must make an HTTPS POST to  https://oauth.trainingpeaks.com/oauth/token passing the following application/x-www-form-urlencoded parameters:
# client_id: unique application identifier obtained from TrainingPeaks.
# grant_type=authorization_code: must have the value “authorization_code” to exchange the token.
# code: the authorization code in the previous step.
# redirect_uri: This URI must match the redirect_uri used step 1.
# client_secret: the unique client secret obtained from TrainingPeaks. Note: If you are using a library that will include the authentication cookies and headers from the user’s login (i.e. authenticated with the server), passing this parameter is not required.
end
