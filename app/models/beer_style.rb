class BeerStyle < ApplicationRecord
  lookup_for :beer_category

  after_commit :index_beers, on: :update

  has_many :beers, dependent: :destroy

  def index_beers
    beers.each(&:index_document)
  end
end
