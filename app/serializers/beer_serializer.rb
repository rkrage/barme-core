class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :abv, :ibu,
    :label_icon, :label_medium, :label_large

  belongs_to :beer_style, key: :style
  has_many :breweries
end
