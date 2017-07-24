class TeamsController < ApplicationController

  before_action :set_team, only: [:show]

  def index
    @teams = Team.order("name ASC")
  end

  def show
  end

  def new
    # tbd
  end

  private

    def set_team
      @team = Team.find(params[:id])
    end


end
