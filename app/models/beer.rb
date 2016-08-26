class Beer < ApplicationRecord
  include Indexable

  before_destroy :brewery_id_cache
  after_commit   :index_breweries, on: [:update, :create, :destroy]

  belongs_to :beer_style

  has_and_belongs_to_many :breweries

  scope :include_related, -> { includes(:beer_style, :breweries) }

  def brewery_id_cache
    @brewery_id_cache ||= breweries.pluck(:brewery_id)
  end

  def associated_breweries
    return breweries if breweries.present?

    Brewery.where(brewery_id: brewery_id_cache)
  end

  def index_breweries
    associated_breweries.each(&:index_document)
  end
end
