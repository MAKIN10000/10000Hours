# This file is app/controllers/users_controller.rb
class SessionsController < ApplicationController
  def new
    #render 'new' template
  end
  def create
    user = User.find_by_user_id(params[:user][:user_id])
    if( not user.nil?) && ( user.authenticate params[:user][:password] )
      session[:session_token] = user.session_token
      redirect_to home_index_path
    else
      flash[:warning] = "Login failed"
      redirect_to login_path
    end
  end   
  def createfb
    auth = request.env['omniauth.auth']
    user = User.omniauth(auth)
    user.update_attributes(:token => auth["credentials"]["token"])
    session[:session_token] = user.session_token
    redirect_to user_path(user)
  end
  def destroy
    session[:session_token] = nil 
    flash[:notice] = "Logout Successful"
    redirect_to home_index_path
  end

end
