class CtrlController < ApplicationController
  def para
    # http://localhost:3000/ctrl/para/108
    # id:108を取得する
    render plain: 'idパラメーター：' + params[:id]
  end

  # パラメーターから配列を取得する例
  # ルーティングは一番シンプルなやつ↓でおｋ
  # get  'ctrl/para_array'
  def para_array
    # http://localhost:3000/ctrl/para_array?category[]=rails&category[]=ruby
    render plain: 'categoryパレメーター：' + params[:category].inspect
  end

  # パラメーターからハッシュを取得する例
  # ルーティングは一番シンプルなやつ↓でおｋ
  # get  'ctrl/para_hash'
  def para_hash
    # http://localhost:3000/ctrl/para_hash?category[a]=rails&category[b]=ruby
    render plain: 'categoryパレメーター：' + params[:category][:a].inspect
  end

  # リクエストヘッダ情報を取得する
  def req_head
    render plain: request.headers['User-Agent']
  end

  def req_head2
    # リクエストヘッダ情報だけでなくサーバー環境変数も取得できる
    @headers = request.headers
  end

  def upload_process
    # 送信フォーム
    # <%= form_tag({action: :upload_process}, multipart: true) do %>
    #   <label>ファイルを指定：<%= file_field_tag :upfile, size: 50 %></label>
    #   <%= submit_tag 'アップロード' %>
    # <% end %>

    # params[:upfile]でファイル情報受取り
    file = params[:upfile]
    name = file.original_filename 
    perms = ['.jpg', '.jpeg', '.gif', '.png']
    if !perms.include?(File.extname(name).downcase)
      result = 'アップロードできるのは画像ファイルのみです。'
    elsif file.size > 1.megabyte
      result = 'ファイルサイズは1MBまでです。'
    else 
      # ファイル保存処理（よくわからない）
      File.open("public/docs/#{name}", 'wb') { |f| f.write(file.read) }
      result = "#{name}をアップロードしました。"
    end
    render plain: result
  end

  def updb
    @artist = Artist.find(params[:id])
  end

  def updb_process
    # pp 'WAAAAAAAAAA'
    @artist = Artist.find(params[:id])
    # よくわからんが、:dataでモデルで定義したdata=メソッドが呼び出されているようだ
    # permitメソッドで受け取るプロパティを指定している
    # params[:data]で画像情報を受け取っている
    if @artist.update(params.require(:artist).permit(:data))
      render plain: '保存に成功しました。'
    else
      render plain: @artist.errors.full_messages[0]
    end
  end

  def show_photo
    @artist = Artist.find(1)
    # DBに保存したバイナリデータを出力する例
    send_data @artist.photo, type: @artist.ctype, disposition: :inline
  end

  def log
    logger.unknown('unknown')
    logger.fatal('fatal')
    logger.error('error')
    logger.warn('warn')
    logger.info('info')
    logger.debug('debug')
    render plain: 'ログはコンソール、またはログファイルから確認してください。'
  end

end
