class Api::V1::HighlightsController < Api::V1::BaseController
  def index
    respond_with Highlight.all
  end
end
