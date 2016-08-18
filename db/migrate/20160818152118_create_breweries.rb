class CreateBreweries < ActiveRecord::Migration[5.0]
  def change
    create_table :breweries, id: :uuid, primary_key: :brewery_id do |t|
      t.string  :name, null: false, index: true
      t.text    :description
      t.string  :website
      t.string  :city, index: true
      t.string  :region, index: true
      t.string  :country, index: true
      t.integer :established
      t.string  :image_icon
      t.string  :image_medium
      t.string  :image_large
      t.string  :image_square_medium
      t.string  :image_square_large
      t.string  :external_id, null: false
      t.uuid    :brewery_type_id, index: true

      t.timestamps
    end

    add_index :breweries, :external_id, unique: true
  end
end
