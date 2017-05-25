class WorkoutController < ApplicationController
  def show
    response = select_endpoint
    if response.success?
      render json: response.body
    else
      render json: {status: response.status, reason: response.reason_phrase, message: JSON.parse(response.body) }
    end
  end

  private

  def token
    Token.first
  end

  def select_endpoint
    if params[:commit] == 'Get Wod'
      ApiService.get_wod(token)
    elsif params[:commit] == 'Get Workout'
      ApiService.get_workout(params[:commit], params[:api_data], token)
    elsif params[:commit] == 'Get File'
      ApiService.get_file(params[:commit], params[:api_data], token)
    end
  end
end
