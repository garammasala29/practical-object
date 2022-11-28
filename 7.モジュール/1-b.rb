class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class}" + " is not scheduled\n" + " between #{start_date} and #{end_date}"
    false
  end
end

# スケジュール可能(schedulable)なオブジェクトはBicycleだけでなくMechanicとVehicleもこの振る舞いを使う
# クラスが異なっても振る舞いを共有できるようモジュールにしてみる
module Schedulable
  attr_writer :schedule

  def schedule
    @schedule ||= ::Schedule.new
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # 必要に応じてインクルード側で置き換え
  def lead_days
    0
  end
end

class Bicycle
  include Schedulable

  def lead_days
    1
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

# メソッドをモジュールに移行し、インクルードしてlead_daysを上書き。Bicycleは正しく振る舞える

class Vehicle
  include Schedulable

  def lead_days
    3
  end

  # ...
end

class Mechanic
  include Schedulable

  def lead_days
    4
  end

  # ...
end

v = Vehicle.new
puts v.schedulable?(starting, ending)
# This Vehicle is not scheduled
#  between 2022-09-01 and 2022-09-10
# true

m = Mechanic.new
puts m.schedulable?(starting, ending)
# This Mechanic is not scheduled
#  between 2022-08-31 and 2022-09-10
# true

# クラスによる継承とモジュールによるコードの共有の違いは「である(is-a)」と「のように振る舞う(behaves-like-a)」の違い
