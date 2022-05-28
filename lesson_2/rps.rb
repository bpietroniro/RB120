class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  HIERARCHIES = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['spock', 'paper'],
    'spock' => ['rock', 'scissors']
  }

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def <(other_move)
    HIERARCHIES[other_move.value].include?(value)
  end

  def >(other_move)
    HIERARCHIES[value].include?(other_move.value)
  end

  protected

  attr_reader :value
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, you must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice. Try again:"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_scores
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
  end

  def update_score(player)
    puts "#{player.name} won!"
    player.score += 1
  end

  def display_winner
    if human.move > computer.move
      update_score(human)
    elsif human.move < computer.move
      update_score(computer)
    else
      puts "It's a tie!"
    end
    display_scores
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def grand_winner?
    human.score == 10 || computer.score == 10
  end

  def display_grand_winner
    winner = (human.score == 10 ? human.name : computer.name)
    puts "#{winner} wins the whole round!"
  end

  def make_moves
    human.choose
    computer.choose
    display_moves
    display_winner
  end

  def play
    display_welcome_message
    loop do
      make_moves
      if grand_winner?
        display_grand_winner
        break
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
