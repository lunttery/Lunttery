class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.integer :price
      t.json :photos
      t.integer :shop_id

      t.timestamps
    end
    add_index :meals, :shop_id
  end
end
