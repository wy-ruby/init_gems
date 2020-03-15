# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  age(年龄)             :string(255)
#  email(邮箱)           :string(255)
#  name(用户名)          :string(255)
#  password_digest(密码) :string(255)
#  sex(性别)             :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
