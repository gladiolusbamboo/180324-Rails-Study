# データベースに関連づかないモデルとそのバリデーションの例
class SearchKeyword
  # 必須
  include ActiveModel::Model
  # モデルとして管理すべき項目をアクセサーとして定義する
  attr_accessor :keyword
  # バリデーションの例
  validates :keyword, presence: true
end
