class Card
  include Comparable
  attr_reader :rank, :suit

  RANK_VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  SUIT_VALUES = { 'Diamonds' => 1, 'Clubs' => 2, 'Hearts' => 3, 'Spades' => 4 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def rank_value
    RANK_VALUES.fetch(rank, rank)
  end

  def suit_value
    SUIT_VALUES.fetch(suit, suit)
  end

  def <=>(other_card)
    if rank_value == other_card.rank_value
      suit_value <=> other_card.suit_value
    else
      rank_value <=> other_card.rank_value
    end
  end
end

card1 = Card.new(4, 'Spades')
card2 = Card.new(4, 'Hearts')
card3 = Card.new(4, 'Clubs')
card4 = Card.new(4, 'Diamonds')
card5 = Card.new(5, 'Diamonds')

puts card1 > card2
puts card2 > card3
puts card3 > card4
puts card5 > card1
