# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    if(!@current_user.nil? && @current_user.role == "admin")
      @users = User.all.order(:user_id)
    else
      flash[:warning] = "You must be an admin to view that!!"
      redirect_to home_index_path
    end
  end

  def show
    id = params[:id]
    if(!@current_user.nil?)
      @user = User.find(id)
      unless @current_user == @user || @current_user.role == "admin"
        flash[:warning] = "you do not have permission!!"
        redirect_to home_index_path
      end
      if(@user.provider == 'facebook')
        graph = Koala::Facebook::API.new(@user.token)
        puts(graph.get_connections("me","friends"))
        puts("here are your friends!>>>>>>>>>>>>>>>>>>>>>>>>>>")
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
        UserNotifier.send_signup_email(@user).deliver!
        flash[:success] = "Welcome #{@user.user_id}. Your account has been created."
        redirect_to login_path
      else
        flash[:warning] = user.errors.full_messages.first 
        redirect_to new_user_path
      end
    end
  end

  def destroy
    if (!@current_user.nil? && @current_user.role == 'admin')
      @user = User.find(params[:id])
      if(@user.destroy)
        flash[:notice] = "#{@user.user_id} deleted."
        redirect_to users_path
      else
        flash[:notice] = "Could not delete user"
        redirect_to users_path
      end
    else
      flash[:warning] = "You must be an admin to do that!!"
      redirect_to home_index_path
    
    end
  end
  def update
    @user = User.find params[:id]
    @hash = {}
    params[:user].each do |key, value|
      unless(value.nil? || value == ''|| key == 'role')
        @hash[key] = value
      end
      if(key == 'role' && !@current_user.nil? && @current_user.role == 'admin')
        @hash[key] = value
      end
    end
    if(@current_user == @user || @current_user.role == "admin")
      if(@user.update(@hash))
        flash[:notice] = "Updates Successful!"
        redirect_to user_path(@user)
      else
        flash[:notice] = "Oops something went wrong!"
        redirect_to user_path(@user)
      end
    else
      flash[:warning] = "You must be an admin to do that!!"
      redirect_to home_index_path
    end
  end
end
