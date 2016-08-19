class BeerStyleSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :category

  def category
    object.beer_category
  end
end
