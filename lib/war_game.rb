# frozen_string_literal: true

require_relative 'playing_card'
require_relative 'card_deck'
require_relative 'round_result'

# This class controlls the card game war
class WarGame
  class NotShuffled < StandardError; end

  attr_accessor :player1, :player2, :deck, :winner
  attr_reader :played_cards

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @deck = CardDeck.new
    @played_cards = []
    @winner = false
  end

  def deal_cards
    while deck.cards_left.positive?
      player1.draw(deck)
      player2.draw(deck)
    end
  end

  def check_for_winner!
    if player2.hand_size.zero?
      self.winner = player1
    elsif player1.hand_size.zero?
      self.winner = player2
    end
  end

  def player_takes_cards(player)
    player.takes_cards(played_cards)
    played_cards.clear
  end

  def compare_cards(card1, card2, cards_on_table)
    if card2.nil? || (!card1.nil? && (card1.rank_rating > card2.rank_rating))

      puts RoundResult.new(player1, card1, cards_on_table)
    elsif card1.nil? || card2.rank_rating > card1.rank_rating

      puts RoundResult.new(player2, card2, cards_on_table)
    else
      play_round(cards_on_table)
    end
  end

  def play_round(cards_on_table = [])
    card1 = player1.flip_card
    card2 = player2.flip_card
    cards_on_table.push(card1, card2).compact!

    raise NotShuffled if card1.nil? && card2.nil?

    compare_cards(card1, card2, cards_on_table)
    check_for_winner!
    nil
  end

  def start
    deck.shuffle_cards
    deal_cards
  end
end
