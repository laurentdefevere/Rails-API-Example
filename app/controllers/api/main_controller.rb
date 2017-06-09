class Api::MainController < ApplicationController
  skip_before_action :validate_token, only: [:new]

  def new; end

  def create
    response = ApiService.post_data(params[:commit], params[:api_data])
    if response.success?
      render json: {status: response.status, body: JSON.parse(response.body) }
    else
      render json: {status: response.status, reason: response.reason_phrase }
    end
  end
end
