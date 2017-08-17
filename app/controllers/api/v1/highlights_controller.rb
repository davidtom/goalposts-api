require 'will_paginate/array'

class Api::V1::HighlightsController < Api::V1::BaseController
  skip_before_action :authorized
  def index
    # Send all highlights (with reduced/edited attributes) as JSON, paginated
    paginate json: Highlight.all_reduced, per_page: 10
  end

  def search
    render json: Highlight.search_reduced(params[:title])
  end
end
