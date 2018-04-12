class Review < ApplicationRecord
  # モデル依存の列挙型はモデルファイル内に定義する
  # これにより@review.statusみたいな感じで列挙体名が呼び出せる
  enum status: { draft:0, published:1, deleted:2 }
  # これも同じ
  # enum status: {:draft, :published, :deleted}

  # belongs_toは参照先（親モデル）を指定する
  # cdモデルとlistnerモデルをつなぐ中間テーブルとして利用できる
  belongs_to :cd
  # カウンターキャッシュを使用することで
  # テーブルを結合することなく子モデルの件数を取得することができる
  # 子モデルのほうに設定を書くことに注意
  belongs_to :listener, counter_cache: true

  default_scope{ order(updated_at: :desc) }
end
