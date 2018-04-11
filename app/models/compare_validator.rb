# 複数の項目を利用してバリデートを行う例
# validates: :min_value
#   compare: {compate_to: 'max_value', type: :less_than }
# のような使い方を想定している
class CompareValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # attributesメソッドで現在のモデルから値を取得している
    cmp = record.attributes[options[:compare_to]].to_i
    case options[:type]
      when :greater_than 
        record.errors.add(attribute, 'は指定項目より大きくなければなりません。')unless value > cmp
      when :less_than 
        record.errors.add(attribute, 'は指定項目より小さくなければなりません。')unless value < cmp
      when :equal 
        record.errors.add(attribute, 'は指定項目と等しくなければなりません。')unless value == cmp
      else
        raise 'unknown type'
    end
  end
end