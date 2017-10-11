require 'will_paginate/array'

class Api::V1::HighlightsController < Api::V1::BaseController
  skip_before_action :authorized, only: [:index]
  # skip_before_action :authorized 

  def index
    # Send all highlights (with reduced/edited attributes) as JSON, paginated
    paginate json: Highlight.all_reduced, per_page: 10
  end

  def destroy
    highlight = Highlight.find(params[:id])
    if highlight.destroy
      render json: {success: "highlight deleted successfully."}
    else
      render json: {error: "highlight could not be deleted."}
    end

  end
end
