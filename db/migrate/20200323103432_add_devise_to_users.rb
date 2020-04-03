# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.2]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "", after: 'name', comment: "邮箱"
      t.string :encrypted_password, null: false, default: "", comment: "加密密码"

      ## Recoverable
      t.string   :reset_password_token, comment: "重置密码token"
      t.datetime :reset_password_sent_at, comment: "重置密码发送时间"

      ## Rememberable
      t.datetime :remember_created_at, comment: "用户创建时间"

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false, comment: "登陆次数"
      t.datetime :current_sign_in_at, comment: "本次登陆时间"
      t.datetime :last_sign_in_at, comment: "上次登陆时间"
      t.string   :current_sign_in_ip, comment: "本次登陆ip地址"
      t.string   :last_sign_in_ip, comment: "上次登陆ip地址"

      ## Confirmable
      t.string   :confirmation_token, comment: "确认时的token信息"
      t.datetime :confirmed_at, comment: "确认时间"
      t.datetime :confirmation_sent_at, comment: "确认信息发送时间"
      t.string   :unconfirmed_email, comment: "未点击确定的邮箱" # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false, comment: "失败次数"# Only if lock strategy is :failed_attempts
      t.string   :unlock_token, comment: "解锁token" # Only if unlock strategy is :email or :both
      t.datetime :locked_at, comment: "锁定时间"


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
