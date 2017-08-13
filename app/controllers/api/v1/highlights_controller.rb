require 'will_paginate/array'

class Api::V1::HighlightsController < Api::V1::BaseController
  def index
    # Send all highlights (with reduced/edited attributes) as JSON, paginated
    paginate json: Highlight.all_reduced, per_page: 25
  end
end
