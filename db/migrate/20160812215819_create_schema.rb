class CreateSchema < ActiveRecord::Migration[5.0]
  def change
    create_schema :core
  end
end
