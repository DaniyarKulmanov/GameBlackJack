require_relative 'player'

new_round = true
round_menu = 'Choose your action:',
             '1 - skip',
             '2 - add card',
             '3 - open cards',
             '0 - exit'
desk = []
show_data = proc do |player, show_cards|
  puts "#{player.name}:"
  player.cards.each { |card| print card, ' ' } if show_cards
  player.cards.each { print Player::HIDDEN_CARD, ' ' } unless show_cards
  puts ''
  puts "Money:#{player.money}, Points: #{player.points}" if show_cards
  puts ''
end

dealer_turn = proc do |dealer|
  dealer.add_card desk if dealer.points < 12
end

result = proc do |user, dealer|
  system('clear')
  show_data.call dealer, true
  show_data.call user, true
  case user.points
  when (1..21)
    if user.points > dealer.points || dealer.points > 21
      puts 'Round won +10$ credit'
      user.money += 20
    elsif user.points == dealer.points
      puts 'draw'
      user.money += 10
      dealer.money += 10
    elsif user.points < dealer.points && dealer.points <= 21
      puts 'Round lost -10$ credit'
      dealer.money += 20
    end
  else
    if dealer.points <= 21
      puts 'Round lost -10$ credit'
      dealer.money += 20
    else
      puts 'draw'
      user.money += 10
      dealer.money += 10
    end
  end
  puts 'press enter'
  gets
end

start_game = proc do
  Desk.fill desk
  puts 'Enter your name:'
  [Player.new(gets.chomp), Player.new('Dealer')]
end

start_round = proc do |user, dealer|
  break if user.money.zero? || dealer.money.zero?
  Desk.fill desk
  system('clear')
  user.prepare desk if new_round
  dealer.prepare desk if new_round
  show_data.call dealer, false
  show_data.call user, true
end

process_round = proc do |user, dealer|
  loop do
    puts 'New round' if new_round
    start_round.call user, dealer
    puts round_menu
    command = gets.chomp
    case command
    when '1'
      new_round = false
      dealer_turn.call dealer
    when '2'
      user.add_card desk if user.cards.size < 3
      new_round = false
    when '3'
      new_round = true
      result.call user, dealer
      next
    when '0'
      new_round = true
      break
    else
      new_round = false
      next
    end
    if user.cards.size == 3 && dealer.cards.size == 3
      result.call user, dealer
      new_round = true
      next
    end
  end
end

loop do
  player = start_game.call
  process_round.call player[0], player[1]
  puts 'Game Over' if player[0].money.zero?
  puts 'Congratulations!!! VICTORY!!' if player[0].money > 100
  puts '========Game end==========',
       'New game - press Enter',
       '0 - exit game'
  break if gets.chomp == '0'
end
