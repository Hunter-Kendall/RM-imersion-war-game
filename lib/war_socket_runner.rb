# frozen_string_literal: true

require_relative 'war_socket_server'

server = WarSocketServer.new
server.start
loop do
  server.accept_client
  game = server.create_game_if_possible
  server.run_game(game) if game
rescue StandardError
  server.stop
end
