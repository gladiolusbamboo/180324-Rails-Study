class Cd < ApplicationRecord
  has_many :reviews
  has_and_belongs_to_many :artists
  has_many :listeners, through: :reviews
  has_many :memos, as: :memoable

  # アロー演算子は無名関数を定義していると思いねえ
  scope :sazanami, -> { where(label: 'サザナミレーベル')}
  scope :newer, -> { order(released: :desc)}
  scope :top10, -> { newer.limit(10)}

  # スコープをパラメータ化することもできる
  scope :whats_new, ->(lab){
    where(label: lab).order(released: :desc).limit(5)
  }
end
