# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_filter :set_current_user
  def index
    @users = Users.all
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
        flash[:notice] = "User ID exists, please choose another"
        redirect_to new_user_path
    else
      @user = User.create_user! params[:user]
      flash[:notice] = "Welcome #{@user.user_id}. Your account has been  created."
      redirect_to login_path

    end
  end

end
