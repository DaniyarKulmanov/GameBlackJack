require_relative 'player'
class User < Player
  attr_reader :name

  def initialize(name)
    @name = name
    money_init
  end
end
