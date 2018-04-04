module ViewHelper
  # 日付時刻値を整形して表示するヘルパーメソッド
  # datetime : 整形対象の日付時刻値
  # type : 出力形式
  def format_datetime(datetime, type = :datetime)
    # 後置unless(後置if)という記法
    return '' unless datetime

    case type
      when :datetime
        format = '%Y年%m月%d日 %H:%M:%S'
      when :date
        format = '%Y年%m月%d日'
      when :time
        format = '%H:%M:%S'
    end

    datetime.strftime(format)
  end

  # collection : リストのもととなるオブジェクト配列
  # prop : 一覧するプロパティ名
  def list_tag(collection, prop)
    # pp collection.inspect
    # pp 'coll : ' + collection.to_s
    # pp 'prop : ' + prop.to_s
    # content_tag => htmlタグを出力する
    # content_tagのブロックはブロック内の処理結果をcontentとして扱う
    # content_tagメソッドを使うことで適切なエスケープができる
    content_tag(:ul) do
      collection.each do |element|
        # concatメソッドはRubyの結合を行うものではなく、
        # Railsの出力を行うメソッドのようだ！
        concat content_tag(:li, element.attributes[prop])
      end
    end
    # 出力例
    # <ul><li>充分未来</li>
    # <li>星眠る島</li>
    # <li>カンバセイション</li>
    # <li>僕は停滞気味</li>
    # <li>エロス</li>
    # <li>MICHITONOSOGU</li>
    # <li>つしまげる</li>
    # <li>すてきな15才</li>
    # <li>KICK!</li>
    # <li>AOKAJI</li></ul>
  end

  # list_tagメソッドをcontent_tagメソッドを使わずに書き換えた例
  def list_tag2(collection, prop)
    list = '<ul><li>bbb</li>'
    collection.each do |element|
      # これはRubyの結合を行うほうのconcat!
      list.concat('<li>')
      # h はRails側のメソッドでエスケープ処理を行っている
      # 1文字のメソッドとか作るな
      list.concat(h element.attributes[prop])
      list.concat('</li>')
    end
    # 返す値はタグを有効にする必要がある
    raw list.concat('</ul>')
    # エスケープしたり解凍したりややこしいから
    # なるべく頑張ってcontent_tagを使おう！
  end

  # 引用部分をフォーマットする
  def blockquote_tag(cite, citetext, options = {}, &block)
    # mergeメソッドでoptionsのハッシュにciteオプションを追加
    options.merge! cite: cite
    # options => {:class=>"quote", :cite=>"http://www.wings.msn.to"}

    # captureメソッド : 与えられたブロックを解釈し結果を文字列で返す    
    # capture(&block) =>
    # "\n" +
    # "  WINGSプロジェクトは、当初、ライター山田祥寛のサポート（検証・査読・校正作業）集団という位置づけで開始されたコ
    # ミュニティでしたが、2002年12月にメンバを大幅に増強し、本格的な執筆者プロジェクトとして生まれ変わりました。<br />\n" +
    # "  <img src=\"http://www.wings.msn.to/image/wings.jpg\" alt=\"Wings\" />\n"

    quote_tag = content_tag(:blockquote, capture(&block), options)
    # quote_tag =>
    # "<blockquote class=\"quote\" cite=\"http://www.wings.msn.to\">\n" +
    # "  WINGSプロジェクトは、当初、ライター山田祥寛のサポート（検証・査読・校正作業）集団という位置づけで開始されたコ
    # ミュニティでしたが、2002年12月にメンバを大幅に増強し、本格的な執筆者プロジェクトとして生まれ変わりました。<br />\n" +
    # "  <img src=\"http://www.wings.msn.to/image/wings.jpg\" alt=\"Wings\" />\n" +
    # "</blockquote>"

    p_tag = content_tag(:p) do
      concat '出典：'
      concat content_tag(:cite, citetext)
    end
    quote_tag.concat(p_tag)
  end

end
