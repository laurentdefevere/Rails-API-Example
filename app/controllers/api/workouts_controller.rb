class Api::WorkoutsController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def get_by_date
		response = WorkoutsApiService.get_by_date(params[:start_date], params[:end_date])
		render_response(response)
	end

	def get_athlete_by_date
		response = WorkoutsApiService.get_athlete_workout(params[:athleteid], params[:start_date], params[:end_date])
		render_response(response)
	end

	def get_by_id
		response = WorkoutsApiService.get_by_id(params[:id])
		render_response(response)
	end

	def get_athlete_by_id
		response = WorkoutsApiService.get_athlete_by_id(params[:athleteid], params[:id])
		render_response(response)
	end

	def delete_by_id
		response = WorkoutsApiService.delete_workout(params[:id])
		render_response(response)
	end

	def get_meanmaxes
		response = WorkoutsApiService.get_meanmaxes(params[:id])
		render_response(response)
	end

	def get_athlete_meanmaxes
		response = WorkoutsApiService.get_athlete_meanmaxes(params[:athleteid], params[:id])
		render_response(response)
	end

	def get_details
		response = WorkoutsApiService.get_details(params[:id])
		render_response(response)
	end

	def get_athlete_details
		response = WorkoutsApiService.get_athlete_details(params[:id])
		render_response(response)
	end

	def get_timeinzones
		response = WorkoutsApiService.get_timeinzones(params[:id])
		render_response(response)
	end

	def get_athlete_timeinzones
		response = WorkoutsApiService.get_athlete_timeinzones(params[:athleteid], params[:id])
		render_response(response)
	end

	def get_since
		response = WorkoutsApiService.get_since(params[:since_date], params[:page_size], params[:page])
		render_response(response)
	end

	def get_athlete_since
		response = WorkoutsApiService.get_athlete_since(params[:athleteid], params[:since_date], params[:page_size], params[:page])
		render_response(response)
	end

	def post_add
		response = WorkoutsApiService.post_plan(params)
		render_response(response)
	end

	def post_update
		response = WorkoutsApiService.put_plan(params)
		render_response(response)
	end
end