class CreateBeers < ActiveRecord::Migration[5.0]
  def change
    create_table :beers, id: :uuid, primary_key: :beer_id do |t|
      t.string  :name, null: false, index: true
      t.text    :description
      t.decimal :abv
      t.integer :ibu
      t.string  :label_icon
      t.string  :label_medium
      t.string  :label_large
      t.string  :external_id, null: false
      t.uuid    :beer_style_id, index: true
      t.timestamps
    end

    add_index :beers, :external_id, unique: true
  end
end
