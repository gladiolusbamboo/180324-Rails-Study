class CtrlController < ApplicationController
  # 各アクションの開始時／終了時に実行するメソッド
  # before_actionでrenderやredirect_toメソッドを
  # 実行することでアクション本体を実行させないこともできる
  # before_action :start_logger, only: [:index]
  # after_action :end_logger, except: :index
  # まとめてaround_actionを利用する例
  # around_action :around_logger

  # skip_before_action,skip_after_actionなどで
  # 基底クラスから継承したフィルターを除外することもできる

  before_action :auth, only: :index

  def para
    # http://localhost:3000/ctrl/para/108
    # id:108を取得する
    render plain: 'idパラメーター：' + params[:id]
  end

  # パラメーターから配列を取得する例
  # ルーティングは一番シンプルなやつ↓でおｋ
  # get  'ctrl/para_array'
  def para_array
    # http://localhost:3000/ctrl/para_array?category[]=rails&category[]=ruby
    render plain: 'categoryパレメーター：' + params[:category].inspect
  end

  # パラメーターからハッシュを取得する例
  # ルーティングは一番シンプルなやつ↓でおｋ
  # get  'ctrl/para_hash'
  def para_hash
    # http://localhost:3000/ctrl/para_hash?category[a]=rails&category[b]=ruby
    render plain: 'categoryパレメーター：' + params[:category][:a].inspect
  end

  # リクエストヘッダ情報を取得する
  def req_head
    render plain: request.headers['User-Agent']
  end

  def req_head2
    # リクエストヘッダ情報だけでなくサーバー環境変数も取得できる
    @headers = request.headers
  end

  def upload_process
    # 送信フォーム
    # <%= form_tag({action: :upload_process}, multipart: true) do %>
    #   <label>ファイルを指定：<%= file_field_tag :upfile, size: 50 %></label>
    #   <%= submit_tag 'アップロード' %>
    # <% end %>

    # params[:upfile]でファイル情報受取り
    file = params[:upfile]
    name = file.original_filename 
    perms = ['.jpg', '.jpeg', '.gif', '.png']
    if !perms.include?(File.extname(name).downcase)
      result = 'アップロードできるのは画像ファイルのみです。'
    elsif file.size > 1.megabyte
      result = 'ファイルサイズは1MBまでです。'
    else 
      # ファイル保存処理（よくわからない）
      File.open("public/docs/#{name}", 'wb') { |f| f.write(file.read) }
      result = "#{name}をアップロードしました。"
    end
    render plain: result
  end

  def updb
    @artist = Artist.find(params[:id])
  end

  def updb_process
    # pp 'WAAAAAAAAAA'
    @artist = Artist.find(params[:id])
    # よくわからんが、:dataでモデルで定義したdata=メソッドが呼び出されているようだ
    # permitメソッドで受け取るプロパティを指定している
    # params[:data]で画像情報を受け取っている
    if @artist.update(params.require(:artist).permit(:data))
      render plain: '保存に成功しました。'
    else
      render plain: @artist.errors.full_messages[0]
    end
  end

  def show_photo
    @artist = Artist.find(1)
    # DBに保存したバイナリデータを出力する例
    send_data @artist.photo, type: @artist.ctype, disposition: :inline
  end

  def log
    logger.unknown('unknown')
    logger.fatal('fatal')
    logger.error('error')
    logger.warn('warn')
    logger.info('info')
    logger.debug('debug')
    render plain: 'ログはコンソール、またはログファイルから確認してください。'
  end

  # モデル情報をXML形式で表示する例
  def get_xml
    @cds = Cd.all
    render xml: @cds
    # 文字列で出力することもできる
    # render xml: '<error>123 Failed</error>'
  end

  # モデル情報をJSON形式で表示する例
  def get_json
    @cds = Cd.all
    render json: @cds
  end

  def download
    @cds = Cd.all
  end

  # cookie_recが実行されていると
  # 以前登録したメールアドレスを取得することができる
  def cookie
    @email = cookies[:email]
  end

  def cookie_rec
    # クッキー:emailをセット
    # expires : 有効期限
    # httponly : http通信のみでクッキーが取得できる。XSS対策にもなる
    cookies[:email] = {value: params[:email], expires: 3.months.from_now, http_only: true }
    render plain: 'クッキーを保存しました。'
    # クッキーの削除
    # cookies.delete(:email)

    # 永続化クッキー（20年）
    # cookies.permanent[:email] = {value: ...}
    # 暗号化クッキー
    # 暗号化キーはconfig/secrets.ymlに設定されている
    # production環境では環境変数を設定してやらないと動作しないので注意
    # cookies.encrypted[:email] = {value: ...}
  end
  
  # session_recが実行されていると
  # 以前登録したメールアドレスを取得することができる
  def session_show
    @email = session[:email]
  end

  def session_rec
    # セッションにemailをセット
    # デフォルトでクッキーストアに保存する
    session[:email] = params[:email]
    render plain: 'セッションを保存しました'
  end

  def active_record_store_show
    @email = session[:email]
  end

  def active_record_store_rec
    session[:email] = params[:email]
    render plain: 'セッションを保存しました'
  end

  def index
    sleep 3
    render plain: 'indexアクションが実行されました'
  end

  private 
    # スタート時間を記録
    def start_logger
      logger.debug('[Start]' + Time.now.to_s)
    end

    # フィニッシュ時間を記録
    def end_logger
      logger.debug('[Finish]' + Time.now.to_s)
    end

    # around_actionを使用した場合
    def around_logger
      logger.debug('[Sta]' + Time.now.to_s)
      yield
      logger.debug('[Fin]' + Time.now.to_s)
    end

    def auth
      name = 'kreva'
      # パスワードはあらかじめ暗号化しておくが
      # ここでは省略
      passwd = 'caloriemateplease'

      # 引数はレルム名（って何）
      authenticate_or_request_with_http_basic('Railsbook') do |n, p|
        n == name && p == passwd
      end
    end
end
