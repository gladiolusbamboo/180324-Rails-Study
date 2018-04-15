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

  validate :file_invalid?

  # 'data='がメソッドの名前。
  # Rubyでは代入可能なメソッドをこのように定義する
  # data = XXX という記法で呼び出すことができる
  # よくわからんが、
  # @artist.update(params.require(:artist).permit(:data))
  # でこのメソッドが呼び出されている
  def data=(data)
    # pp ('data=呼び出し')
    self.ctype = data.content_type
    self.photo = data.read
  end

  private 
    def file_invalid?
      ps = ['image/jpeg', 'image/gif', 'image/png']
      errors.add(:photo, 'は画像ファイルではありません。') if !ps.include?(self.ctype)
      errors.add(:photo, 'のサイズが1MBを超えています。') if self.photo.length > 1.megabyte
    end
end
