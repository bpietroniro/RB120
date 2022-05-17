class Person
  def name=(first_and_last)
    names = first_and_last.split
    @first_name = names.first
    @last_name = names.last
  end

  def name
    "#{@first_name} #{@last_name}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
