class FilmController < ApplicationController
  def search
    return error('Query required', 400) unless params[:query].present?

    data = Film.search(params[:query].downcase)
    render json: { data: data }, status: 200
  end
end
