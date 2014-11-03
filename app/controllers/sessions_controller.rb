# This file is app/controllers/users_controller.rb
class SessionsController < ApplicationController
  def new
    #render 'new' template
  end

  def create
   if User.exists?({:user_id => params[:user][:user_id]})
      @user = User.find_by_user_id(params[:user][:user_id])
      if @user.email == params[:user][:email]
        session[:session_token] = @user.session_token
        flash[:warning] = "Welcome #{@user.user_id}"
        redirect_to movies_path
      else
        flash[:warning] = "Incorrect email address"
        redirect_to login_path
      end
   else
      flash[:notice] = "Incorrect Login"
      redirect_to login_path
   end
  end
  def destroy
    reset_session 
    flash[:notice] = "Logout Successful"
    redirect_to movies_path
  end

end
