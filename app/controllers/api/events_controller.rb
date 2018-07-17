class Api::EventsController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def post_add
		response = EventsApiService.post_add(params)
		render_response(response)
	end

	def get_next_event
		response = EventsApiService.get_next_event
		render_response(response)
	end

	def get_by_date
		response = EventsApiService.get_by_date(params[:date])
		render_response(response)
	end
end