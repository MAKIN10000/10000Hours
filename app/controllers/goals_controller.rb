class GoalsController < ApplicationController
 def new
    #new goal view
  end

  def create
    if Goal.exists?({:title => params[:goal][:title]})
        flash[:notice] = "Goal already exists"
        puts "This goal already exists"
        redirect_to goals_path
    else
      @goal = Goal.create_goal! params[:goal]
      flash[:notice] = "#{@goal.title} was successfully created"
      redirect_to goals_path
    end

  end

  def index 
    @goal = Goal.order(:title).page params[:page]
  end

  def show
    id = params[:id] 
    @goal = Goal.find(id)
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:notice] = "Movie '#{@goal.title}' deleted."
    redirect_to goals_path
  end

end