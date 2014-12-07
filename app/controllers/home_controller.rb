class HomeController < ApplicationController
  def index
  	if @current_user
  		  @goal = @current_user.goals.order(:created_at)
  	end
  	render "index"
  end
  def show
  end
  def new
    # default: render 'new' template
  end
end
