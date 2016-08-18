class BreweryType < ApplicationRecord
  lookup_by :brewery_type, cache: 50, find_or_create: true
end
