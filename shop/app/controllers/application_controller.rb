# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :require_login
  USERNAME, PASSWORD = "a", "b"
  before_filter :authenticate

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  private 
  def require_login 
    unless logged_in? 
      request.env.each do |value| 
        logger.info value 
      end
      flash[:error] = "You must be logged in to access this section" 
      #redirect_to new_login_url # halts request cycle 
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end 
  end 

# The logged_in? method simply returns true if the user is logged # in and false otherwise. It does this by "booleanizing" the # current_user method we created previously using a double ! operator. # Note that this is not common in Ruby and is discouraged unless you # really mean to convert something into true or false. 

  def logged_in? 
    if Rails.env.production? then
      request.env['HTTP_X_FORWARDED_HOST'].start_with? 'yourwebhost.com' if request.env['HTTP_X_FORWARDED_HOST'].present? 
    else
      return true
      #request.env['HTTP_REFERER'].start_with? 'http://localhost:3001' if request.env['HTTP_REFERER'].present?
    end
  end

  private 
  def authenticate 
    authenticate_or_request_with_http_basic do |username, password| 
      username == USERNAME && password == PASSWORD
    end 
  end

end
