class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :validate_token
	helper_method :current_token

	def render_response(response)
		if response.success?
			if params[:commit] == 'Get File' && params[:file_format] != 'json'
				filename = "#{params[:workout_id]}.#{params[:file_format]}"
				send_data(response.body, :disposition => 'attachment', :filename => filename)				
			else
				render body: response.body
			end
		else
			render json: {status: response.status, reason: response.reason_phrase  }
		end
	end

	private

	def validate_token
		if current_token.expired?
			current_token.refresh
		end
	end

	def current_token
		Token.first
	end
end
