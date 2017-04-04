# create_table "meals", force: :cascade do |t|
#   t.string   "name"
#   t.integer  "price"
#   t.json     "photos"
#   t.integer  "shop_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["shop_id"], name: "index_meals_on_shop_id", using: :btree
# end

FactoryGirl.define do
  factory :meal do
    sequence :name do |n|
      "meal#{n}"
    end

    sequence :price do |n|
      100 + n
    end
  end
end
