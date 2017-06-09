class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :validate_token
  helper_method :current_token

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
