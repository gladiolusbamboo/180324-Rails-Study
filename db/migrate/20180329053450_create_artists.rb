class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.references :listener, foreign_key: true
      t.string :name
      t.date :birth
      t.text :url
      t.string :ctype
      t.binary :photo

      t.timestamps
    end
  end
end
