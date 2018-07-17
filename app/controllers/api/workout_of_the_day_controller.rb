class Api::WorkoutOfTheDayController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def get_file
		response = WorkoutOfTheDayApiService.get_file(params[:workout_id], params[:file_format])
		render_response(response)
	end

	def get_wod
		response = WorkoutOfTheDayApiService.get_wod
		render_response(response)
	end

	def get_wod_multiple
		response = WorkoutOfTheDayApiService.get_wod_multiple(params[:number_of_days])
		render_response(response)
	end
end