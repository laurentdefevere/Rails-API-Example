require 'api_service'

module CoachApiService 
	extend ApiService, self

	Get_Athletes = '/v1/coach/athletes'.freeze
	Get_Athletes_Zones = '/v1/coach/athletes/%<athlete_id>d/zones'.freeze
	Get_Athletes_Zones_By_Type = '/v1/coach/athletes/%<athlete_id>d/zones/%<type>s'.freeze
	Get_Coach_Profile = '/v1/coach/profile'.freeze
	Get_Assistant_Coaches = '/v1/coach/assistants'.freeze
	Get_Assistant_Coach_By_Id = '/v1/coach/assistants/%<assistant_id>d'.freeze
	Get_Assistant_Coach_Athletes_By_Id = '/v1/coach/assistants/%<assistant_id>d/athletes'.freeze

	def get_athletes
		response = conn.get(Get_Athletes)
		response.env
	end
	
	def get_coach_profile
		response = conn.get(Get_Coach_Profile)
		response.env
	end

	def get_assistant_coaches
		response = conn.get(Get_Assistant_Coaches)
		response.env
	end

	def get_assistant_coach(assistant_id)
		response = conn.get(sprintf(Get_Assistant_Coach_By_Id % {assistant_id: assistant_id}))
		response.env
	end

	def get_assistant_coach_athletes(assistant_id)
		response = conn.get(sprintf(Get_Assistant_Coach_Athletes_By_Id % {assistant_id: assistant_id}))
		response.env
	end

	def get_zones_for_athlete(athlete_id)
		response = conn.get(sprintf(Get_Athletes_Zones % {athlete_id: athlete_id}))
		response.env
	end

	def get_zones_by_type_for_athlete(athlete_id, type)
		response = conn.get(sprintf(Get_Athletes_Zones_By_Type % {athlete_id: athlete_id, type: type}))
		response.env
	end
end