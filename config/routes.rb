# ルーティング設定を指定する
Rails.application.routes.draw do
  resources :members
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

  get  'view/capture'

  get  'view/tag'

  get  'view/content_tag'
  
  get  'view/helper'
  get  'view/helper2'
  get  'view/helper3'

  get  'view/provide'

  get  'view/multi'
  get  'view/relation'
  get  'view/download'
  get  'view/quest'

  get  'view/nest'

  get  'view/partial_basic'
  get  'view/partial_param'
  get  'view/partial_col'
  get  'view/partial_spacer'

  get  'record/find'
  get  'record/find_by'

  get  'record/where'

  get  'record/keyword'
  post 'record/ph1'

  get  'record/not(/:id)', to: 'record#not'

  get  'record/where_or'

  get  'record/order'
  get  'record/reorder'

  get  'record/select'

  get  'record/select2'

  get  'record/offset'
  get  'record/page(/:id)', to: 'record#page'

  get  'record/last'

  get  'record/groupby'
  get  'record/havingby'

  get  'record/where2'

  get  'record/unscope'
  get  'record/unscope2'

  get  'record/none(/:id)', to: 'record#none'

  get  'record/pluck'

  get  'record/exists'

  get  'record/scope'
  get  'record/def_scope'

  get  'record/count'

  get  'record/average'

  get  'record/groupby2'

  get  'record/literal_sql'

  get  'record/update_all'
  get  'record/update_all2'

  get  'record/destroy2/:id', to: 'record#destroy2'
  get  'record/delete/:id', to: 'record#delete'

  get  'record/destroy_all'
  get  'record/delete_all'

  get  'record/transact'

  get  'record/enum_rec'

  get  'record/keywd'
  post 'record/keywd_process'

  get  'record/belongs'

  get  'record/hasmany'
  get  'record/hasone'

  get  'record/has_and_belongs'
  get  'record/has_many_through'

  get  'record/cache_counter'

  get  'record/memorize'

  get  'record/assoc_join'
  get  'record/assoc_join2'
  get  'record/assoc_join3'
  get  'record/assoc_join4'

  get  'record/assoc_includes'

  get  'record/attr'

  get  'ctrl/para(/:id)', to: 'ctrl#para'

  get  'ctrl/para_array'
  get  'ctrl/para_hash'

  get  'ctrl/req_head'
  get  'ctrl/req_head2'

  get  'ctrl/upload'
  post 'ctrl/upload_process'

  get  'ctrl/updb(/:id)', to: 'ctrl#updb'
  patch 'ctrl/updb_process(/:id)', to: 'ctrl#updb_process'

  get  'view/render1'
  get  'view/render2'
  get  'view/render3'
  get  'view/render4'

  get  'view/render_head'

  get  'view/redirect'

  get  'view/index'

  get  'view/redirectback'

  get  'view/sendfile'

  get  'ctrl/show_photo'

  get  'ctrl/log'

  # passwordパラメーターはfilteredとログに記録される
  get  'listeners/:id/:password', to: 'listeners#show'

  get  'ctrl/get_xml'
  get  'ctrl/get_json'

  get  'ctrl/download'

  get  'ctrl/cookie'
  post 'ctrl/cookie_rec'

  get  'ctrl/session_show'
  post 'ctrl/session_rec'

  get  'ctrl/active_record_store_show'
  post 'ctrl/active_record_store_rec'
end
