class Api::V1::HighlightsController < Api::V1::BaseController
  def index
    # Send all highlights (with reduced/edited attributes) as JSON
    respond_with Highlight.all_reduced
  end
end
