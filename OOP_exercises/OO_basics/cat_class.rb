module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable

  attr_accessor :name

  @@total_number_of_cats = 0

  def self.total
    @@total_number_of_cats
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def initialize(name)
    @name = name
    @@total_number_of_cats += 1
  end

  def rename(new_name)
    self.name = new_name
  end

  def personal_greeting
    puts "Hello! My name is #{name}!"
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
kitty.personal_greeting
kitty.name = 'Luna'
kitty.personal_greeting

kitty.walk

Cat.generic_greeting
kitty.class.generic_greeting

puts kitty.name
kitty.rename('Chloe')
puts kitty.name

p kitty.identify

kitty2 = Cat.new('Olive')
p Cat.total

