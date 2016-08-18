class CreateBeerStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :beer_styles, id: :uuid, primary_key: :beer_style_id do |t|
      t.text    :name, null: false, index: true
      t.text    :description
      t.integer :external_id, null: false
      t.uuid    :beer_category_id, null: false, index: true
      t.timestamps
    end

    add_index :beer_styles, :external_id, unique: true

    add_foreign_key(
      :beers,
      :beer_styles,
      column: :beer_style_id,
      primary_key: :beer_style_id
    )
  end
end
