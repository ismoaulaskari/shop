# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :admin?, :adminonly, :current_user, :logged_in?
  USERNAME, PASSWORD = "a", "b"
  before_filter :require_env
#  before_filter :authenticate
  layout "application"

  #no stored user accounts so just disposable userid tracking
  #could email user with userid and checksum
  private
  def track_session
    if session[:user_id].nil?
      @user = User.create
      session[:user_id] = @user.id
      logger.info("a track create user and session #{session[:user_id]}")
    end
    logger.info("a track session exists #{session[:user_id]}")
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  private 
  def require_env 
    unless authorized? 
      request.env.each do |value| 
        logger.info value 
      end
      flash[:error] = "You must be logged in to access this section" 
      #redirect_to new_login_url # halts request cycle 
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end 
  end 

# The logged_in? method simply returns true if the user is logged # in and false otherwise. It does this by "booleanizing" the # current_user method we created previously using a double ! operator. # Note that this is not common in Ruby and is discouraged unless you # really mean to convert something into true or false. 
  def authorized? 
    if Rails.env.production? then
      request.env['HTTP_X_FORWARDED_HOST'].start_with? 'yourwebhost.com' if request.env['HTTP_X_FORWARDED_HOST'].present? #CONFIGURE THIS! 
    else
      return true
      #request.env['HTTP_REFERER'].start_with? 'http://localhost:3001' if request.env['HTTP_REFERER'].present?
    end
  end

  def current_user
    return nil if session[:user_id].nil? 
     logger.info("a try find session #{session[:user_id]}")
    @current_user = User.find(session[:user_id])
    rescue Exception
  end

  private 
  def authenticate 
    #redirect_to signin_path, flash[:error] = 'you should be signed in' if current_user.nil?
    if session[:user_id]
      logger.info("a try find session #{session[:user_id]}")
      @current_user = User.find session[:user_id]
    else
      logger.info("auth fail #{session[:user_id]}")
      flash[:error] = 'you should be signed in'
      redirect_to signin_path 
    end
  end

  def admin? 
    @current_user = current_user
    @current_user and @current_user.username == 'admin'    
  end

  def adminonly
    admin? or redirect_to signin_path
  end

end
