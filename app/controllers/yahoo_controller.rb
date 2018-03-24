# コントローラークラスはすべてApplicationControllerクラスを継承する
class YahooController < ApplicationController
  # クライアントからのリクエストに対して
  # 具体的な処理を実行するメソッドを
  # アクションメソッドといい、
  # コントローラークラスにpublicで実装する
  def index
    # 文字列を出力する
    # palin: Viewを介さずに出力する
    render plain: 'ヤッホー 世界！'
  end
end
