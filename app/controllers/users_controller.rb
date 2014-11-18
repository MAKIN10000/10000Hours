# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    id = params[:id]
    if(!@current_user.nil?)
      @user = User.find(id)
      unless @current_user == @user
        flash[:warning] = "you do not have permission!!"
        redirect_to home_index_path
      end
    else
      flash[:warning] = "You must login to do that!"
      redirect_to login_path
    end
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
        #signup = UserNotifier.send_signup_email(@user)
        #signup.deliver
        flash[:success] = "Welcome #{@user.user_id}. Your account has been created."
        redirect_to login_path
      else
        flash[:warning] = user.errors.full_messages.first 
        redirect_to new_user_path
      end
    end
  end

end
