# create_table "shops", force: :cascade do |t|
#   t.string    "name"
#   t.string    "address"
#   t.string    "phone"
#   t.float     "rate"
#   t.geography "location",   limit: {:srid=>4326, :type=>"point", :geographic=>true}
#   t.integer   "user_id"
#   t.datetime  "created_at",                                                          null: false
#   t.datetime  "updated_at",                                                          null: false
#   t.float     "lng"
#   t.float     "lat"
#   t.index ["user_id"], name: "index_shops_on_user_id", using: :btree
# end

FactoryGirl.define do
  factory :shop do
    sequence :name do |n|
      "店家#{n}"
    end

    sequence :address do |n|
      "地址#{n}"
    end

    rate (1..50).to_a.sample.to_f / 10
    phone "09#{Faker::Number.number(8)}"
    lng Faker::Address.longitude.to_f
    lat Faker::Address.latitude.to_f
  end
end
