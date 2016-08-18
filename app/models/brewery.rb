class Brewery < ApplicationRecord
  lookup_for :brewery_type

  has_and_belongs_to_many :beers
end
