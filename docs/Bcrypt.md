　　Bcrypt是针对OpenBSD bcrypt()密码哈希算法的Ruby绑定，可让您轻松存储用户密码的安全哈希。  
　　在rails 3.0以上版本中，ActiveModel::SecurePassword就使用bcrypt密码验证。不过也需要在
gemfile中引入 gem 'bcrypt',需要在users表中添加 password_digest 字段，如果是password字
段也是会报错的，只能是password_digest字段。当 has_secure_password 使用的时候就会载入
bcrypt gem，并且该方法会给user添加两个虚拟属性password和password_confirmation,创建user
的时候会执行存在性验证和匹配验证，同时会获得authenticate方法(根据密码验证)，如果密码正确，
返回对应的用户对象，否则返回false  
**示例:**
```ruby
user = User.new(name: 'david', password: 'mUc3m00RsqyRe', password_confirmation: 'mUc3m00RsqyRe')
user.save  # 实际是对虚拟属性password进行加密，把加密后的内容保存到password_digest字段中。
user.authenticate('notright')      # => false
user.authenticate('mUc3m00RsqyRe') # => user
user.password  # => "mUc3m00RsqyRe" 对password_digest解密后的密码
user.password_digest # => "$2a$10$4LEA7r4YmNHtvlAvHhsYAeZmk/xeUVtMTYqwIvYY76EW5GUqDiP4." 对password加密后的密码
class User < ApplicationRecord
  has_secure_password
end
```