require 'api_service'

module AthleteApiService 
	extend ApiService, self

	Get_Profile = 'v1/athlete/profile'.freeze
	Get_Zones = 'v1/athlete/profile'.freeze
	Get_Zones_By_Type = 'v1/athlete/%<type>s'.freeze

	def get_profile
		response = conn.get(Get_Profile)
		response.env
	end

	def get_zones
		response = conn.get(Get_Zones)
		response.env
	end

	def get_zones_by_type(type)
		response = conn.get(sprintf(Get_Zones_By_Type % {type: type}))
		response.env
	end
end