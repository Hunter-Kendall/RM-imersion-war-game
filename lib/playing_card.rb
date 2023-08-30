class PlayingCard
  attr_reader :suit, :rank, :rank_ratings
  RANKS = %w'2 3 4 5 6 7 8 9 10 J Q K A' 
  SUITS = %w'D H S C' 

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def ==(other)
    other.respond_to?(:rank) && other.respond_to?(:suit) &&
      rank == other.rank && suit == other.suit
  end

  def rank_rating
    RANKS.find_index(rank)
  end

end
