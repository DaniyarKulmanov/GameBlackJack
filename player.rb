require_relative 'desk'
class Player
  attr_reader :name
  attr_accessor :money, :cards, :points, :alter_points

  def initialize(name)
    @name = name
    @money = 100
  end

  def prepare(desk)
    @money -= 10
    @cards = []
    @points = 0
    2.times { add_card desk }
  end

  def add_card(desk)
    @cards ||= []
    @points ||= 0
    @alter_points ||= 0
    @cards << random_card(desk)
  end
end
