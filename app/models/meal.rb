class Meal < ApplicationRecord
  validates_presence_of :name, :message => "不能是空！！！"

  belongs_to :shop
  mount_uploaders :photos, Meal::PhotosUploader
end
