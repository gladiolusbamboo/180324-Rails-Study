class CreateListeners < ActiveRecord::Migration[5.1]
  def change
    create_table :listeners do |t|
      t.string :listenername
      t.string :password_digest
      t.string :email
      t.boolean :is_male
      t.string :roles
      t.integer :reviews_count

      t.timestamps
    end
  end
end
