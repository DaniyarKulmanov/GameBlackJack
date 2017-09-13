module Cards
  HIDDEN_CARD = "\u{1F0A0}".freeze
  attr_accessor :cards, :points, :alter_points

  def add_card
    @cards ||= []
    @points ||= 0
    @alter_points ||= 0
    @cards << random_card
  end

  def random_card
    number = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'B', 'D'].shuffle.join[0]
    add_points number.to_i
    suit = %w[A B C D].shuffle.join[0]
    hexnum = "1F0#{suit}#{number}"
    card = ''
    card << hexnum.to_i(16)
  end

  def add_points(number)
    case number
    when (2..10)
      @points += number
      @alter_points += number
    when 0
      @points += 10
      @alter_points += 10
    else
      @points += 1
      @alter_points += 11
    end
  end
end