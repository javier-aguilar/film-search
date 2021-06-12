class MoviedbService
  def initialize(); end

  def search_film(query)
    params = { api_key: ENV['api_key'], language: 'en-US', query: query }
    get_json('search/movie', params)
  end

  private

  def get_json(url, params = nil)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.themoviedb.org/3/') do |conn|
      conn.adapter Faraday.default_adapter
    end
  end
end
