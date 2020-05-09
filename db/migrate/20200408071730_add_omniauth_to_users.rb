class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string, comment: "三方登录提供商"
    add_column :users, :uid, :string, comment: "授权用户的uid"
    add_column :users, :image, :string, comment: "授权用户的头像地址"
  end
end
