class Api::RetrieveController < ApplicationController
  def show
    response = select_endpoint
    if response.success?
      render json: response.body
    else
      render json: {status: response.status, reason: response.reason_phrase  }
    end
  end

  private

  def select_endpoint
    if params[:commit] == 'Get Wod'
      ApiService.get_wod
    elsif params[:commit] == 'Get Workout'
      ApiService.get_workout(params[:commit], params[:api_data])
    elsif params[:commit] == 'Get File'
      ApiService.get_file(params[:commit], params[:api_data])
    end
  end
end
