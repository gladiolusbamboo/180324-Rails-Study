class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      # 同時実行制御のためのフィールド
      t.integer :lock_version, default: 0

      t.timestamps
    end
  end
end
