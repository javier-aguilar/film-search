class Search < ApplicationRecord
  validates :query, presence: true, uniqueness: true, on: :create
  validates :count, presence: true
  validates :result, presence: true
end
