class GoalsController < ApplicationController
 def new
    #new goal view
    @charities = Charity.all
  end

  def create
    if @current_user.goals.exists?({:title => params[:goal][:title], :pledge_amount => params[:goal][:pledge_amount]})
      flash[:notice] = "Goal already exists"
      redirect_to goals_path
    else
      hash = params[:goal]
      hash[:completed] = false
      selected_charity = Charity.find(params[:selected_charity])
      puts selected_charity.totalPledge
      puts params[:goal][:pledge_amount]
      selected_charity.totalPledge = params[:goal][:pledge_amount].to_f + selected_charity.totalPledge
      selected_charity.save!
      @goal = @current_user.goals.new(hash)
      @goal.charity_id = params[:selected_charity]
      @goal.save!
      if @current_user.provider == 'facebook'
        graph = Koala::Facebook::API.new(@current_user.token)
        perms = graph.get_connections('me', 'permissions')
        begin
          graph.put_connections("me","links",{:message => "I have set a goal to #{@goal.description}", :link =>"tenthousandhours.herokuapp.com/goals/#{@goal.id}"})
        rescue Koala::Facebook::APIError => e
          flash[:warning] = "To have a facebook status update, relogin and select ok when prompted for permission"
        end
      end
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
    render :partial => "/shared/goal_list", :object=>@goal if request.xhr?
  end

  def show
    id = params[:id] 
    @goal = Goal.find(id)
    if @charity = Charity.where(:id => '#{@goal.charity_id}')
    end
  end

  def update
    id = params[:id]
    goal = Goal.find(id)
    goal.completed = true
    goal.save
    redirect_to root_path
  end


  def destroy
    if(!@current_user.nil? && @current_user.role == 'admin')
      @goal = Goal.find(params[:id])
      if(@goal.destroy)
        flash[:notice] = "#{@goal.title} deleted."
        redirect_to goals_path
      else
        flash[:notice] = "Could not find goal"
        redirect_to goals_path
      end
    end
  end
end
