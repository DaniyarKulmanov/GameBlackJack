class Player
  attr_reader :name
  attr_accessor :money

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    @points = 0
  end

  def add_card(card_info)
    @cards << card_info[:card]
    @points = card_info[:points] unless card_info[:alter_points]
  end
end
