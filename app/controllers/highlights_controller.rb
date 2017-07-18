class HighlightsController < ApplicationController

  before_action :set_highlight, only: [:show]

  def index
    highlights = Highlight.ordered_all
    highlights = highlights.group_by {|h| h.posted_utc_date}.to_a
    @highlights = Kaminari.paginate_array(highlights).page(params[:page]).per(1)
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
