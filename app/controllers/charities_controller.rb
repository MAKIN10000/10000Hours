class CharitiesController < ApplicationController
  def new
    #new charity view
  end

  def create
    if Charity.exists?({:contact_email => params[:charity][:contact_email]})
        flash[:notice] = "Charity already exists"
        puts "This charity already exists"
        redirect_to home_index_path
    else
      @charity = Charity.create_charity! params[:charity]
      flash[:notice] = "#{@charity.name} was successfully created"
      redirect_to home_index_path
    end

  end

  def index 
    @charities = Charity.order(:name).page params[:page]
  end

  def show
    id = params[:id] 
    @charity = Charity.find(id)
  end

  def destroy
    @charity = Charity.find(params[:id])
    @charity.destroy
    flash[:notice] = "Movie '#{@charity.name}' deleted."
    redirect_to home_index_path
  end

end
