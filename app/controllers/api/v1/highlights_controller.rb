require 'will_paginate/array'

class Api::V1::HighlightsController < Api::V1::BaseController
  def index
    # Send all highlights (with reduced/edited attributes) as JSON, paginated
    paginate json: Highlight.all_reduced, per_page: 10
  end

  def search
    query = params[:title]
    a = ActiveRecord::Base.connection
    query_anywhere = "%#{query}%"
    query_at_start = "#{query}%"
    result = a.execute(%Q{SELECT * FROM highlights WHERE title ILIKE #{a.quote(query_anywhere)} ORDER BY (title ILIKE #{a.quote(query_at_start)}) DESC, title})
    render json: result
  end
end
