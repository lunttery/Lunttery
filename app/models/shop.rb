class Shop < ApplicationRecord
  validates_presence_of :name, :lat, :lng, :message => "不能是空！！！"
  before_save :set_location

  belongs_to :user

  def set_location
    self.location = "POINT(#{self.lng} #{self.lat})"
  end
end
