class RecordController < ApplicationController
  def find
    @cds = Cd.find([2,5,10])
    # ↓発行されるSQL
    # SELECT "cds".* 
    # FROM "cds"
    # WHERE "cds"."id"
    # IN (2, 5, 10)
    render 'yahoo/list'
  end

  def find_by
    @cd = Cd.find_by(label: 'サザナミレーベル')
    # ↓発行されるSQL
    # SELECT  "cds".* FROM "cds" 
    # WHERE "cds"."label" = ? 
    # LIMIT ?  
    # [["label", "サザナミレーベル"], 
    # ["LIMIT", 1]]

    # find_byは１件のみ取得する

    render 'yahoo/show'
  end

  def where
    @cds = Cd.where(label: 'サザナミレーベル')
    # ↓SQL
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE "cds"."label" = ?  
    # [["label", "サザナミレーベル"]]

    # @cds = Cd.where(label: 'サザナミレーベル', is_major: true)
    # ↓SQL
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE "cds"."label" = ? 
    #   AND "cds"."is_major" = ?  
    # [["label", "サザナミレーベル"], 
    # ["is_major", "t"]]    

    # @cds = Cd.where(released: '2016-06-01'..'2016-12-31')
    # ↓SQL
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE ("cds"."released" BETWEEN ? AND ?)  
    # [["released", "2016-06-01"], 
    # ["released", "2016-12-31"]]

    # @cds = Cd.where(label: ['ビクターエンタテインメント', 'エピックレコードジャパン'])
    # ↓SQL
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE "cds"."label" 
    # IN ('ビクターエンタテインメント', 'エピックレコ
    #   ードジャパン')
    render 'yahoo/list'
  end

  def ph1
    # keyword.html.erbのフォームからpostでパラメータを渡している
    # 必ずプレースホルダーを利用すること
    # 文字列連結ではSQLインジェクションの原因となる可能性がある
    @cds = Cd.where('label = ? AND price >= ?',
      params[:label], params[:price])
    # ↓SQL
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE 
    #   (label = 'サザナミレーベル' AND price >= '1980')

    # プレースホルダーを利用しない書き方もできる
    # @cds = Cd.where('label = :label AND price >= :price',
    #   label: params[:label],
    #   price: params[:price])
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE 
    #   (label = 'ビクターエンタテインメント' AND price >= '3000')

    render 'yahoo/list'
  end

  def not
    # URLからGETでパラメータを取得している
    @cds = Cd.where.not(jan: params[:id])
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE ("cds"."jan" != ?)  
    # [["jan", "978-4-7741-7568-3"]]
    render 'cds/index'
  end

  def where_or
    @cds = Cd.where(label: 'サザナミレーベル').or(Cd.where('price > 2000'))
    # ↓SQL
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE ("cds"."label" = ? OR (price > 2000))  
    # [["label", "サザナミレーベル"]]

    # 以下は、互換性エラーとなる
    #@cds = Cd.where(label: 'サザナミレーベル').or(Cd.where('price > 2000').limit(1))
    render 'yahoo/list'
  end

  def order
    @cds = Cd.where(label: 'サザナミレーベル').order(released: :desc)
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE "cds"."label" = ? 
    # ORDER BY "cds"."released" DESC
    # [["label", "サザナミレーベル"]]
  
    # @cds = Cd.where(label: 'サザナミレーベル').order(released: :desc, price: :asc)
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE "cds"."label" = ? 
    # ORDER BY 
    #   "cds"."released" DESC, "cds"."price" ASC  
    # [["label", "サザナミレーベル"]]

    render 'yahoo/list'
  end

  def reorder
    # @cds = Cd.order(:label).order(:price)
    # SELECT "cds".* 
    # FROM "cds" 
    # ORDER BY 
    #   "cds"."label" ASC, 
    #   "cds"."price" ASC

    # ORDERやり直し（使いみちがわからん）
    @cds = Cd.order(:label).reorder(:price)
    # SELECT "cds".* 
    # FROM "cds" 
    # ORDER BY "cds"."price" ASC

    # ORDER取り消し
    # @cds = Cd.order(:label).reorder(nil)
    # SELECT "cds".* FROM "cds"
    render 'cds/index'
  end

  def select
    @cds = Cd.where('price >= 2000').select(:title, :price)
    # SELECT 
    #   "cds"."title", 
    #   "cds"."price" 
    # FROM "cds" 
    # WHERE (price >= 2000)

    # ↓一部のフィールドが取得できないためエラーが出る
    render 'yahoo/list'
  end

  def select2
    @labs = Cd.select(:label).distinct.order(:label)
    # SELECT DISTINCT "cds"."label" 
    # FROM "cds" 
    # ORDER BY "cds"."label" ASC

    # DISTINCT取り消し
    # @labs = Cd.select(:label).distinct.distinct(false)
    # SELECT "cds"."label" FROM "cds"
  end

  def offset
    # 5~7件目を取得
    @cds = Cd.order(released: :desc).limit(3).offset(4)
    # SELECT  "cds".* 
    # FROM "cds" 
    # ORDER BY "cds"."released" DESC 
    # LIMIT ? 
    # OFFSET ?  
    # [["LIMIT", 3], ["OFFSET", 4]]
    render 'yahoo/list'
  end

  def page
    page_size = 3
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1
    @cds = Cd.order(released: :desc).limit(page_size).offset(page_size * page_num)
    # SELECT  "cds".* 
    # FROM "cds" 
    # ORDER BY "cds"."released" DESC 
    # LIMIT ? OFFSET ?  
    # [["LIMIT", 3], ["OFFSET", 3]]
    render 'yahoo/list'
  end

  def last
    # lastはクエリメソッドではないので、
    # メソッドチェーンの途中に記述することはできない
    @cd = Cd.order(released: :desc).last
    # SELECT  "cds".* 
    # FROM "cds" 
    # ORDER BY "cds"."released" ASC 
    # LIMIT ?
    # [["LIMIT", 1]]
    render 'cds/show'
  end

  def groupby
    @cds = Cd.select('label, AVG(price) AS avg_price').group(:label)
    # SELECT 
    #   label, 
    #   AVG(price) AS avg_price 
    # FROM "cds" 
    # GROUP BY "cds"."label"  
  end

  def havingby
    @cds = Cd.select('label, AVG(price) AS avg_price').group(:label).
      having('AVG(price) >= ?', 2500)
    # SELECT 
    #   label, 
    #   AVG(price) AS avg_price 
    # FROM "cds" 
    # GROUP BY "cds"."label" 
    # HAVING (AVG(price) >= 2500)
    render 'record/groupby'
  end

  def where2
    # メソッドチェーンを使わない方法
    @cds = Cd.all
    @cds.where!(label: 'サザナミレーベル')
    @cds.order!(:released)
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE "cds"."label" = ? 
    # ORDER BY "cds"."released" ASC 
    # [["label", "サザナミレーベル"]]
    render 'cds/index'
  end

  def unscope
    # クエリメソッドの取り消し
    @cds = Cd.where(label: 'サザナミレーベル').order(:price)
      .select(:jan, :title).unscope(:where, :select)
    # SELECT "cds".* 
    # FROM "cds" 
    # ORDER BY "cds"."price" ASC
    render 'cds/index'
  end

  def unscope2
    @cds = Cd.where(label: 'サザナミレーベル', is_major: true).order(:price)
      .unscope(where: :is_major)
    # SELECT "cds".* 
    # FROM "cds" 
    # WHERE "cds"."label" = ? 
    # ORDER BY "cds"."price" ASC  
    # [["label", "サザナミレーベル"]]
    render 'cds/index'
  end

  def none
    case params[:id]
      when 'all'
        @cds = Cd.all
      when 'new'
        @cds = Cd.order('released DESC').limit(5)
      when 'cheap'
        @cds = Cd.order(:price).limit(5)
      else
        # 空の結果セットを返すことで
        # 予期しないパラメータを与えられてもエラーにならない
        @cds = Cd.none
    end
    render 'cds/index'
  end

  # 指定列の配列を取得する
  def pluck
    render plain: Cd.where(label: 'サザナミレーベル').pluck(:title, :price)
    # SQL
    # SELECT "cds"."title", "cds"."price" FROM "cds" WHERE "cds"."label" = ?  [["label", "サザナミレーベル"]]
    # 出力結果
    # [["僕は停滞気味", 2000], ["エロス", 2000]]
  end

  # レコードの存在を確認する
  def exists
    flag = Cd.where(label: 'サザナミレーベル').exists?
    render plain: "存在するか？ : #{flag}"
    # SQL
    # SELECT 1 AS one FROM "cds" WHERE "cds"."label" = ? LIMIT ?  [["label", "サザナミレーベル"], ["LIMIT", 1]]
    # 出力結果
    # 存在するか？ : true
    # その他の例
    # 主キー検索
    # flag = Cd.exists?(1) 
    # レーベル名指定
    # flag = Cd.exists?(label: > 'サザナミレーベル') 
    # 5000円以上
    # flag = Cd.exists?(['price > ?', 5000]) 
  end

  # 名前付きスコープの使用例
  def scope
    # 名前付きスコープ（検索条件）はモデルファイル内で定義する
    @cds = Cd.sazanami
    render 'yahoo/list'
    # SQL
    # SELECT "cds".* FROM "cds" WHERE "cds"."label" = ?  [["label", "サザナミレーベル"]]

    # パラメータ化したスコープの呼び出し例
    # @cds = Cd.whats_new('サザナミレーベル')
  end

  # デフォルトスコープの使用例
  def def_scope
    # デフォルトスコープ（検索条件）はモデルファイル内で定義する
    render plain: Review.all.inspect
    # SQL
    # SELECT  "reviews".* FROM "reviews" ORDER BY "reviews"."updated_at" DESC LIMIT ?  [["LIMIT", 11]]
    # デフォルトスコープを解除したい場合はunscope()メソッドを使えばいいらしい
  end

  def count
    cnt = Cd.where(label: 'サザナミレーベル').count
    render plain: "#{cnt}件です"
    # SQL
    # SELECT COUNT(*) FROM "cds" WHERE "cds"."label" = ?  [["label", "サザナミレーベル"]]
    # その他の例
    # 主キー検索
    # cnt = Cd.count 
    # label列が空でないレコードの件数
    # cnt = Cd.count(:label) 
    # label列の種類
    # cnt = Cd.distinct.count(:label) 
  end

  def average
    price = Cd.where(label: 'サザナミレーベル').average(:price)
    render plain: "平均価格は#{price}円です。"
  end

  def groupby2
    @cds = Cd.group(:label).average(:price)
    render plain: @cds
    # SQL
    # SELECT AVG("cds"."price") AS average_price, "cds"."label" AS cds_label FROM "cds" GROUP BY "cds"."label"
    # 出力結果
    # {"エピックレコードジャパン"=>0.28e4, "サザナミレーベル"=>0.2e4, "ビクターエンタテインメント"=>0.3035e4, "モジャーレコーズ"=>0.333333333333333e4}

    # ↓とだいたい同じだけど呼び出し方法が異なる
    # @cds = Cd.select('label, AVG(price) AS avg_price').group(:label)
    # ↑呼び出し方が直感的なので、こっちの方法を推奨
  end

  def literal_sql
    @cds = Cd.find_by_sql(['SELECT label, AVG(price) AS avg_price FROM "cds" GROUP BY label HAVING AVG(price) >= ?', 2500])
    render 'record/groupby'
    # SQL
    # SELECT label, AVG(price) AS avg_price FROM "cds" GROUP BY label HAVING AVG(price) >= 2500
  end
end
