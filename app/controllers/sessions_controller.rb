# This file is app/controllers/users_controller.rb
class SessionsController < ApplicationController
    before_filter :set_current_user
  def new
    #render 'new' template
  end
  def create
    user = User.find_by_user_id(params[:user][:user_id])
    if( not user.nil?) && ( user.authenticate params[:user][:password] )
      session[:session_token] = user.session_token
      flash[:success] = "Logged in"
      redirect_to home_index_path
    else
      flash[:warning] = "Login failed"
      redirect_to login_path
    end
  end   
  def createfb
    user = User.omniauth(env['omniauth.auth'])
    session[:session_token] = user.session_token
    redirect_to home_index_path
  end

  def destroy
    session[:session_token] = nil 
    flash[:success] = "Logout Successful"
    redirect_to home_index_path
  end

end
