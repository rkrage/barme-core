class Brewery < ApplicationRecord
  include Indexable

  lookup_for :brewery_type

  before_destroy :beer_id_cache
  after_commit   :index_beers, on: [:update, :create, :destroy]

  has_and_belongs_to_many :beers

  scope :include_related, -> { includes(beers: :beer_style) }

  def beer_id_cache
    @beer_id_cache ||= beers.pluck(:beer_id)
  end

  def associated_beers
    return beers if beers.present?

    Beer.where(beer_id: beer_id_cache)
  end

  def index_beers
    associated_beers.each(&:index_document)
  end
end
