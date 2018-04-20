class SampleController < ApplicationController
  # app/controllers/concerns/form_auth.rbに定義している
  # モジュールを適用する
  include FormAuth
  def index
    render plain: 'こんにちは、世界！'
  end
end
