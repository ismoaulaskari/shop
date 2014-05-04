class SessionsController < ApplicationController
    def new
      # renderöi kirjautumissivun
    end

    def create
      user = User.all(:conditions => { :username => params[:username], :password => params[:password] })
      session[:user_id] = user.id if not user.nil?

      if user.nil? #or not user.password == params[:password]
        redirect_to :back#, flash[:error] = "username and password do not match"
      else
        session[:user_id] = user.id
        redirect_to user_path(user)#, flash[:error] = "Welcome back!"
      end

    end

    def destroy
      # nollataan sessio
      session[:user_id] = nil
      # uudelleenohjataan sovellus pääsivulle 
      redirect_to :root
    end
end
