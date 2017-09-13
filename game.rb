require_relative 'player'
class Game
  attr_reader :round
  attr_accessor :user, :dealer

  def initialize(name)
    @user = Player.new name
    @dealer = Player.new 'Dealer'
    @round = 1
    @bank = 0
  end

  def new_round
    @bank += 20
    @user.money -= 10
    @dealer.money -= 10
  end
end