class Api::FilesController < ApplicationController
	skip_before_action :validate_token, only: [:new]

	def post_add
		response = FilesApiService.post_files(params)
		render_response(response)
	end
end