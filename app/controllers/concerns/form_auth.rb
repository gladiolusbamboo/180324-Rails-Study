# 共通ロジックをまとめるときは
# concernsフォルダー下にモジュールとしておく
module FormAuth
  extend ActiveSupport::Concern

  included do
    before_action :check_logined
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
