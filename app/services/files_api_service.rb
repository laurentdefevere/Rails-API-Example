require 'api_service'

module FilesApiService 
	extend ApiService, self

	Post_Files = 'v1/file'.freeze

	def post_files( post_data)
		response = conn.post do |req|
			req.url Post_Files
			params = {}
			params["UploadClient"] = ENV["client_id"]
			load_api_data_into_req(post_data, params)
			req.body = params.to_json
		end
		response.env
	end
end