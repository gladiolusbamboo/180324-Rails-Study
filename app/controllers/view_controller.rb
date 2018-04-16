class ViewController < ApplicationController
  def form_tag
    @cd = Cd.new
  end

  def form_for
    # @cd = Cd.new
    @cd = Cd.find(1)
  end

  def field
    @cd = Cd.new
    # @cd = Cd.find(1)
  end

  def html5
    @cd = Cd.new
    # @cd = Cd.find(1)
  end

  def select
    @cd = Cd.new
    # @cd = Cd.find(1)
  end

  def col_select
    # フォームのもととなるモデルを準備する
    # デフォルトの選択となる
    @cd = Cd.new(label: 'サザナミレーベル')
    # 選択オプションの情報を取得する
    # .distinctでオプションの重複を排除している
    @cds = Cd.select(:label).distinct
    # @cd = Cd.find(1)
  end

  # グループ化した選択ボックスを作成する（複雑！）
  def group_select
    # 編集対象のモデルのオブジェクトを作成し
    @review = Review.new
    # グループ化する対象のオブジェクトを作成する
    @artists = Artist.all
  end

  def col_select2
    # 選択オプションの情報を取得する
    # .distinctでオプションの重複を排除している
    @cds = Cd.select(:label).distinct
    # @cd = Cd.find(1)
  end

  # グループ化した選択ボックスを作成する（複雑！）
  def group_select2
    # グループ化する対象のオブジェクトを作成する
    @artists = Artist.all
  end

  def dat_select
    @cd =Cd.find(1)
  end

  def col_radio
    @cd = Cd.new(label: 'サザナミレーベル')
    @cds = Cd.select(:label).distinct
  end

  def fields
    @listener = Listener.find(1)
  end

  def conc
    @cds = Cd.all
  end

  def no_escape
    @msg = '<h1>h1</h1>';
  end

  # url_forメソッドなどで返すURLのデフォルト設定の変更
  # options={}はデフォルト値付きの引数を設定している
  # Rubyではreturnを省略する（ややこい）
  def default_url_options(options={})
    {
      charset: 'utf-8'
    }
  end

  def multi
    # layoutレイアウトを設定
    render layout: 'layout'
  end

  # テンプレートの入れ子
  def nest
    @msg = 'view_controllerで設定したメッセージ'
    # コントローラーからの呼び出しはrender layout:を使う
    # layouts/child.html.erbを呼び出す
    render layout: 'child'
  end

  def partial_basic
    @cd = Cd.find(1)
    # pp @cd.title
  end

  def partial_param
    @cd = Cd.find(1)
  end

  def partial_col
    @cds = Cd.all
  end

  def partial_spacer
    @cds = Cd.all
  end

  def render1
    # views/view/index.html.erbを呼び出す
    # アクションを呼び出しているわけではない
    # render action: 'index'
    # 省略形
    # render 'index'

    # 現在のコントローラーと異なるコントローラーのテンプレートを呼び出す
    # render template: 'yahoo/view'
    # 省略形
    # render 'yahoo/view'

    # アプリ外のテンプレートを呼び出す例
    # 絶対パスを指定する
    render file: '/data/template/list'
    # 省略形
    # render '/data/template/list'
  end

  def render2
    # プレーンテキストを出力する例
    render plain: '今日は高田馬場に来ています'
  end

  def render3
    # HTMLを出力する例
    render html: '<div style="color: orange;">今日は高田馬場に来ています</div>'.html_safe
  end

  def render4
    # ERBテンプレートを出力する例
    render inline: 'リクエスト情報：<%= debug request.headers %>'
  end

  def render_head
    # ステータスコードだけを返す
    # head :not_found
    # head 404
    render plain: 'ファイルが見つかりませんでした', status: :not_found
  end

  def redirect
    # リダイレクトの書き方いろいろ
    # redirect_to 'http://yjkym.hatenablog.com/'
    # redirect_to action: :index
    # redirect_to controller: :cds, action: :index
    # 恒久的なリダイレクトの場合はstatusを設定しといてやるといいかも
    redirect_to artists_path, status: 301
  end

  def redirectback
    # 直前ページにリダイレクトする
    redirect_back fallback_location: { controller: 'yahoo', action: 'index' }
  end

  def sendfile
    # ファイルをダウンロードする例
    # 絶対パスでファイルを指定
    # send_file '/home/vagrant/workspace/chelmico_ep.jpg'
    # ブラウザに表示する例    
    send_file '/home/vagrant/workspace/chelmico_ep.jpg', type: 'image/jpeg', disposition: :inline
    # 別名を付けてダウンロードする例
    # send_file '/home/vagrant/workspace/chelmico_ep.jpg', filename: 'chel.jpg'
    # ユーザーに直接ファイル名を指定させないこと！    
  end
end
