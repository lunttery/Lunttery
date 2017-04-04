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
      "shop#{n}"
    end
    address '地址'
    phone '0912345678'
    rate 4.6
    lng 121.3
    lat 25.3
  end
end
