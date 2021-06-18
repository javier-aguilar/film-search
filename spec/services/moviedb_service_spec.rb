require 'rails_helper'

describe MoviedbService do
  context "instance methods" do
    context "#search_film" do
      it "returns film results based on query", :vcr do
        data = MoviedbService.new.search_film('alien')

        expect(data).not_to be_empty

        expect(data[:results][0]).to have_key :id
        expect(data[:results][0]).to have_key :original_title
        expect(data[:results][0]).to have_key :release_date
      end
    end
  end
end
