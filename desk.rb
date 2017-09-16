class Desk
  HIDDEN_CARD = "\u{1F0A0}".freeze

  attr_accessor :desk

  def initialize
    @desk ||= []
    fill @desk
  end

  def fill(desk)
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'D', 'E']
    suits = %w[A B C D]
    suits.each do |suit|
      numbers.each do |number|
        hexnum = "1F0#{suit}#{number}"
        suit_number = {}
        suit_number[:card] = ''
        suit_number[:card] << hexnum.to_i(16)
        case number.to_i
        when (2..10)
          suit_number[:points] = number
        when 0
          suit_number[:points] = 10
        else
          suit_number[:points] = 1
          suit_number[:alter_points] = 11
        end
        desk << suit_number
      end
    end
  end

  def random_card(desk)
    card = desk[rand(1..52)]
    desk.delete card
    self.points += 11 if card[:alter_points] && (self.points += 11) <= 21 # bug
    self.points += card[:points] unless card[:alter_points]
    card
  end
end
