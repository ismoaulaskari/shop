class StaticController < ApplicationController
  def help
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def info
  end

  def feedback
  end

end
