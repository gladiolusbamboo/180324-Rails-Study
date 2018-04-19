class LoginController < ApplicationController
  def auth
    usr = Listener.find_by(listenername: params[:listenername])
    # logger.debug 'HHHHHHH'
    # logger.debug usr.inspect
    if usr && usr.authenticate(params[:password]) then
      reset_session
      session[:usr] = usr.id
      redirect_to params[:referer]
    else
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
