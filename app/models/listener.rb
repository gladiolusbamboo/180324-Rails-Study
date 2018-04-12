class Listener < ApplicationRecord
  # 新規登録のときだけ検証を行う。
  # 他にupdate,save（デフォルト値）が指定できる
  validates :agreement, acceptance: { on: :create }
  # e-mail同一検証用
  validates :email, 
    confirmation: true,
    # is_maleがチェックされていればe-mail必須
    presence: { unless: 'is_male.blank?' }

    # 他の書き方
    # presence: { unless: :sendmail? }
    # presence: { unless: Proc.new{|u| u.is_male.blank?} }
  
  # def :sendmail?
  #   is_male.blank?
  # end


  # チェック時の値を表すacceptパラメーターを指定している場合、
  # 対応する値を受け取れるようにしておく
  # validates :agreement, acceptance: {accept: 'yes'}

  # has_oneはそのまんま１：１の関係を表す
  has_one :artist
  has_many :reviews
  # has_manyとthrough:で独自のフィールドを持つ中間テーブルを利用できる
  # cdモデルと多対多の関係にある
  has_many :cds, through: :reviews
end
