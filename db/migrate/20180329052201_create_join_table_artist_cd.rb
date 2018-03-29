class CreateJoinTableArtistCd < ActiveRecord::Migration[5.1]
  def change
    create_join_table :artists, :cds do |t|
      # t.index [:artist_id, :cd_id]
      # t.index [:cd_id, :artist_id]
    end
  end
end
