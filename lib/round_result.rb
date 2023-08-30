# frozen_string_literal: false

# This class will be used to print the result of the round.
class RoundResult
  attr_reader :player, :winning_card
  attr_accessor :cards_on_table

  def initialize(player, winning_card, cards_on_table)
    @player = player
    @winning_card = winning_card
    @cards_on_table = cards_on_table
  end

  def cards_picked_up
    self.cards_on_table = cards_on_table - [winning_card]

    cards_on_table_string = ''

    cards_on_table.each do |card|
      cards_on_table_string << "#{card.rank} "
    end
    cards_on_table_string
  end

  def to_s
    "#{player.name} wins with #{winning_card.rank} and takes #{cards_picked_up}"
  end
end
