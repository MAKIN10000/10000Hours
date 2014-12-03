class GoalsController < ApplicationController
 def new
    #new goal view
    @charities = Charity.all
  end

  def create
    if Goal.exists?({:title => params[:goal][:title], :pledge_amount => params[:goal][:pledge_amount], :owner => @current_user.session_token})
        flash[:notice] = "Goal already exists"
        redirect_to goals_path
    else
      #charities = Charity.all
      #charities.each do |charity|
      #  if $('##{charity.id}').is(:selected)
      #    selected_charity_id = charity.id
      #  end
      #end
      puts "CHARITY ID"
      charity = Charity.find(params[:selected_charity])
      puts charity.name
      hash = params[:goal]
      @goal = @current_user.goals.create!(hash)
      @goal.charity << charity
      flash[:notice] = "#{@goal.title} was successfully created"
      redirect_to goals_path
    end

  end

  def index 
    @goal = Goal.all
  end

  def list
    id = params[:id]
    user = User.find_by_uid(id)
    @goal = user.goals.order(:created_at)
    render :partial => "index", :object=>@goal if request.xhr?
  end

  def show
    id = params[:id] 
    @goal = Goal.find(id)

  end

  def destroy
      @goal = @current_user.goals.find(params[:id])
      if(@goal.destroy)
        flash[:notice] = "#{@goal.title} deleted."
        redirect_to goals_path
      else
        flash[:notice] = "Could not find goal"
        redirect_to goals_path
    end
  end
end
