class FilmController < ApplicationController
  def search
    return error('Query required', 400) unless params[:query].present?

    results = Film.search(params[:query].downcase)
    if params[:sort_by] == 'title' || params[:sort_by] == 'year'
      sort_results(results, params[:sort_by])
      results.reverse! if params[:order] == 'desc'
    else
      results
    end
    render json: { data: results }, status: 200
  end

  private

  def sort_results(results, key)
    results.sort_by! { |film| film[key].downcase }
  end
end
