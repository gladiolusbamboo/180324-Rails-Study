class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :cd, foreign_key: true
      t.references :listener, foreign_key: true
      t.integer :status, default: 0, null: false
      t.text :body

      t.timestamps
    end
  end
end
