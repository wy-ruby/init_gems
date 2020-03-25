# == Schema Information
#
# Table name: users
#
#  id                       :bigint           not null, primary key
#  age(年龄)                :string(255)
#  email(邮箱)              :string(255)
#  encrypted_password       :string(255)      default(""), not null
#  name(用户名)             :string(255)
#  password_digest(密码)    :string(255)
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string(255)
#  sex(性别)                :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    
  end
end
