class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, comment: "用户名"
      t.string :email, comment: "邮箱"
      t.string :age, comment: "年龄"
      t.boolean :sex, comment: "性别"

      t.timestamps
    end
  end
end
