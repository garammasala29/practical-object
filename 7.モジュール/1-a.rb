class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class}" + " is not scheduled\n" + " between #{start_date} and #{end_date}"
    false
  end
end

class Bicycle
  attr_reader :schedule, :size, :chain, :tire_size

  def initialize(args={})
    @schedule = args[:schedule] || Schedule.new
    @size = args[:size]
    @chain = args[:chain] || default_chain
    # @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  # 与えられた期間の間、bicycleが利用可能であればtrue
  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  # scheduleの答えを返す
  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # bicycleがスケジュール可能となるまでの準備日数を返す
  def lead_days
    1
  end

  def post_initialize(args)
    nil
  end

  def spares
    {tire_size: tire_size, chain: chain}.merge(local_spares)
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannnot respond to:"
  end
end

require 'date'
starting = Date.parse('2022/09/04')
ending = Date.parse('2022/09/10')

b = Bicycle.new
puts b.schedulable?(starting, ending)
# This Bicycleis not scheduled
#  between 2022-09-03 and 2022-09-10
# true

# Scheduleが何者であるか、何をするかをBicycleに隠してしまっている
# したがってScheduleの存在や振る舞いを知っておく必要がない
