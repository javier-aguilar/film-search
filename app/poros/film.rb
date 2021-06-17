class Film
  attr_reader :id, :title, :year, :summary

  def initialize(info)
    @id = info[:id]
    @title = info[:title]
    @year = info[:year]
    @summary = info[:summary]
  end

  def self.search(query)
    result = Search.where(query: query).first
    if result.present?
      Search.increment_counter(:count, result.id)
      return result.result
    end

    search_results = MoviedbService.new.search_film(query)
    return search_results[:errors] if search_results[:errors]

    films = Search.create(query: query, count: 1, result: filter_results(search_results))
    films[:result]
  end

  private

  def self.filter_results(search_results)
    search_results[:results].map do |film|
      film_info = { id: film[:id], title: film[:title], year: film[:release_date], summary: film[:overview] }
      Film.new(film_info)
    end
  end
 
end
