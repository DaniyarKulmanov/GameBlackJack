class Player
  attr_reader :name, :cards, :points
  attr_accessor :money

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    @points = 0
  end

  def add_card(card_info)
    @cards << card_info[:card]
    add_points card_info[:points], card_info[:alter_points]
  end

  def add_points(points, alter_points)
    sum = 0
    sum = @points + alter_points unless alter_points.nil?
    @points = sum if sum <= 21 && !alter_points.nil?
    @points += points if alter_points.nil? || sum > 21
  end
end
