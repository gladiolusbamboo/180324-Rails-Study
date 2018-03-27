# .json.builder はJBUILDERを用いて
# JSON形式の出力を生成するテンプレートという意味
json.array! @cds, partial: 'cds/cd', as: :cd
