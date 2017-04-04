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

class Shop < ApplicationRecord
  validates_presence_of :name, :lat, :lng, :message => "不能是空！！！"
  before_save :set_location

  has_many :meals
  belongs_to :user

  def set_location
    self.location = "POINT(#{self.lng} #{self.lat})"
  end
end
