# 自作のバリデータを利用する例
# クラス名は{検証名}Validator
# /models配下におく
class JanValidator < ActiveModel::EachValidator
  # validate_eachメソッドにバリデーションの実装をする
  # record: 検証対象のモデルオブジェクト
  # attribute: 検証対象のフィールド名
  # value: 検証対象の値

  # :allow_old: パラメータを渡すこともできる
  # モデルからjan: { allow_old: true }
  # みたいなバリデータ設定で渡す
  def validate_each(record, attribute, value)
    if options[:allow_old]
      pattern = '\A([0-9]{3}-)?[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z'
    else
      pattern = '\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z'
    end
    # 後置if嫌い
    # 正規表現でキャプチャできなければ、エラー情報を登録する
    record.errors.add(attribute, 'は正しい形式ではありません。') unless value =~ /#{pattern}/
  end
end