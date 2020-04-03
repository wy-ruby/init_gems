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

class User < ApplicationRecord
  # 在rails 3.0以上版本中，ActiveModel::SecurePassword就使用bcrypt密码验证。不过也需要在gemfile中引入 gem 'bcrypt'
  # 需要在users表中添加 password_digest 字段，如果是password字段也是会报错的，只能是password_digest字段。
  # 当 has_secure_password 使用的时候就会载入bcrypt gem，并且该方法会给user添加两个虚拟属性password和password_confirmation,
  # 创建user的时候会执行存在性验证和匹配验证，同时会获得authenticate方法(根据密码验证)，如果密码正确，返回对应的用户对象，否则返回false
  # 例如：
  # user = User.new(name: 'david', password: 'mUc3m00RsqyRe', password_confirmation: 'mUc3m00RsqyRe')
  # user.save  # 实际是对虚拟属性password进行加密，把加密后的内容保存到password_digest字段中。
  # user.authenticate('notright')      # => false
  # user.authenticate('mUc3m00RsqyRe') # => user
  # user.password  # => "mUc3m00RsqyRe" 对password_digest解密后的密码
  # user.password_digest # => "$2a$10$4LEA7r4YmNHtvlAvHhsYAeZmk/xeUVtMTYqwIvYY76EW5GUqDiP4." 对password加密后的密码
  has_secure_password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable


end
