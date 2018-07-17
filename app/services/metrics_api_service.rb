require 'api_service'

module MetricsApiService 
	extend ApiService, self

	Post_Metrics = 'v1/metrics'.freeze
	Metrics_By_Date = "/v1/metrics/%<start_date>s/%<end_date>s".freeze
	Athlete_Metrics_By_Data = "/v1/metrics/%<athlete_id>d/%<start_date>s/%<end_date>s".freeze

	def post_metrics( post_data)
		response = conn.post do |req|
			req.url Post_Metrics
			params = {}
			params["UploadClient"] = ENV["client_id"]
			load_api_data_into_req(post_data, params)
			req.body = params.to_json
		end
		response.env
	end

	def get_metrics_by_date(start_date, end_date)
		response = conn.get(sprintf(Metrics_By_Date % {start_date: start_date, end_date: end_date}));
		response.env
	end

	def get_athlete_metrics_by_date(athlete_id, start_date, end_date)
		response = conn.get(sprintf(Athlete_Metrics_By_Data % {athlete_id: athlete_id, start_date: start_date, end_date: end_date}));
		response.env
	end
end
