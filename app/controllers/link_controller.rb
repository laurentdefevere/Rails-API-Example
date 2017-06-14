class LinkController < ApplicationController
  skip_before_action :validate_token
  def new; end
end
