require 'swagger_helper'

RSpec.describe 'Film API', type: :request do
  path '/film/search' do
    get 'Retrieves a list of film(s) based on query' do
      tags 'Search'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string, required: true
      parameter name: :sort_by, in: :query, schema: { type: :string, enum: [:title, :year] }, required: false
      parameter name: :order, in: :query, schema: { type: :string, enum: ['asc', 'desc'] }, required: false
      parameter name: :filter, in: :query, type: :string, required: false

      response '200', 'Film(s) found matching query' do
        schema type: :object,
               properties: {
                  type: :array,
                    items: {
                      properties: {
                        id: { type: :integer },
                        title: { type: :string },
                        year: { type: :string },
                        summary: { type: :string }
                      }
                    }
                }
        let(:query) { 'aa' }
        run_test!
      end

      response '400', 'Query required' do
        let(:query) { '' }
        run_test!
      end
    end
  end
end