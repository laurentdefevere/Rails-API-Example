class WorkoutController < ApplicationController
  def show
    api_service = ApiService.get_data(params[:commit], params[:api_data], token)
    if api_service.success?
      parsed_body = JSON.parse(api_service.body)
      cleaned_json = remove_nil_from_json(parsed_body)
      render json: cleaned_json
    else
      render json: {status: api_service.status, reason: api_service.reason_phrase }
    end
  end

  private

  def token
    Token.first
  end

  def remove_nil_from_json(parsed_body)
    parsed_body.map(&:compact)
  end
end
