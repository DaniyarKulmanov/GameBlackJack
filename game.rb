require_relative 'player'
class Game
  attr_accessor :user, :dealer, :finish_turn

  def initialize(name)
    @user = Player.new name
    @dealer = Player.new 'Dealer'
    @round = 0
    @bank = 0
    @finish_turn = false
  end

  def round
    @user.cards = []
    2.times { @user.add_card }
    @dealer.cards = []
    2.times { @dealer.add_card }
    @bank += 20
    @user.money -= 10
    @dealer.money -= 10
    @round += 1
  end

  def dealer_turn; end
end

