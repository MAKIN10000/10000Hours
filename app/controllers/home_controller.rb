class HomeController < ApplicationController
  def index
  end
  def show
    # will render app/views/movies/show.<extension> by default
  end
  def new
    # default: render 'new' template
  end
end
