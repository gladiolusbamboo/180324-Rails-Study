class LoginController < ApplicationController
  # loginコントローラーではチェックの必要がない
  skip_before_action :check_logined

  # ログインボタンクリックで実行されるアクション
  def auth
    # ユーザー名からユーザー情報を取得
    usr = Listener.find_by(listenername: params[:listenername])
    # logger.debug 'HHHHHHH'
    # logger.debug usr.inspect
    # 認証が成功したら
    if usr && usr.authenticate(params[:password]) then
      # セッションを破棄して
      reset_session
      # セッションに:usrをセットして
      session[:usr] = usr.id
      # 元々のページにリダイレクトする
      # フラッシュ→隠しフィールドの順に元々のページ情報を保存している
      redirect_to params[:referer]
    else
      # 同じページを再描画するので
      # flash.nowメソッドで元々のページデータを保持する
      flash.now[:referer] = params[:referer]
      @error = 'ユーザ名／パスワードが間違っています。'
      render 'index'
    end
  end

  def logout
    reset_session
    redirect_to '/'
  end

end
