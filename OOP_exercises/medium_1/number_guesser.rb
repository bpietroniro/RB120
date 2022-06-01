class GuessingGame
  def initialize(range_start, range_end)
    @secret_number = nil
    @guesses_left = Math.log2(range_end - range_start).to_i + 1
    @range_start = range_start
    @range_end = range_end
  end

  def play
    @secret_number = rand(@range_start..@range_end)
    loop do
      guess = user_guess
      @guesses_left -= 1
      if correct?(guess)
        display_winning_message
        break
      else
        give_clues(guess)
      end
    end
  end

  def user_guess
    guess = nil
    puts "You have #{@guesses_left} guesses remaining."
    puts "Enter a number between #{@range_start} and #{@range_end}: "
    loop do
      guess = gets.chomp.to_i
      break if guess >= @range_start && guess <= @range_end
      puts "Invalid guess. Enter a number between #{@range_start} and #{@range_end}: "
    end
    guess
  end

  def correct?(guess)
    guess == @secret_number
  end

  def display_winning_message
    puts "That's the number!\n\nYou won!"
  end

  def give_clues(guess)
    if guess < @secret_number
      puts "Your guess is too low."
    else
      puts "Your guess is too high."
    end
  end
end

game = GuessingGame.new(501, 1500)
game.play
