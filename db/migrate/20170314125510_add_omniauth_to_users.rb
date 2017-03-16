class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    #新增facebook api回傳的資料, uid token 一定要有欄位紀錄
    add_column :users, :fb_uid, :string
    add_column :users, :fb_token, :string
    add_column :users, :fb_email, :string
    add_column :users, :fb_raw_data, :text

    add_index :users, :fb_uid
  end
end
