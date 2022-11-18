class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def default_chain
    '10-speed'
  end
end

# 何の気無しにサブクラスを作る
class RecumbentBike < Bicycle
  def default_chain
    '9-speed'
  end
end

bent = p RecumbentBike.new
# undefined local variable or method `default_tire_size' for #<RecumbentBike:0x00000001008bc170 @size=nil, @chain="9-speed"> (NameError)

# 以下のようなデフォルトのタイヤサイズが必要だというエラーを設定しておくと親切
# def default_tire_size
#   raise NotImplementedError, "This #{self.class} cannnot respond to:"
# end

#=> `default_tire_size': This RecumbentBike cannnot respond to: (NotImplementedError)
