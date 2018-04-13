class CdCallbacks
  # よくわからん
  # クラス変数を定義しているらしい
  cattr_accessor :logger
  # loggerが設定されていなければRailsデフォルトのロガーを代入するの意味
  self.logger ||= Rails.logger

  def after_destroy(b)
    logger.info('deleted: ' + b.inspect)
  end
end