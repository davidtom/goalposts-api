class HighlightsController < ApplicationController

  before_action :set_highlight, only: [:show]

  def index
    @highlights = Highlight.all_group_and_order_by_date
  end

  def show
  end

  def new
    #TBD
  end

  private

    def set_highlight
      @highlight = Highlight.find(params[:id])
    end



end
