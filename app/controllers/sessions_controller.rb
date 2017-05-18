class SessionsController < ApplicationController
  def new
    redirect_to "https://oauth.sandbox.trainingpeaks.com/OAuth/Authorize/?response_type=code&client_id=quantisync&scope=metrics:write&redirect_uri=https://localhost:3000"
  end
end
