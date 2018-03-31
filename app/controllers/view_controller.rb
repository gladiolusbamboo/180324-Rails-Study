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
end
