class SessionsController < ApplicationController
    def new
      # renderöi kirjautumissivun
    end

    def create
      user = User.all(:conditions => { :username => params[:username], :password => params[:password] })

      if user.nil? #or not user.password == params[:password]
logger.info("s nill user")
        redirect_to :back#, flash[:error] = "username and password do not match"
      else
logger.info("s create #{user.id} #{user}")
        session[:user_id] = user.id
        redirect_to items_path#, flash[:error] = "Welcome back!"
        #redirect_to user_path(user)#, flash[:error] = "Welcome back!"
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
