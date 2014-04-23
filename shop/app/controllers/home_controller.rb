class HomeController < ApplicationController
  def index
    @env = request.env
  end

end
