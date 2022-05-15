class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(mph)
    @speed += mph
  end

  def brake(mph)
    @speed -= mph
  end

  def shut_off
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
  end
end

calvin = MyCar.new(2014, "blue", "Prius")
puts calvin.year
puts calvin.color
puts calvin.model
