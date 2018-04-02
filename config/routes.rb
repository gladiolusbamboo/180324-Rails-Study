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

  get 'labels/index'

  get  'view/keyword'
  post 'keyword/search'

  get  'view/form_tag'
  post 'view/create'

  get  'view/form_for'

  get  'view/field'
  get  'view/html5'

  get  'view/select'

  get  'view/col_select'

  get  'view/group_select'

  get 'view/select_tag'
  get 'view/select_tag2'

  get 'view/col_select2'

  get  'view/group_select2'

  get  'view/dat_select'

  get  'view/col_radio'

  get  'view/fields'

  get  'view/simple_format'

  get  'view/truncate'

  get  'view/excerpt'

  get  'view/highlight'

  get  'view/conc'

  get  'view/no_escape'

  get  'view/sanitize'

  get  'view/format'

  get  'view/number_to'

  get  'view/datetime'

  get  'view/link'

  get  'view/urlfor'
  get  'view/new'
  get  'members/login'

  get  'login/index'
  get  'login/info'

  get  'view/linkif'

  get  'view/current'
  get  'view/detail'

  get  'view/mailto'

  get  'view/image_tag'

  get  'view/audio'
  get  'view/video'

  get  'view/path'
end
