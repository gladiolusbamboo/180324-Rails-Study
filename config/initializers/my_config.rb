# 設定ファイルを読み込む
# YAML.loadで読み込んだymlファイルの情報から
# 現在の開発環境に設定しているものを読み込み、
# グローバル変数に代入している
MY_APP = YAML.load(File.read("#{Rails.root}/config/my_config.yml"))[Rails.env]
