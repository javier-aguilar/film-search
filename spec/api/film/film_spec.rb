require 'rails_helper'

RSpec.describe 'Films', type: :request do
  describe 'GET film/search?query=alien' do
    before { get '/film/search?query=alien' }

    it 'returns film(s)' do
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:count]).to eq 1
      expect(result[:query]).to eq 'alien'

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data[0]).to have_key :id
      expect(data[0]).to have_key :title
      expect(data[0]).to have_key :year
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns film(s) from db' do
      get '/film/search?query=alien'

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:query]).to eq 'alien'
      expect(result[:count]).to eq 2

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data[0]).to have_key :id
      expect(data[0]).to have_key :title
      expect(data[0]).to have_key :year
    end
    it 'returns film(s) from db with capitalization' do
      get '/film/search?query=Alien'

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:query]).to eq 'Alien'
      expect(result[:count]).to eq 3

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data[0]).to have_key :id
      expect(data[0]).to have_key :title
      expect(data[0]).to have_key :year
    end
  end
  describe 'GET film/search?query=' do
    before { get '/film/search?query=' }

    it 'returns error' do
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:message]).to eq 'Query required'
    end

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end
  end
  describe 'GET film/search?' do
    before { get '/film/search?' }

    it 'returns error' do
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:message]).to eq 'Query required'
    end

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end
  end
end
