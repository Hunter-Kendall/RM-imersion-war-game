require_relative 'card_deck'
class WarPlayer
  attr_accessor :hand
  attr_reader :name
  def initialize(name)
    @name = name
    @hand = []
  end
  def draw(deck)
    hand << deck.deal
  end
  def hand_size
    hand.length()
  end
  def flip_card
    hand.pop
  end
  def takes_cards(played_cards)
    played_cards.each { |card| hand.unshift(card) }
  end
end
