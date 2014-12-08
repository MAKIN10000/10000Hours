class CharitiesController < ApplicationController
  def new
    #new charity view
  end

  def create
    if !@current_user.nil? && @current_user.role =='admin'
      if Charity.exists?({:contact_email => params[:charity][:contact_email]})
          flash[:notice] = "Charity already exists"
          puts "This charity already exists"
          redirect_to new_charity_path
      else
        params[:charity][:totalPledge] = 0.00
        @charity = Charity.create_charity! params[:charity]
        flash[:notice] = "#{@charity.name} was successfully created"
        redirect_to charities_path
      end
    else
      flash[:warning] = "You must be an admin to do that!"
      redirect_to login_path
    end
  end

  def index 
    @charities = Charity.all
  end

  def show
    id = params[:id] 
    @charity = Charity.find(id)
  end

  def destroy
    if !@current_user.nil? && @current_user.role == 'admin'
      @charity = Charity.find(params[:id])
      @charity.destroy
      flash[:notice] = "#{@charity.name} deleted."
      redirect_to charities_path
    else
      flash[:warning] = "You must be an admin to do that!"
      redirect_to login_path
    end
  end

end
