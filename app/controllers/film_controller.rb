class FilmController < ApplicationController
  def search
    return error('Query required', 400) unless params[:query].present?

    results = Film.search(params[:query].downcase, params[:filter])

    if params[:sort_by] == 'title' || params[:sort_by] == 'year'
      Film.sort_results(results, params[:sort_by], params[:order])
    else
      results
    end
    render json: { data: results }, status: 200
  end
end
