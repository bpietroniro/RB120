class Cat
  CAT_COLOR = "purple"

  attr_reader :name, :color

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{CAT_COLOR} cat!"
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
puts kitty
