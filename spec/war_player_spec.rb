require_relative '../lib/war_player'
require_relative '../lib/card_deck.rb'
require_relative '../lib/playing_card.rb'

describe 'WarPlayer' do
  name = 'Hunter'
  context "#draw"do
    
    it "can recieve cards" do
      deck = CardDeck.new
      player = WarPlayer.new(name)
      player.draw(deck)
      expect(player.hand_size).to eq(1)
    end
  end
  context "#flip_card" do
    it 'flips the correct card' do
      deck = CardDeck.new
      player = WarPlayer.new(name)
      player.draw(deck)
      flipped_card = player.flip_card
      expect(flipped_card.suit).to eq('C')
      expect(flipped_card.rank).to eq('A')
    end
  end
  context "#takes_cards" do
    it "adds all the cards from the played cards pile" do
      played_cards = [PlayingCard.new('A', 'S'), 
                      PlayingCard.new('K', 'S'), 
                      PlayingCard.new('Q', 'S'), 
                      PlayingCard.new('J', 'S')]
      player = WarPlayer.new(name)
      player.takes_cards(played_cards)
      expect(player.hand_size).to eq(4)
    end

    it "adds the cards in order" do
      bottom_card = PlayingCard.new('K', 'S')
      middle_card = PlayingCard.new('A', 'S')
      top_card =  PlayingCard.new('2', 'C')
      played_cards = [middle_card, bottom_card]
      
      player = WarPlayer.new(name)
      player.hand << top_card
      player.takes_cards(played_cards)
      expect(player.hand[2]).to eq(top_card)
      expect(player.hand[1]).to eq(middle_card)
      expect(player.hand[0]).to eq(bottom_card)
    end
  end
end
