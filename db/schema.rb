# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_24_040426) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", comment: "用户名"
    t.string "email", default: "", null: false, comment: "邮箱"
    t.string "password_digest", comment: "密码"
    t.string "age", comment: "年龄"
    t.boolean "sex", comment: "性别"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false, comment: "加密密码"
    t.string "reset_password_token", comment: "重置密码token"
    t.datetime "reset_password_sent_at", comment: "重置密码发送时间"
    t.datetime "remember_created_at", comment: "用户创建时间"
    t.integer "sign_in_count", default: 0, null: false, comment: "登陆次数"
    t.datetime "current_sign_in_at", comment: "本次登陆时间"
    t.datetime "last_sign_in_at", comment: "上次登陆时间"
    t.string "current_sign_in_ip", comment: "本次登陆ip地址"
    t.string "last_sign_in_ip", comment: "上次登陆ip地址"
    t.string "confirmation_token", comment: "确认时的token信息"
    t.datetime "confirmed_at", comment: "确认时间"
    t.datetime "confirmation_sent_at", comment: "确认信息发送时间"
    t.string "unconfirmed_email", comment: "未点击确定的邮箱"
    t.integer "failed_attempts", default: 0, null: false, comment: "失败次数"
    t.string "unlock_token", comment: "解锁token"
    t.datetime "locked_at", comment: "锁定时间"
    t.string "provider", comment: "三方登录提供商"
    t.string "uid", comment: "授权用户的uid"
    t.string "image", comment: "授权用户的头像地址"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
