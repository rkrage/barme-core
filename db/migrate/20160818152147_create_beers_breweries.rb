class CreateBeersBreweries < ActiveRecord::Migration[5.0]
  def change
    create_table :beers_breweries, id: :uuid, primary_key: :beer_brewery_id do |t|
      t.uuid :beer_id, null: false, index: true
      t.uuid :brewery_id, null: false, index: true
    end

    add_index :beers_breweries, [:beer_id, :brewery_id], unique: true

    add_foreign_key(
      :beers_breweries,
      :beers,
      column: :beer_id,
      primary_key: :beer_id
    )

    add_foreign_key(
      :beers_breweries,
      :breweries,
      column: :brewery_id,
      primary_key: :brewery_id
    )
  end
end
