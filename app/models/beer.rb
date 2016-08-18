class Beer < ApplicationRecord
  belongs_to :beer_style

  has_and_belongs_to_many :breweries
end
