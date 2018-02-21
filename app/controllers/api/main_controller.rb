class Api::MainController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def new; end

	def create
		response = ApiService.post_data(params[:commit], params[:api_data])
		if response.success?
			body = JSON.parse(response.body)
			if body.key?("Structure")
				body["Structure"] = JSON.parse(body["Structure"])
			end
			render json: {status: response.status, body: body}
		else
			render json: {status: response.status, reason: response.reason_phrase }
		end
	end
end
