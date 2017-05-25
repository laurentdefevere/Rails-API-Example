class WorkoutController < ApplicationController
  def show
    response = select_endpoint
    if response.success?
      parsed_body = JSON.parse(response.body)
      cleaned_json = remove_nil_from_json(parsed_body)
      render json: cleaned_json
    else
      render json: {status: response.status, reason: response.reason_phrase }
    end
  end

  private

  def token
    Token.first
  end

  def remove_nil_from_json(parsed_body)
    parsed_body.map(&:compact)
  end

  def select_endpoint
    if params[:commit] == 'Get Wod'
      ApiService.get_wod(token)
    elsif params[:commit] == 'Get Workout'
      ApiService.get_workout(params[:commit], params[:api_data], token)
    end
  end
end
