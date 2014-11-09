# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    id = params[:id] 
    @user = User.find(id)
  end

  def new
    #render 'new' template
  end

  def create
    if User.exists?({:user_id => params[:user][:user_id]})
        flash[:warning] = "User ID exists, please choose another"
        redirect_to new_user_path
    else
      user = User.new(params[:user])
      if user.valid?
        @user = User.create_user! params[:user]
        flash[:success] = "Welcome #{@user.user_id}. Your account has been  created."
        redirect_to login_path
      else
        flash[:warning] = user.errors.full_messages.first 
        redirect_to new_user_path
      end
    end
  end

end
