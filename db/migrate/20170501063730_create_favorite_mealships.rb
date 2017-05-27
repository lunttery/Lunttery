class CreateFavoriteMealships < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_mealships do |t|
      t.integer :user_id
      t.integer :meal_id

      t.timestamps
    end
  end
end
