class TeamsController < ApplicationController

  def index
    @teams = Team.order("name ASC")
    erb :"teams/index.html"
  end

  def show
    @team = Team.find(params[:id])
    erb :"teams/show.html"
  end

  def new
    # tbd
  end



end
