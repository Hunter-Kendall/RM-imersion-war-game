# frozen_string_literal: true

require_relative '../lib/war_game'
require_relative '../lib/war_player'
require_relative '../lib/playing_card'
require_relative '../lib/card_deck'

describe 'WarGame' do
  let(:deck) { CardDeck.new }
  let(:player1) { WarPlayer.new('Hunter') }
  let(:player2) { WarPlayer.new('bot') }
  let(:game) { WarGame.new(player1, player2) }

  context '#deal' do
    it 'it gives each player 26 cards in alternating order' do
      game.deal_cards
      expect(player1.hand_size).to eq(26)
      expect(player2.hand_size).to eq(26)
    end
  end

  context '#play_round' do
    it 'compares and expects player 1 to be the winner and gives cards' do
      player2.hand += [PlayingCard.new('K', 'C'), PlayingCard.new('K', 'H')]
      player1.hand += [PlayingCard.new('A', 'S'), PlayingCard.new('A', 'H')]
      game.play_round
      expect(player2.hand_size).to eq(1)
      expect(player1.hand_size).to eq(3)
      expect(game.played_cards.length).to eq(0)
    end
    it 'compares and expects player 2 to be the winner and gives cards' do
      player2.hand += [PlayingCard.new('A', 'S'), PlayingCard.new('A', 'H')]
      player1.hand += [PlayingCard.new('K', 'C'), PlayingCard.new('K', 'H')]
      game.play_round

      expect(player2.hand_size).to eq(3)
      expect(player1.hand_size).to eq(1)
      expect(game.played_cards.length).to eq(0)
    end

    it 'if round is tie' do
      player1.hand = [PlayingCard.new('3', 'C'), PlayingCard.new('K', 'D'), PlayingCard.new('A', 'C')]
      player2.hand = [PlayingCard.new('2', 'S'), PlayingCard.new('A', 'H'), PlayingCard.new('A', 'S')]
      game.play_round
      expect(player1.hand_size).to eq(1)
      expect(player2.hand_size).to eq(5)
    end

    it 'tie where player2 runs out of cards' do
      player1.hand = [PlayingCard.new('3', 'C'), PlayingCard.new('K', 'D'), PlayingCard.new('A', 'C')]
      player2.hand = [PlayingCard.new('A', 'S')]
      game.play_round
      expect(player1.hand_size).to eq(4)
      expect(player2.hand_size).to eq(0)
      expect(game.winner).to eq(player1)
    end

    it 'tie where player1 runs out of cards' do
      player1.hand = [PlayingCard.new('A', 'S')]
      player2.hand = [PlayingCard.new('3', 'C'), PlayingCard.new('K', 'D'), PlayingCard.new('A', 'C')]
      game.play_round
      expect(player1.hand_size).to eq(0)
      expect(player2.hand_size).to eq(4)
      expect(game.winner).to eq(player2)
    end

    it 'when both players run out of cards' do
      player1.hand = [PlayingCard.new('A', 'S')]
      player2.hand = [PlayingCard.new('A', 'C')]
      expect { game.play_round }.to raise_error(WarGame::NotShuffled)
      expect(player1.hand_size).to eq(0)
      expect(player2.hand_size).to eq(0)
    end

    it 'expects it to return player 1 as game winner' do
      player1.hand << PlayingCard.new('A', 'S')
      player2.hand << PlayingCard.new('K', 'C')
      game.play_round
      expect(game.winner).to eq(player1)
    end
    it 'expects it to return player 2 as game winner' do
      player2.hand << PlayingCard.new('A', 'S')
      player1.hand << PlayingCard.new('K', 'C')
      game.play_round
      expect(game.winner).to eq(player2)
    end
  end
end
