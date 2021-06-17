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
      json_1 = JSON.parse(response.body, symbolize_names: true)
      data_1 = json_1[:data]

      result_1 = Search.last
      expect(result_1[:query]).to eq 'alien'
      expect(result_1[:count]).to eq 2

      expect(data_1).to be_an Array
      expect(data_1).not_to be_empty
      expect(data_1[0]).to have_key :id
      expect(data_1[0]).to have_key :title
      expect(data_1[0]).to have_key :year

      get '/film/search?query=Alien'

      expect(response).to be_successful
      json_2 = JSON.parse(response.body, symbolize_names: true)
      data_2 = json_2[:data]

      result_2 = Search.last
      expect(result_2[:query]).to eq 'alien'
      expect(result_2[:count]).to eq 3

      expect(data_2).to be_an Array
      expect(data_2).not_to be_empty
      expect(data_2[0]).to have_key :id
      expect(data_2[0]).to have_key :title
      expect(data_2[0]).to have_key :year
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
  describe 'GET film/search?query=alienalien&sort_by=title' do
    before { get '/film/search?query=alien&sort_by=title' }

    it 'returns film(s) ordered by title (default asc)' do
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:count]).to eq 1
      expect(result[:query]).to eq 'alien'

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data.first[:title]).to eq 'Alien'
      expect(data.last[:title]).to eq 'Ben 10 Alien Swarm'
    end
  end
  describe 'GET film/search?query=alienalien&sort_by=title&order=asc' do
    before { get '/film/search?query=alien&sort_by=title&order=asc' }

    it 'returns film(s) ordered by title asc' do
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:count]).to eq 1
      expect(result[:query]).to eq 'alien'

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data.first[:title]).to eq 'Alien'
      expect(data.last[:title]).to eq 'Ben 10 Alien Swarm'
    end
  end
  describe 'GET film/search?query=alienalien&sort_by=title&order=desc' do
    before { get '/film/search?query=alien&sort_by=title&order=desc' }

    it 'returns film(s) ordered by title desc' do
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:count]).to eq 1
      expect(result[:query]).to eq 'alien'

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data.first[:title]).to eq 'Ben 10 Alien Swarm'
      expect(data.last[:title]).to eq 'Alien'
    end
  end

  describe 'GET film/search?query=&sort_by=title&order=asc' do
    before { get '/film/search?query=&sort_by=title&order=asc' }

    it 'returns error' do
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:message]).to eq 'Query required'
    end

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'GET film/search?query=alienalien&filter=ben' do
    before { get '/film/search?query=alien&filter=ben' }

    it 'returns a match' do
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:count]).to eq 1
      expect(result[:query]).to eq 'alien'

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data.first[:title]).to eq 'Ben 10 Alien Swarm'
    end
  end

  describe 'GET film/search?query=alienalien&filter=ben' do
    before { get '/film/search?query=alien&filter=predator' }

    it 'returns matches' do
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data]

      result = Search.last
      expect(result[:count]).to eq 1
      expect(result[:query]).to eq 'alien'

      expect(data).to be_an Array
      expect(data).not_to be_empty
      expect(data.size).to eq 2
    end
  end
end
