class LinkController < ApplicationController
  skip_before_action :validate_token, only: [:new]
  def new; end
end
