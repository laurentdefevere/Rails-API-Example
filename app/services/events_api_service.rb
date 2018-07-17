require 'api_service'

module EventsApiService 
	extend ApiService, self

	Get_Next_Event = 'v1/events/next'.freeze
	Get_Event_By_Date = 'v1/events/%<date>s'.freeze
	Post_Event = 'v1/events'.freeze

	def post_add(post_data)
		response = conn.post do |req|
			req.url Post_Event
			params = {}
			params["UploadClient"] = ENV["client_id"]
			load_api_data_into_req(post_data, params)
			req.body = params.to_json
		end
		puts response.inspect
		response.env
	end

	def get_next_event
		response = conn.get(Get_Next_Event)
		response.env
	end

	def get_by_date(date)
		response = conn.get(sprintf(Get_Event_By_Date % {date: date}))
		response.env
	end

end