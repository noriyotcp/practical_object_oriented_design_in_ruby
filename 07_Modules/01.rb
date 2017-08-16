class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class}" + " is not scheduled\n" + " between #{start_date} and #{end_date}"
    false
  end
end

module Schedulable
  attr_writer :schedule

  def schedule
    @schedule ||= Schedule.new
  end

  # 与えられた期間の間、bicycle が利用可能であればtrue を返す
  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  # schedule の答えを返す
  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  def lead_days
    0
  end
end

class Bicycle
  include Schedulable

  # bicycle がスケジュール可能となるまでの準備日数を返す
  def lead_days
    1
  end

  # ...
end

class Vehicle
  include Schedulable

  # bicycle がスケジュール可能となるまでの準備日数を返す
  def lead_days
    3
  end

  # ...
end

class Mechanic
  include Schedulable

  # bicycle がスケジュール可能となるまでの準備日数を返す
  def lead_days
    4
  end

  # ...
end

require 'date'
starting = Date.parse("2017/08/15")
ending = Date.parse("2017/08/22")

b = Bicycle.new
b.schedulable?(starting, ending)
# This Bicycle is not scheduled
#  between 2017-08-14 and 2017-08-22

b = Vehicle.new
b.schedulable?(starting, ending)

b = Mechanic.new
b.schedulable?(starting, ending)
