module Cargoable
  def can_carry?(pounds)
    pounds < 1500
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize
    @@number_of_vehicles += 1
  end

  def self.total_number_of_vehicles
    @@number_of_vehicles
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

  def to_s
    "This vehicle is a #{color} #{year} #{model}."
  end

  def spray_paint(color)
    self.color = color
  end

  def self.gas_mileage(miles, gallons)
    "#{miles / gallons} miles per gallon"
  end

  def age
    "This #{self.model} is #{years_old} years old."
  end

  private
  
  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUM_WHEELS = 4

  def initialize(year, color, model)
    super()

    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def to_s
    "This car is a #{color} #{year} #{model}." 
  end
end

class MyTruck < Vehicle
  NUM_WHEELS = 8

  include Cargoable

  def check_load_size(pounds)
    if self.can_carry?(pounds)
      puts "This truck can handle #{pounds} lb."
    else
      puts "#{pounds} lb is too heavy for this truck."
    end
  end

  def initialize(color)
    super()

    @color = color
  end

  def to_s
    "This truck is #{color}." 
  end
end

calvin = MyCar.new(2014, "blue", "Prius")
puts calvin.year
puts calvin.color
puts calvin.model
puts MyCar.gas_mileage(50, 1)
puts calvin
puts calvin.age

a_truck = MyTruck.new("blue")
puts a_truck
a_truck.check_load_size(1000)
puts "Total vehicles: #{Vehicle.total_number_of_vehicles}"
puts "Method lookup path for Vehicle: #{Vehicle.ancestors}"
puts "Method lookup path for MyCar: #{MyCar.ancestors}"
puts "Method lookup path for MyTruck: #{MyTruck.ancestors}"
