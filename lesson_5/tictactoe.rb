require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    markers.size == 3 && markers.uniq.size == 1
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  WINNING_SCORE = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = nil
  end

  def play
    clear_screen
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      game_setup
      main_play
      if grand_winner?
        display_grand_winner
        break
      end
      break unless play_again?
      reset
    end
  end

  def game_setup
    set_who_goes_first
    display_board
  end

  def main_play
    players_move
    display_result_and_update_scores
  end

  def set_who_goes_first
    choice = nil
    loop do
      puts "Who moves first? (Enter 'h' for human or 'c' for computer)"
      choice = gets.chomp.downcase
      break if choice == 'h' || choice == 'c'
      puts "Enter a valid choice: "
    end

    update_first_marker(choice)
  end

  def update_first_marker(choice)
    @current_marker = case choice
                      when 'h' then HUMAN_MARKER
                      else COMPUTER_MARKER
                      end
  end

  def grand_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def display_grand_winner
    grand_winner = human.score == WINNING_SCORE ? "Human" : "Computer"
    puts "#{grand_winner} is the grand winner with #{WINNING_SCORE} points!"
  end

  def display_scores
    puts "Human: #{human.score}"
    puts "Computer: #{computer.score}"
  end

  def players_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're #{HUMAN_MARKER}. Computer is #{COMPUTER_MARKER}."
    puts
    board.draw
    puts
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def human_moves
    puts "Choose an empty square from #{board.unmarked_keys.join(', ')}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice. Try again: "
    end

    board[square] = human.marker
    # another possibility: @human.mark(square)
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result_and_update_scores
    clear_screen_and_display_board
    update_scores
    display_scores
  end

  def update_scores
    case board.winning_marker
    when HUMAN_MARKER
      puts "You won!"
      human.score += 1
    when COMPUTER_MARKER
      puts "Computer won!"
      computer.score += 1
    else puts "The board is full!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def current_player_moves
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def reset
    board.reset
    clear_screen
    @current_marker = @first_to_move
    display_play_again_message
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
  end

  def clear_screen
    system 'clear'
  end
end

game = TTTGame.new
game.play
