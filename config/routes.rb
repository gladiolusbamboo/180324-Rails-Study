# ルーティング設定を指定する
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 'yahoo/index' というURLが要求(GET)されたら
  # 'yahoo'コントローラーの'index'アクションを呼び出す
  # 'hoge/page'など無関係なURLを割り当てることも可
  get 'yahoo/index', to: 'yahoo#index'

end
