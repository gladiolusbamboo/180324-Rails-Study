class CreateCds < ActiveRecord::Migration[5.1]
  def change
    create_table :cds do |t|
      t.string :jan
      t.string :title
      t.integer :price
      t.string :label
      t.date :released
      t.boolean :is_major

      t.timestamps
    end
  end
end
