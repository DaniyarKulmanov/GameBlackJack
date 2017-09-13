require_relative 'card'

class Player
  include Cards
  attr_reader :money, :name

  def initialize(name)
    @name = name
    @money = 100
    2.times { add_card }
  end
end
