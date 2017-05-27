class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :source_type

      t.timestamps
    end
    add_index :tags, :source_type
  end
end
