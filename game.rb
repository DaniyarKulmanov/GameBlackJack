require_relative 'player'
require_relative 'desk'

class Game

  def initialize(player_name)
    @player = Player.new player_name
    @dealer = Player.new 'Dealer'
  end

  def start
    loop do # new round
      puts 'game'
      break
    end
  end

  def final_result
    puts 'You WIN!'
  end
end