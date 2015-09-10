class Interview
  require 'csv'
  attr_reader :company, :time_slot, :student_id, :room

  def initialize(attrs)
    @company    = attrs["company"]
    @student_id = attrs["student_id"]
    @room       = attrs["room"]
    @time_slot  = set_time_slot(attrs["day"], attrs["time"])
  end

  def self.all
    @all ||= CSV.read("interviews.csv", headers: true).map do |row|
      Interview.new(row)
    end
  end

  def self.find_all_by(col, val)
    val = val.to_s.downcase
    self.all.select do |interview|
      interview if interview[col].to_s.downcase == val
    end
  end

  def [](col)
    instance_eval(col.to_s)
  end

  def set_time_slot(day, time)
    time.insert(0, "0") if time.length == 4
    DateTime.strptime("#{day} #{time}", "%m/%d/%y %I:%M")
  end
end

Interview.all
