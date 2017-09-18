class Player
  attr_reader :name
  attr_accessor :money, :cards, :points

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    @points = 0
  end

  def add_card(card_info)
    @cards << card_info
    add_points card_info[:points], card_info[:alter_points]
  end

  def add_points(points, alter_points)
    sum = 0
    sum = @points + alter_points unless alter_points.nil?
    unless alter_points.nil?
      @points = sum if sum <= 21
      @points += points if sum > 21
    end
    @points += points if alter_points.nil?
    @points -= 10 if recalculate?
  end

  private

  def recalculate?
    @cards.size == 3 && !@cards[0][:alter_points].nil? && @points >= 21
  end
end
