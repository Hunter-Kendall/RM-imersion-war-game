require_relative 'war_game'
require_relative 'war_player'
player1 = WarPlayer.new("Hunter")
player2 = WarPlayer.new("Kevin")
game = WarGame.new(player1, player2)
game.start
until game.winner do
  puts game.play_round
end
puts "Winner: #{game.winner.name}"
