class Minilang
  COMMANDS = {
    'ADD' => :+,
    'SUB' => :-,
    'MULT' => :*,
    'DIV' => :/,
    'MOD' => :%
  }

  class MinilangError < StandardError; end
  class EmptyStackError < MinilangError; end
  class InvalidTokenError < MinilangError; end

  def initialize(command_string)
    @program = command_string.split
    @register = 0
    @stack = []
  end

  def eval
    @program.each do |token|
      case token
      when token.to_i.to_s then @register = token.to_i
      when 'PRINT' then puts @register
      when 'PUSH' then @stack << @register.to_i
      else
        begin
          process_command(token)
        rescue MinilangError => e
          puts e.message
          break
        end
      end
    end
  end

  private

  def process_command(token)
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    if token == 'POP'
      @register = @stack.pop
    else
      unless COMMANDS.include?(token)
        raise InvalidTokenError, "Invalid token: #{token}"
      end
      @register = @register.send(COMMANDS[token], @stack.pop)
    end
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
