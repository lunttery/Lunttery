# create_table "tags", force: :cascade do |t|
#   t.string   "name"
#   t.string   "source_type"
#   t.datetime "created_at",  null: false
#   t.datetime "updated_at",  null: false
#   t.index ["source_type"], name: "index_tags_on_source_type", using: :btree
# end

FactoryGirl.define do
  factory :tag do
    factory :shop_tag do
      sequence :name do |n|
        "店家標籤#{n}"
      end
      source_type "Shop"
    end

    factory :meal_tag do
      sequence :name do |n|
        "餐點標籤#{n}"
      end
      source_type "Meal"
    end
  end
end
