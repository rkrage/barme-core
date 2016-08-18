class CreateBreweryTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :brewery_types, id: :uuid, primary_key: :brewery_type_id do |t|
      t.text :brewery_type, null: false
    end

    add_foreign_key(
      :breweries,
      :brewery_types,
      column: :brewery_type_id,
      primary_key: :brewery_type_id
    )
  end
end
