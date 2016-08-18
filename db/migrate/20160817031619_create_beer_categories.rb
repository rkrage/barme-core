class CreateBeerCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :beer_categories, id: :uuid, primary_key: :beer_category_id do |t|
      t.text :beer_category, null: false
    end

    add_foreign_key(
      :beer_styles,
      :beer_categories,
      column: :beer_category_id,
      primary_key: :beer_category_id
    )
  end
end
