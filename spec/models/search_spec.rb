require 'rails_helper'

describe Search, type: :model do
  describe 'validations' do
    it { should validate_presence_of :query }
    it { should validate_uniqueness_of :query }
    it { should validate_presence_of :count }
    it { should validate_presence_of :result }
  end
end