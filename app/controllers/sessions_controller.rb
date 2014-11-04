# This file is app/controllers/users_controller.rb
class SessionsController < ApplicationController
    before_filter :set_current_user
  def new
    #render 'new' template
  end

  def login

    redirect_to home_index_path
  end

  def create
    if( User.where("user_id = ?", params[:user][:user_id]).first != nil )
      user = User.find_by_user_id(params[:user][:user_id])
      if( user.authenticate params[:user][:password] )
        session[:session_token] = user.session_token
        flash[:notice] = "Logged in"
        redirect_to home_index_path
        return
      else
        flash[:warning] = "Login failed"
      end
    end
    flash[:warning] = "Login failed"
    redirect_to home_index_path
  end   





def create2
   if User.exists?({:user_id => params[:user][:user_id]})
      @user = User.find_by_user_id(params[:user][:user_id])
      if @user.authenticate(params[:user][:password])
        session[:session_token] = @user.session_token
        flash[:warning] = "Welcome #{@user.user_id}"
        redirect_to home_index_path
      else
        flash[:warning] = "Incorrect email address"
        redirect_to home_index_path
      end
   else
      flash[:notice] = "Incorrect Login"
      redirect_to home_index_path
   end
  end

  def destroy
    session[:session_token] = nil 
    flash[:notice] = "Logout Successful"
    redirect_to home_index_path
  end

end
