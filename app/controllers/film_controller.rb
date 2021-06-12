class FilmController < ApplicationController
  def search
    render json: { data: 'lorem ipsum' }, status: 200
  end
end
