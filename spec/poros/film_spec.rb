require 'rails_helper'

RSpec.describe Film, type: :model do
  describe 'initialize' do
    it 'has attributes' do
      info = { id: 1,
               title: 'Suspiria',
               year: '1977',
               summary: 'An American newcomer to a prestigious German ballet academy comes to realize that the school is a front for something sinister amid a series of grisly murders.' }
      film = Film.new(info)

      expect(film.class).to eq Film
      expect(film.id).to eq 1
      expect(film.title).to eq 'Suspiria'
      expect(film.year).to eq '1977'
      expect(film.summary).to eq 'An American newcomer to a prestigious German ballet academy comes to realize that the school is a front for something sinister amid a series of grisly murders.'
    end
  end
  describe 'instance methods' do
    it '#search', :vcr do
      data = Film.search('suspiria')

      expect(data).not_to be_empty
      expect(data[0]).to have_key 'id'
      expect(data[0]).to have_key 'title'
      expect(data[0]).to have_key 'year'
    end
  end
end
