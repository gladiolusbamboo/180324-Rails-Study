# <cds>要素を生成
xml.cds do
  # @cdsをもとに順に<cd>要素を生成
  @cds.each do |cd|
    xml.cd(jan: cd.jan) do
      xml.title(cd.title)
      xml.price(cd.price)
      xml.label(cd.label)
      xml.released(cd.released)
      xml.is_major(cd.is_major)
    end
  end
end

# 出力結果
# <cds>
# <cd jan="978-4-7741-8411-1">
# <title>充分未来</title>
# <price>2980.0</price>
# <label>ビクターエンタテインメント</label>
# <released>2016-09-30</released>
# <is_major>false</is_major>
# </cd>
# ︙
# </cds>
