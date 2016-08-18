class BeerCategory < ApplicationRecord
  lookup_by :beer_category, cache: 50, find_or_create: true
end
