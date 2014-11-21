class GoalsController < ApplicationController
 def new
    #new goal view
  end

  def create
    if Goal.exists?({:title => params[:goal][:title], :owner => @current_user.session_token})
        flash[:notice] = "Goal already exists"
        puts "This goal already exists"
        redirect_to goals_path
    else
      hash = params[:goal]
      hash[:owner] = @current_user.session_token
      @goal = Goal.create_goal! hash
      flash[:notice] = "#{@goal.title} was successfully created"
      redirect_to goals_path
    end

  end

  def index 
    @goal = Goal.order(:title).page params[:page]
  end

  def list
    id = params[:id]
    @goal = Goal.where(:owner=>id).order(:title).page params[:page]
    render :partial => "index", :object=>@goal if request.xhr?
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
