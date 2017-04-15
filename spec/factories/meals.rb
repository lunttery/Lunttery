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
      "餐點#{n}"
    end

    price (50..150).to_a.sample
  end
end
