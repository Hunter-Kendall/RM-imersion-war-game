require_relative '../lib/round_result'
require_relative '../lib/playing_card'
require_relative '../lib/war_player'

describe "RoundResult" do
  let (:winning_card) { PlayingCard.new("A", "S") }
  let(:player) { WarPlayer.new("Hunter") }
  let(:cards_on_table) { [winning_card, PlayingCard.new("3", "C"), PlayingCard.new("3", "S"), PlayingCard.new("2", "S")] }
  let(:round_result) { RoundResult.new(player, winning_card, cards_on_table) }
  
  context "#cards_picked_up" do
    
    it "excludes the winning card" do

      round_result.cards_picked_up

      winning_card_exist = round_result.cards_on_table.include?(winning_card)
      
      expect(winning_card_exist).to be false
    
    end

    it "returns a string of the card ranks " do

      cards_picked_up = "3 3 2 "

      expect(round_result.cards_picked_up).to eq(cards_picked_up)

    end
  end

  context "#to_s" do
    
    it "returns a formatted string" do
      message = "#{player.name} wins with #{winning_card.rank} and takes 3 3 2 "
      expect(round_result.to_s).to eq(message)
    end
    
  end
end