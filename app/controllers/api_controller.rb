class ApiController < ApplicationController
  before_action :validate_token, only: [:create]

  def new
    @token = token
  end

  def create
    api_service = select_correct_action[params[:commit]]
    # require 'pry'; binding.pry
    if api_service.success?
      redirect_to new_post_path
    else
      render status: 400
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

  def select_correct_action
    {
      'Post File' => ApiService.post_file(params[:api_data], token),
      'Post Metric' => ApiService.post_metrics(params[:api_data], token)
    }
  end
end
