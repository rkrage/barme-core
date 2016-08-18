class BeerStyle < ApplicationRecord
  lookup_for :beer_category

  has_many :beers
end
