require_relative 'player'
require_relative 'desk'

class Game
  COOL = "\u{1F60E}".freeze
  TROPHY = "\u{1F3C6}".freeze

  def initialize(player_name)
    @player = Player.new player_name
    @dealer = Player.new 'Дилер'
  end

  def start
    loop do
      new_round
      display_info @dealer, true
      display_info @player, false
      break
    end
  end

  def final_result
    puts "#{COOL} #{TROPHY} " * 10
    puts "#{@player.name} Поздравляем !! Вы победили!"
  end

  def new_round
    desk = Desk.new
    2.times do
      @player.add_card desk.random_card
      @dealer.add_card desk.random_card
    end
    @player.money -= 10
    @dealer.money -= 10
  end

  def display_info(user, hidden)
    puts "Карты #{user.name}:"
    user.cards.each { |card| print card, ' ' } unless hidden
    user.cards.each { print Desk::HIDDEN_CARD, ' ' } if hidden
    puts "\nДеньги: #{user.money}$, Очки:#{user.points}"
  end
end
