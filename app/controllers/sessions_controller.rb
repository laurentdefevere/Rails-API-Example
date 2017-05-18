class SessionsController < ApplicationController
  def new
    client = OAuth2::Client.new('quantisync', 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ', :site => 'https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/')
    redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')
  end

  def create
    conn = Faraday.new('https://oauth.trainingpeaks.com/') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    conn.post do |req|
      req.url '/oauth/token'
      req.headers['Content-Type'] = 'application/json'
      req.body = ''
      req.params = {
        'client_secret': 'oo3kiF56PZQtRcIIzHqkZSRxezp3ayVnmmWiSGzdpQ',
        'client_id': 'quantisync',
        'code': params[:code],
        'redirect_uri': 'http://localhost:3000/oauth2/callback',
        'grant_type': 'authorization_code'
      }
    end
    render JSON.parse(response.body)
  end
end

# Last step, is for the application to exchange the authorization code for access token and refresh tokens.
# The application must make an HTTPS POST to  https://oauth.trainingpeaks.com/oauth/token passing the following application/x-www-form-urlencoded parameters:
# client_id: unique application identifier obtained from TrainingPeaks.
# grant_type=authorization_code: must have the value “authorization_code” to exchange the token.
# code: the authorization code in the previous step.
# redirect_uri: This URI must match the redirect_uri used step 1.
# client_secret: the unique client secret obtained from TrainingPeaks. Note: If you are using a library that will include the authentication cookies and headers from the user’s login (i.e. authenticated with the server), passing this parameter is not required.
