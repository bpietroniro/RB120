require 'pry-byebug'

module Hand
  attr_reader :hand

  def add_cards(new_cards)
    hand << new_cards
    hand.flatten!
  end

  def total
    aces, non_aces = hand.partition { |card| card.face == 'A' }
    total_score = non_aces.reduce(0) { |sum, card| sum + card.value }

    total_score += 11 * aces.size
    count = aces.size
    while (count > 0) && (total_score > 21)
      total_score -= 10
      count -= 1
    end

    total_score
  end

  def busted?
    total > 21
  end
end

class Player
  include Hand

  def initialize
    @hand = []
  end

  def display_cards
    hand.each { |card| puts card }
  end
end

class Dealer
  include Hand

  def initialize
    @hand = []
  end
end

class Deck
  SUITS = %w(S D C H)
  VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_reader :cards_remaining

  def initialize
    @cards_remaining = all_cards.shuffle
  end

  def all_cards
    deck = []
    combos = SUITS.product(VALUES)
    combos.each do |suit, value|
      deck << Card.new(value, suit)
    end

    deck
  end

  def deal(num_cards)
    cards_remaining.pop(num_cards)
  end
end

class Card
  attr_reader :face, :value, :suit

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = determine_value
  end

  def determine_value
    case face
    when ('2'..'9') then face.to_i
    when '10', 'J', 'Q', 'K', 'A' then 10
    end
  end

  def to_s
    "#{face} of #{suit}"
  end
end

class Game
  attr_reader :player, :dealer, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    loop do
      setup

      player_turn
      if player.busted?
        play_again? ? (reset; next) : break
      end

      dealer_turn
      if dealer.busted?
        play_again? ? (reset; next) : break
      end

      show_result
      break unless play_again?
      reset
    end
  end

  def setup
    deal_cards
    show_initial_cards
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if answer.start_with?('y', 'n')
      puts "Please enter 'y' or 'n'"
    end
    answer.start_with?('y')
  end

  def reset
    initialize
  end

  def deal_cards
    player.add_cards(deck.deal(2))
    dealer.add_cards(deck.deal(2))
  end

  def show_initial_cards
    puts "Your cards: "
    player.display_cards
    puts "Dealer's first card: #{dealer.hand.first}"
  end

  def player_turn
    loop do
      choice = player_makes_choice
      case choice
      when 's' then break
      else
        player.add_cards(deck.deal(1))
        puts "Your hand: "
        player.display_cards
      end

      if player.busted?
        puts "Busted!!! Dealer wins."
        break
      end
    end
  end

  def player_makes_choice
    choice = nil
    loop do
      puts "Hit or stay? (Type 'h' to hit, 's' to stay)"
      choice = gets.chomp.downcase
      break if ['h', 's'].include?(choice)
      puts "Oops! Invalid choice. Please enter either 'h' or 's'."
    end
    choice
  end

  def dealer_turn
    until dealer.total >= 17
      dealer.add_cards(deck.deal(1))
    end
    if dealer.busted?
      puts "Dealer busts! You win!"
    end
  end

  def show_result
    puts "Your score: #{player.total}"
    puts "Dealer's score: #{dealer.total}"
    winning_message = case winner
                      when dealer then "Dealer wins!"
                      when player then "You win!"
                      else "It's a tie!"
                      end
    puts winning_message
  end

  def winner
    case
    when dealer.total > player.total then dealer
    when player.total > dealer.total then player
    else nil
    end
  end
end

Game.new.start
