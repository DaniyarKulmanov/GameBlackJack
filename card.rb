module Cards
  HIDDEN_CARD = "\u{1F0A0}"
  attr_accessor :cards

  def add_card
    @cards ||= []
    @cards << random_card
  end

  def random_card
    x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'B', 'D'].shuffle.join[0]
    y = %w[A B C D].shuffle.join[0]
    hexnum = "1F0#{y}#{x}"
    card = ''
    card << hexnum.to_i(16)
  end
end