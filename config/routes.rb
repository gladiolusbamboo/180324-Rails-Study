# ルーティング設定を指定する
Rails.application.routes.draw do
  resources :fan_comments
  resources :reviews
  resources :artists
  resources :listeners
  # resoucesメソッドで以下のようなルーティングが設定される
  # :formatが省略された場合はhtmlとみなされる
  # GET    /cds(.:format)          cds#index
  # POST   /cds(.:format)          cds#create
  # GET    /cds/new(.:format)      cds#new
  # GET    /cds/:id/edit(.:format) cds#edit
  # GET    /cds/:id(.:format)      cds#show
  # PATCH  /cds/:id(.:format)      cds#update
  # PUT    /cds/:id(.:format)      cds#update
  # DELETE /cds/:id(.:format)      cds#destroy
  resources :cds
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 'yahoo/index' というURLが要求(GET)されたら
  # 'yahoo'コントローラーの'index'アクションを呼び出す
  # 'hoge/page'など無関係なURLを割り当てることも可
  get 'yahoo/index', to: 'yahoo#index'

  # to: を省略した書き方
  get 'yahoo/view'
  # get 'yahoo/view', to: 'yahoo#view'と同等

  get 'yahoo/list'
  get 'yahoo/hatena'
end
