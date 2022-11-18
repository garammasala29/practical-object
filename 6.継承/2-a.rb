# 具象から始める
# 自転車には全体のサイズ、ハンドルのテープカラー、タイヤのサイズ、チェーンタイプがあり、それらの部品は不可欠なものなのでスペアはいつも持っておく必要がある
class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size = args[:size]
    @tape_color = args[:tape_color]
  end

  # 全ての自転車はデフォルト値、同じタイヤサイズとチェーンサイズを持つ
  def spares
    {chain: '10-speed', tire_size: '23', tape_color: tape_color}
  end

  # ...
end

bike = Bicycle.new(size: 'M', tape_color: 'red')
puts bike.size
puts bike.spares

# これはロードバイクの例なので、マウンテンバイクにも対応させる必要がある。
# ロードバイク：ハンドルバーのテープが必須
# マウンテンバイク：サスペンションの備えが必須
