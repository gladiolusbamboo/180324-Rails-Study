class Cd < ApplicationRecord
  # バリデーションルールはモデルに設定する
  validates :jan,
    # 必須
    presence: true,
    # ユニーク
    # allow_blankをtrueにすることで検証をスキップする
    # messageプロパティで独自のエラーメッセージを設定できる
    uniqueness: {
      allow_blank: true,
      message: '%{value}は一意でなければなりません'
    },
    # 文字列長指定
    length: { 
      is: 17, 
      allow_blank: true,
      message: '%{value}は%{count}桁でなければなりません'
    },
    # 自作のJanValidatorを利用する
    # /model配下に設定している
    jan: { allow_old: true }
    # 正規表現指定
    # \Aは文字列先頭、\zは文字列末尾をあらわす
    # 978-4-7741-8411-1みたいな感じ
    # format: { 
    #   with: /\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z/,
    #   allow_blank: true,
    #   message: '%{value}は正しい形式ではありません'
    # }
  validates :title,
    presence: true,
    # 1~100文字まで
    length: { minimum: 1, maximum: 100 },
    # 複数条件でのユニーク指定
    uniqueness: {scope: :label}
    # 検証のために発行されるSQL
    # SELECT  1 AS one 
    # FROM "cds" 
    # WHERE 
    #   "cds"."title" = ? 
    #   AND "cds"."label" IS NULL 
    # LIMIT ?  
    # [["title", "エロス"], 
    #  ["LIMIT", 1]]
  validates :price,
    numericality: { 
      # 整数であるか
      only_integer: true, 
      # 10000以下か
      less_than: 10000 
    }
  validates :label,
    # 以下の文字列のみを許容する
    inclusion:{ in: ['サザナミレーベル', 'ビクターエンタテインメント', 'エピックレコードジャパン', 'モジャーレコーズ' ] }

  # モデル内でバリデーションを設定することもできる
  # けど、ややこしいから使わないようにしよう
  # validate :jan_valid?
  # private
  #   def jan_valid?
  #     errors.add(:jan, 'は正しい形式ではありません。')unless jan =~ /\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z/
  #   end

  # has_mayは参照元（子モデル）テーブルを指定する
  # モデル名が複数形になることに注意
  has_many :reviews
  # has_and_belongs_to_manyは純粋な中間テーブルを指定する
  has_and_belongs_to_many :artists
  # has_manyとthrough:で独自のフィールドを持つ中間テーブルを利用できる
  # listenerモデルと多対多の関係にある
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

  # コールバックの定義例
  after_destroy :history_book
  private do
    # Cdモデルがdestroyされると呼び出される関数
    def history_book
      logger.info('deleted: ' + self.inspect)
      # 以下のようなログがコンソールやlog/development.logに出力される
      # deleted: #<Cd id: 9, jan: "978-4-7741-7568-3", title: "KICK!", price: 3700, label: "ビクターエンタテインメント", released: "2015-08-19", is_major: false, created_at: "2018-04-12 05:06:48", updated_at: "2018-04-12 05:06:48">
    end
  end

  # 他の書き方１
  # after_destroy do |b|
  #   logger.info('deleted: ' + b.inspect)
  # end

  # 他の書き方２
  # コールバッククラスとして定義する場合
  # after_destroy CdCallbacks.new

end
