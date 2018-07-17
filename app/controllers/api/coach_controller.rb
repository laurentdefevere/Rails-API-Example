class Api::CoachController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def get_athletes
		response = CoachApiService.get_athletes
		render_response(response)
	end
	
	def get_coach_profile
		response = CoachApiService.get_coach_profile
		render_response(response)
	end

	def get_assistant_coaches
		response = CoachApiService.get_assistant_coaches
		render_response(response)
	end

	def get_assistant_coach
		response = CoachApiService.get_assistant_coach(params[:assistant_id])
		render_response(response)
	end

	def get_assistant_coach_athletes
		response = CoachApiService.get_assistant_coach_athletes(params[:assistant_id])
		render_response(response)
	end

	def get_zones_for_athlete
		response = CoachApiService.get_zones_for_athlete(params[:athlete_id]);
		render_response(response)
	end

	def get_zones_by_type_for_athlete
		response = CoachApiService.get_zones_by_type_for_athlete(params[:athlete_id], params[:type])
		render_response(response)
	end
end