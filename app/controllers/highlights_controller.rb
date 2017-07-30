class HighlightsController < ApplicationController

  before_action :set_highlight, only: [:show, :edit, :update]

  def index
    highlights = Highlight.ordered_all
    highlights = highlights.group_by {|h| h.posted_utc_date}.to_a
    @highlights = Kaminari.paginate_array(highlights).page(params[:page]).per(1)
  end

  def show
  end

  def edit
    require_admin
  end

  def update
    if @highlight.update(highlight_params(:title, :media_embed, :posted, :posted_utc, :url, :permalink))
      flash[:success] = "Highlight update successful"
      redirect_to highlight_path(@highlight)
    else
      flash[:danger] = @highlight.errors.full_messages[0]
      render "edit"
    end
  end

  def pendingJSON
    @highlights = Highlight.no_team
    render json: @highlights
  end

  def pending_edit
    require_admin
  end

  def pending_update
  end

  private

    def set_highlight
      @highlight = Highlight.find(params[:id])
    end

    def highlight_params(*args)
      params.require(:highlight).permit(*args)
    end



end
