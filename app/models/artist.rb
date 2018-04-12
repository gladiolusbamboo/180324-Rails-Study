class Artist < ApplicationRecord
  belongs_to :listener
  # has_and_belongs_to_manyは純粋な中間テーブルを指定する
  has_and_belongs_to_many :cds
  # 関連名をcommentsに変更し
  # 関連モデルにFanCommentを指定し
  # 子テーブルのartist_noカラムを外部キーとして指定する
  # また、deleted=trueのFanCommentは取得しない
  has_many :comments, -> { where(deleted: false) }, 
    class_name: 'FanComment',
    foreign_key: 'artist_no'

  has_many :memos, as: :memoable

end
