class Api::MetricsController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def get_by_date
		response = MetricsApiService.get_metrics_by_date(params[:start_date], params[:end_date])
		render_response(response)
	end

	def get_athlete_by_date
		response = MetricsApiService.get_athlete_metrics_by_date(params[:athleteid], params[:start_date], params[:end_date])
		render_response(response)
	end

	def post_add
		response = MetricsApiService.post_metrics(params)
		render_response(response)
	end
end