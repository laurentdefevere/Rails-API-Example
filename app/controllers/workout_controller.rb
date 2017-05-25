class WorkoutController < ApplicationController
  def show
    api_service = ApiService.get_data(params[:commit], params[:api_data], token)
    require 'pry'; binding.pry
  end

  private

  def token
    Token.first
  end
end
