class BrewerySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :website, :city,
    :region, :country, :established, :image_icon, :image_medium,
    :image_large, :image_square_medium, :image_square_large, :type

  has_many :beers

  def type
    object.brewery_type
  end
end
