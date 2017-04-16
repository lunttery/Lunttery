# create_table "taggings", force: :cascade do |t|
#   t.integer  "tag_id"
#   t.integer  "taggable_id"
#   t.string   "taggable_type"
#   t.datetime "created_at",    null: false
#   t.datetime "updated_at",    null: false
# end

class Tagging < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  belongs_to :tag
end
