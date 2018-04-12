class Memo < ApplicationRecord
  # polumorphicは複数の親モデルに関連付けるオプション
  # A or B or Cの親モデルに関連付けるの意味で
  # 複合キーの話ではない！
  belongs_to :memoable, polymorphic: true
end
