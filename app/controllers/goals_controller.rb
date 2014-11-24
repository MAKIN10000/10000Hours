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
      redirect_to goals_path
    end

  end

  def index 
    @goal = Goal.order(:title).page params[:page]
  end

  def list
    id = params[:id]
    @goal = @current_user.goals.order(:created_at).page params[:page]
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
