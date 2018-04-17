# .json.builder はJBUILDERを用いて
# JSON形式の出力を生成するテンプレートという意味
# 部分テンプレートcds/_cd.jsonが呼び出されている
# .html.erbと同様
# @cdsから順番に要素を取り出して、
# 部分テンプレートcds/cdで描画する
# 個々の要素にはcdという変数でアクセスできる
# という意味
json.array! @cds, partial: 'cds/cd', as: :cd
