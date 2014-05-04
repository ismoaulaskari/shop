class HomeController < ApplicationController
  before_filter :require_env
  before_filter :authenticate
  def index
    @env = request.env
  end

end
