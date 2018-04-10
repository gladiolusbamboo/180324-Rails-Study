class Review < ApplicationRecord
  # モデル依存の列挙型はモデルファイル内に定義する
  # これにより@review.statusみたいな感じで列挙体名が呼び出せる
  enum status: { draft:0, published:1, deleted:2 }
  # これも同じ
  # enum status: {:draft, :published, :deleted}

  belongs_to :cd
  belongs_to :listener

  default_scope{ order(updated_at: :desc) }
end
