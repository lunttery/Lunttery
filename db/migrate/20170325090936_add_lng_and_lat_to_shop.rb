class AddLngAndLatToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :lng, :float
    add_column :shops, :lat, :float
  end
end
