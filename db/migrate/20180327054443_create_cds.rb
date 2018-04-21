class CreateCds < ActiveRecord::Migration[5.1]
  def change
    create_table :cds do |t|
      t.string :jan, limit: 17, null: false
      t.string :title, limit: 100, null: false
      # precision:数値の全体桁数
      # scale:小数点以下の桁数
      t.decimal :price, precision: 5, scale: 0
      t.string :label, limit: 20, default: 'サザナミレーベル'
      t.date :released
      t.boolean :is_major

      t.timestamps
    end
  end
end
