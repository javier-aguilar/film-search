class FilmController < ApplicationController
  def search
    data = Film.search(params[:query])

    render json: { data: data }, status: 200
  end
end
