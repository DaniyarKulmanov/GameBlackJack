class Desk
  HIDDEN_CARD = "\u{1F0A0}".freeze
  NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'D', 'E'].freeze
  SUITS = %w[A B C D].freeze

  attr_accessor :desk

  def initialize
    @desk ||= []
    fill @desk
  end

  def fill(desk)
    SUITS.each do |suit|
      NUMBERS.each do |number|
        convert_suit suit, number
        card_point number
        desk << @suit_number
      end
    end
  end

  def random_card
    card = @desk[rand(0..@desk.size)]
    @desk.delete card
    card
  end

  private

  attr_writer :suit_number

  def convert_suit(suit, number)
    card_code = "1F0#{suit}#{number}"
    @suit_number = {}
    @suit_number[:card] = ''
    @suit_number[:card] << card_code.to_i(16)
  end

  def card_point(card_number)
    case card_number.to_i
    when (2..10)
      @suit_number[:points] = card_number
    when 0
      @suit_number[:points] = 10
    else
      @suit_number[:points] = 1
      @suit_number[:alter_points] = 11
    end
  end
end
