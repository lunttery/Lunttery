class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.float :rate
      t.st_point :location, geographic: true
      t.integer :user_id

      t.timestamps
    end
    add_index :shops, :user_id
  end
end
