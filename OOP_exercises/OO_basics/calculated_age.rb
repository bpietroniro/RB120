class Person
  attr_writer :age

  def age=(age_in_years)
    @age = age_in_years * 2
  end

  def age
    @age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age
