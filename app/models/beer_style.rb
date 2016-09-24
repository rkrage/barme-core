class BeerStyle < ApplicationRecord
  lookup_for :beer_category

  after_commit :index_beers_and_breweries, on: :update

  has_many :beers, dependent: :destroy

  def index_beers_and_breweries
    beers.includes(:breweries).each do |beer|
      beer.index_document
      beer.breweries.each(&:index_document)
    end
  end
end
