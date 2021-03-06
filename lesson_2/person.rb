class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end

  private

  # allows for middle names, patronyms, etc.
  def parse_full_name(full_name)
    name_parts = full_name.split
    self.first_name = name_parts.size > 1 ? name_parts[...-1].join(' ') : name_parts.first 
    self.last_name = name_parts.size > 1 ? name_parts.last : ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

bob.name = "John Luther Adams"
p bob.first_name
p bob.last_name
p bob.name

puts bob
