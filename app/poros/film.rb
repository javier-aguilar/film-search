class Film
  attr_reader :id, :title, :year, :summary

  def initialize(info)
    @id = info[:id]
    @title = info[:title]
    @year = info[:year]
    @summary = info[:summary]
  end

  def self.search(query)
    search_results = MoviedbService.new.search_film(query)
    films = search_results[:results].map do |film|
      info = { id: film[:id], title: film[:title], year: film[:release_date], summary: film[:overview] }
      Film.new(info)
    end
    films
  end
end
