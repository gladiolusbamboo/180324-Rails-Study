class CdsController < ApplicationController
  # コントローラー単位でレイアウトを設定する場合、
  # layouts配下にコントローラーと同名のレイアウトファイルを作成する

  # レイアウトを指定したい場合
  # layout 'my_layout'
  # falseを指定した場合、レイアウトを適用しない

  # アクション単位でレイアウトを設定したい場合
  # def adopt
  #   render layout: 'my_layout'
  # end
  # falseを指定した場合、レイアウトを適用しない

  # before_action: アクションメソッドの前に実行するメソッドを指定する
  # このようなメソッドをフィルターという
  before_action :set_cd, only: [:show, :edit, :update, :destroy]

  # GET /cds
  # GET /cds.json
  def index
    @cds = Cd.all
  end

  # GET /cds/1
  # GET /cds/1.json
  def show
  end

  # GET /cds/new
  def new
    # 新規作成の場合は空のオブジェクトを渡す
    @cd = Cd.new
  end

  # GET /cds/1/edit
  def edit
  end

  # POST /cds
  # POST /cds.json
  # _form.html.erbのフォームから
  # /cdsにPOSTで入力データが渡されて発火する
  def create
    # Unique検証で以下のSQLが発行される
    # SELECT 1 AS one
    # FROM "cds" 
    # WHERE "cds"."jan" = ? 
    # LIMIT ?  
    # [["jan", "978-4-7741-7568-3"], 
    # 　["LIMIT", 1]]

    # 入力されたデータからオブジェクトを作成する
    # cd_paramsはメソッドではなくその返り値
    # (cd_params()の括弧を省略した形)
    # インスタンス変数に代入しているのはエラー時の表示処理のため
    # pp cd_params
    @cd = Cd.new(cd_params)

    # respond_toメソッドは指定されたフォーマットに応じて
    # 異なるテンプレートを呼び出す仕組み
    respond_to do |format|
      # 作成したオブジェクトを保存する
      # 成功したら
      if @cd.save
        # 指定されたフォーマットがHTMLなら
        # cds/{id値}にリダイレクトする
        # (@cdはオブジェクトのキー値と解釈される)
        # またオプションとしてデータを渡すことで
        # ビューテンプレートからローカル変数っぽく利用できる
        format.html { redirect_to @cd, notice: 'Cd was successfully created.' }
        # 指定されたフォーマットがJSONなら
        # show.json.builderで新規作成されたデータをJSON形式で出力する
        # status:はステータスコード
        # location:はリソース位置のURLを表す
        format.json { render :show, status: :created, location: @cd }
      # 失敗したら
      else
        # 指定されたフォーマットがHTMLなら
        # new.html.erbを再描画する
        format.html { render :new }
        # 指定されたフォーマットがJSONなら
        # エラー情報をJSON形式で書き出す
        # unprocessable_entityはデータを処理できなかったことを示す
        format.json { render json: @cd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cds/1
  # PATCH/PUT /cds/1.json
  # _form.html.erbのフォームから
  # /cds/{キー値}にPATCHで入力データが渡されて発火する
  def update
    sleep 3

    # フィルターに設定されている
    # set_cdメソッドにより@cdにはオブジェクトが取得されている

    # respond_toメソッドは指定されたフォーマットに応じて
    # 異なるテンプレートを呼び出す仕組み
    respond_to do |format|
      # 作成したオブジェクトを更新する
      # 成功したら
      if @cd.update(cd_params)
        # 指定されたフォーマットがHTMLなら
        # cds/{id値}にリダイレクトする
        # (@cdはオブジェクトのキー値と解釈される)
        # またオプションとしてデータを渡すことで
        # ビューテンプレートからローカル変数っぽく利用できる
        format.html { redirect_to @cd, notice: 'Cd was successfully updated.' }
        # 指定されたフォーマットがJSONなら
        # show.json.builderで新規作成されたデータをJSON形式で出力する
        # status:はステータスコード
        # location:はリソース位置のURLを表す
        format.json { render :show, status: :ok, location: @cd }
      # 失敗したら
      else
        # 指定されたフォーマットがHTMLなら
        # edit.html.erbを再描画する
        format.html { render :edit }
        # 指定されたフォーマットがJSONなら
        # エラー情報をJSON形式で書き出す
        # unprocessable_entityはデータを処理できなかったことを示す
        format.json { render json: @cd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cds/1
  # DELETE /cds/1.json
  def destroy
    # フィルターに設定されている
    # set_cdメソッドにより@cdにはオブジェクトが取得されている

    # オブジェクトを削除する
    @cd.destroy
    # respond_toメソッドは指定されたフォーマットに応じて
    # 異なるテンプレートを呼び出す仕組み
    respond_to do |format|
      # 指定されたフォーマットがHTMLなら
      # ビューヘルパーを経由して/cdsへリダイレクトする
      format.html { redirect_to cds_url, notice: 'Cd was successfully destroyed.' }
      # 指定されたフォーマットがJSONなら
      # headメソッドを使用してステータスコードを返す
      # :no_contentはステータスコード204 No Contentを表す
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # フィルターとしてアクションの前に呼び出されるメソッド
    def set_cd
      # params: URL経由で渡されたパラメータを取得するメソッド
      # ここではオブジェクトのキー値を取得している
      # 取得したキー値をもとにfindメソッドで特定のオブジェクトを取得する
      @cd = Cd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # フォームからの入力値を取得する
    def cd_params
      # 定型句として覚えろ
      params.require(:cd).permit(:jan, :title, :price, :artist, :released, :is_major, :label)
      # 具体的な戻り値は以下のようなハッシュになる
      # { 
      #   "id"=>"51848956", 
      #   "jan"=>"4988002756452", 
      #   "title"=>"充分未来",
      #   "price"=>2000,
      #   "artist"=>"集団行動",
      #   "released(1i)"=>"2018",
      #   "released(2i)"=>"2",
      #   "released(3i)"=>"7",
      #   "is_major"=>"0",
      # }       
    end
end
