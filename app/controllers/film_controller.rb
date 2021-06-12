class FilmController < ApplicationController
  def search
    return error('Query required', 400) unless params[:query]

    data = Film.search(params[:query])
    render json: { data: data }, status: 200
  end
end
