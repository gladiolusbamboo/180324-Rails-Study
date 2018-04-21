class ApplicationController < ActionController::Base
  # CSRF対策
  # 留意点
  # HTTP GETによるリンクでデータ操作を行わない
  # データ操作のリクエストはビューヘルパー経由で生成する
  # レイアウトを自分で作成する場合は、csrf_meta_tagsメソッドの呼び出しを忘れない
  protect_from_forgery with: :exception
  # すべてのコントローラー(login覗く)でログインチェックを必須にする
  # before_action :check_logined
  before_action :detect_device

  # RecordNotFoundが補足されると
  # id_invalidメソッドが実行される
  rescue_from ActiveRecord::RecordNotFound, with: :id_invalid

  add_flash_types :info

  # アノテーションの書き方
  # #TODO: あとから実装
  # #FIXME: 修正が必要
  # #OPTIMIZE: コードの最適化が必要
  # rails notes, rails notes:todo
  # などのコマンドで列挙できる

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

    def id_invalid(e)
      render 'shared/record_not_found', status: 404
    end

    # アクセスする端末によってビューを切り替える
    # request.variantを利用する
    def detect_device
      case params[:type]
      when 'mobile'
        request.variant = :mobile
      when 'tablet'
        request.variant = :tablet
      end
    end
end
