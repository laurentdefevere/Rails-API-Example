class Api::AthleteController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def get_profile
		response = AthleteApiService.get_profile
		render_response(response)
	end

	def get_zones
		response = AthleteApiService.get_zones
		render_response(response)
	end

	def get_zones_by_type
		response = AthleteApiService.get_zones_by_type(params[:type])
		render_response(response)
	end
end