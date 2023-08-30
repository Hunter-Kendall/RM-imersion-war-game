# frozen_string_literal: true

require 'socket'
require_relative 'war_game'
require_relative 'war_player'

# This class is the war socket server.
class WarSocketServer
  attr_accessor :player_queue, :games

  def initialize(player_queue = [], games = [])
    @player_queue = player_queue
    @games = games
  end

  def port_number
    3336
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(player_name = 'Random Player')
    @server.accept_nonblock
    player_queue.push(WarPlayer.new(player_name))
  rescue IO::WaitReadable, Errno::EINTR
    puts 'No client to accept'
  end

  def create_game_if_possible
    create_game if player_queue.length > 1
  end

  def create_game
    games.push(WarGame.new(player_queue[0], player_queue[1]))
  end

  def stop
    @server&.close
  end
end
