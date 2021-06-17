class Film
  attr_reader :id, :title, :year, :summary

  def initialize(info)
    @id = info[:id]
    @title = info[:title]
    @year = info[:year]
    @summary = info[:summary]
  end

  def self.search(query, filter = nil)
    search_results = search_db_or_create_entry(query)
    return filter(search_results[:id], filter) if filter.present?

    search_results[:results]
  end

  private

  def self.search_db_or_create_entry(query)
    result = Search.where(query: query).first
    if result.present?
      Search.increment_counter(:count, result.id)
      { results: result.result, id: result[:id] }
    else
      search_results = MoviedbService.new.search_film(query)
      return search_results[:errors] if search_results[:errors]

      films = Search.create(query: query, count: 1, result: parse_results(search_results))
      { results: films[:result], id: films[:id] }
    end
  end

  def self.parse_results(search_results)
    search_results[:results].map do |film|
      film_info = { id: film[:id], title: film[:title], year: film[:release_date], summary: film[:overview] }
      Film.new(film_info)
    end
  end

  def self.filter(id, filter)
    sql = "SELECT arr.film FROM searches, jsonb_array_elements(result) with ordinality arr(film)
           WHERE id = #{id} 
           AND (arr.film->>'title' ilike '%#{filter}%' OR arr.film->>'year' ilike '%#{filter}%'
           OR arr.film->>'summary' ilike '%#{filter}%')"
    filtered_results = ActiveRecord::Base.connection.exec_query(sql)
    filtered_results.map { |film| JSON.parse(film['film']) }
  end

  def self.sort_results(results, key, order)
    results.sort_by! { |film| film[key].downcase }
    results.reverse! if order == 'desc'
  end
end
