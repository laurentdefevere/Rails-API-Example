class Api::MainController < ApplicationController
  before_action :validate_token, only: [:create]

  def create
    response = ApiService.post_data(params[:commit], params[:api_data])
    if response.success?
      render json: {status: response.status, body: JSON.parse(response.body) }
    else
      render json: {status: response.status, reason: response.reason_phrase }
    end
  end

  private

  def validate_token
    if token.expired?
      token.refresh
    end
  end

  def token
    Token.first
  end

end
