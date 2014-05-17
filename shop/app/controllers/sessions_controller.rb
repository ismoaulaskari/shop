class SessionsController < ApplicationController
#  before_filter :authenticate, :only => [:create]

    def new
      # renderöi kirjautumissivun
    end

    def create
      @user = User.first(:conditions => { :username => params[:username], :password => params[:password] })

      if @user and @user.username
        flash[:error] = "Welcome back!"
        logger.info("s create #{@user.id} #{@user}")
        session[:user_id] = @user.id
        redirect_to items_path#, flash[:error] = "Welcome back!"
        #redirect_to user_path(user)#, flash[:error] = "Welcome back!"
      else
        #or not user.password == params[:password]
        flash[:error] = "username and password do not match"
        logger.info("s nill user")
        redirect_to signin_path#, flash[:error] = "username and password do not match"      
      end
    end

    def destroy
      logger.info("s destroy")
      # nollataan sessio
      session[:user_id] = nil
      # uudelleenohjataan sovellus pääsivulle 
      redirect_to :root
    end
end
