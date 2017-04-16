# create_table "tags", force: :cascade do |t|
#   t.string   "name"
#   t.string   "source_type"
#   t.datetime "created_at",  null: false
#   t.datetime "updated_at",  null: false
#   t.index ["source_type"], name: "index_tags_on_source_type", using: :btree
# end

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :shops, source: :taggable, source_type: "Shop", through: :taggings
  has_many :meals, source: :taggable, source_type: "Meal", through: :taggings
end

