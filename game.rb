require_relative 'player'
require_relative 'desk'

class Game
  COOL = "\u{1F60E}".freeze
  TROPHY = "\u{1F3C6}".freeze
  LOOSE = "\u{1F61B}".freeze
  CHOOSE_ACTION = 'Введите номер действия, затем нажмите Enter:'.freeze
  SKIP = '1 - Пропустить ход'.freeze
  ADD_CARD = '2 - Добавить карту'.freeze
  OPEN = '3 - Раскрыть карты'.freeze


  attr_accessor :skip_turn, :add_card, :exit, :desk

  def initialize(player_name)
    @player = Player.new player_name
    @dealer = Player.new 'Дилер'
  end

  def start
    loop do
      new_round
      choose_action
      break if @exit
    end
  end

  def final_result
    player = @player.money
    dealer = @dealer.money
    puts "#{COOL} #{TROPHY} " * 10 if dealer.zero?
    puts "#{LOOSE} #{TROPHY} " * 10 if player.zero?
    puts "#{@player.name.upcase} Поздравляем !! Вы победили!" if dealer.zero?
    puts "#{@player.name} Вы проиграли!" if player.zero?
    puts "#{COOL} #{TROPHY} " * 10 if dealer.zero?
    puts "#{LOOSE} #{TROPHY} " * 10 if player.zero?
  end

  def new_round
    round_initialize
    2.times do
      @player.add_card @desk.random_card
      @dealer.add_card @desk.random_card
    end
    @player.money -= 10
    @dealer.money -= 10
    @skip_turn = false
    @add_card = false
  end

  def display_info(user, hidden)
    puts "Карты #{user.name}:"
    user.cards.each { |card_info| print card_info[:card], ' ' } unless hidden
    user.cards.each { print Desk::HIDDEN_CARD, ' ' } if hidden
    puts "\nДеньги: #{user.money}$, Очки:#{user.points}" unless hidden
    puts '' if hidden
  end

  def choose_action
    loop do
      if @player.cards.size == 3 && @dealer.cards.size == 3
        open_cards
        break
      end
      system('clear')
      show_menu
      command = gets.chomp
      execute command
      if @player.money.zero? || @dealer.money.zero?
        check_points
        @exit = true
      end
      @exit = true if command == '4'
      break if @exit || command == '3'
    end
  end

  def show_menu
    display_info @dealer, true
    display_info @player, false
    puts '' * 2, CHOOSE_ACTION
    puts SKIP unless @skip_turn
    puts ADD_CARD unless @add_card
    puts OPEN
    puts '4 - Выйти из игры'
  end

  def execute(command)
    case command
    when '1'
      @skip_turn = true
      dealer_move
    when '2'
      @add_card = true
      @player.add_card @desk.random_card if @player.cards.size < 3
    when '3'
      open_cards
    end
  end

  def dealer_move
    if @dealer.points < 12
      @dealer.add_card @desk.random_card
    end
  end

  def open_cards
    system('clear')
    puts 'Результаты:'
    check_points
    display_info @dealer, false
    display_info @player, false
    puts ' ', 'Нажмите Enter'
    gets
  end

  def round_initialize
    @desk = Desk.new
    @player.cards = []
    @dealer.cards = []
    @player.points = 0
    @dealer.points = 0
  end

  def check_points
    case @player.points
    when (1..21)
      if @player.points > @dealer.points || @dealer.points > 21
        puts 'Вы победили 20$ уходит на Ваш счёт'
        @player.money += 20
      elsif @player.points == @dealer.points
        puts 'Ничья, ставка возвращена.'
        @player.money += 10
        @dealer.money += 10
      elsif @player.points < @dealer.points && @dealer.points <= 21
        puts 'Раунд проигран 20$ уходит Дилеру'
        @dealer.money += 20
      end
    else
      if @dealer.points <= 21
        puts 'Раунд проигран 20$ уходит Дилеру'
        @dealer.money += 20
      else
        puts 'Ничья, ставка возвращена.'
        @player.money += 10
        @dealer.money += 10
      end
    end
  end
end
