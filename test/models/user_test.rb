# == Schema Information
#
# Table name: users
#
#  id                                       :bigint           not null, primary key
#  age(年龄)                                :string(255)
#  confirmation_sent_at(确认信息发送时间)   :datetime
#  confirmation_token(确认时的token信息)    :string(255)
#  confirmed_at(确认时间)                   :datetime
#  current_sign_in_at(本次登陆时间)         :datetime
#  current_sign_in_ip(本次登陆ip地址)       :string(255)
#  email(邮箱)                              :string(255)      default(""), not null
#  encrypted_password(加密密码)             :string(255)      default(""), not null
#  failed_attempts(失败次数)                :integer          default(0), not null
#  last_sign_in_at(上次登陆时间)            :datetime
#  last_sign_in_ip(上次登陆ip地址)          :string(255)
#  locked_at(锁定时间)                      :datetime
#  name(用户名)                             :string(255)
#  password_digest(密码)                    :string(255)
#  remember_created_at(用户创建时间)        :datetime
#  reset_password_sent_at(重置密码发送时间) :datetime
#  reset_password_token(重置密码token)      :string(255)
#  sex(性别)                                :boolean
#  sign_in_count(登陆次数)                  :integer          default(0), not null
#  unconfirmed_email(未点击确定的邮箱)      :string(255)
#  unlock_token(解锁token)                  :string(255)
#  created_at                               :datetime         not null
#  updated_at                               :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
