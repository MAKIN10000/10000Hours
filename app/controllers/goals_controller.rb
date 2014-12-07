class GoalsController < ApplicationController
 def new
    #new goal view
  end

  def create
    if @current_user.goals.exists?(title: params[:goal][:title])
        flash[:notice] = "Goal already exists"
        redirect_to goals_path
    else
      hash = params[:goal]
      @goal = @current_user.goals.create!(hash) 
      flash[:notice] = "#{@goal.title} was successfully created"
      graph = Koala::Facebook::API.new(@current_user.token)
      graph.put_connections("me","links",{:message => "I have set a goal to #{@goal.description}", :link =>"tenthousandhours.herokuapp.com/goals/#{@goal.id}"})
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
