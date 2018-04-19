# コントローラークラスはすべてApplicationControllerクラスを継承する
class YahooController < ApplicationController
  # 不必要なアクションメソッドは省略可能。
  # 省略した場合、直接テンプレートファイルを実行してくれる

  # yahoo/viewにアクセスすると認証処理が行われる
  before_action :check_logined, only: :view

  # クライアントからのリクエストに対して
  # 具体的な処理を実行するメソッドを
  # アクションメソッドといい、
  # コントローラークラスにpublicで実装する
  def index
    # 文字列を出力する
    # palin: Viewを介さずに出力する
    render plain: 'ヤッホー 世界！'
  end

  def view
    # テンプレート変数(@～)を設定することで
    # ビューにデータを渡すことができる
    @msg = 'ヤッホー！世界！'
    # 以下のような書き方でデフォルト以外の
    # テンプレートを指定することも可能
    # render 'yahoo/template_hoge'
  end

  def list
    # Cdオブジェクトのallメソッド呼び出し
    # Rubyでは引数なしの関数呼び出しを示す()は不要
    # （あってもいい）
    # 返り値はCdオブジェクトの配列
    @cds = Cd.all
    # 発行されるSQL
    # SELECT "cds".* FROM "cds"

    # Rubyで外部からアクセスできるのは
    # 基本的にメソッドだけ？
    # インスタンス変数とかは多分
    # ゲッターメソッドで呼び出す。多分
  end

  def hatena
    # config\initializers\my_config.rb
    # でアプリ固有の設定情報をMY_APPに読み込んでいる
    render plain: MY_APP['hatena_blog']['title'] + '：' + MY_APP['hatena_blog']['url']
  end

  private
    def check_logined
      # logger.debug('START:check_logined')
      # セッション情報に:usrが含まれていれば
      if session[:usr]
        # ユーザー情報を取得し
        begin
          @usr = Listener.find(session[:usr])
        # 失敗したらセッション情報を破棄する
        rescue ActiveRecord::RecordNotFound
          reset_session
        end
      end
      # ユーザー情報を取得できなかった場合にはログインページへ
      unless @usr
        # flashを使って、リクエスト元のページの情報を共有する
        flash[:referer] = request.fullpath
        redirect_to controller: :login, action: :index
      end
    end
end
