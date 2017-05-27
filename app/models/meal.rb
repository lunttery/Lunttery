# create_table "meals", force: :cascade do |t|
#   t.string   "name"
#   t.integer  "price"
#   t.json     "photos"
#   t.integer  "shop_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["shop_id"], name: "index_meals_on_shop_id", using: :btree
# end

class Meal < ApplicationRecord
  validates_presence_of :name, :message => "不能是空！！！"

  belongs_to :shop
  belongs_to :user
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  mount_uploaders :photos, Meal::PhotosUploader
end
