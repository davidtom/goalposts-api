require 'will_paginate/array'

class Api::V1::SearchController < Api::V1::BaseController
  skip_before_action :authorized

  def index
    if params[:resource] = "highlight"
      render json: Highlight.search_by_title(params[:title])
    else
      render json: {error: "invalid resource"}
    end
  end

end
