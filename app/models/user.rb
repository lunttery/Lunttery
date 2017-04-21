class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  store :fb_raw_data, :accessors => [:provider, :uid, :info, :credentials, :extra]

  has_many :shops

  after_create :add_user_role

  #定義給controller 的 method
  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
      user.fb_raw_data = auth.to_h
      user.save!
      return user
    end

    # Case 2: Create new password
    user = User.new
    user.confirmed_at = Time.now
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = "facebook#{rand(2**64)}@lunttery.com"
    user.fb_email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.fb_raw_data = auth.to_h
    user.save!
    return user
  end

  def add_user_role
    self.add_role :user
  end

end
