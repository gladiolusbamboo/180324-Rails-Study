class CreateListeners < ActiveRecord::Migration[5.1]
  def change
    create_table :listeners do |t|
      t.string :listenername
      t.string :password_digest
      t.string :email
      t.boolean :is_male
      t.string :roles
      # カウンターキャッシュには０をデフォルトで設定してやる
      t.integer :reviews_count, default: 0

      t.timestamps
    end
  end
end
