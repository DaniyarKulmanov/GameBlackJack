require_relative 'player'

new_round = true
round_menu = 'Choose your action:', '1 - skip', '2 - add card',
             '3 - open cards', 'press enter to abort'

show_data = proc do |player, show_cards|
  puts "#{player.name}:"
  player.cards.each { |card| print card, ' ' } if show_cards
  player.cards.each { print Player::HIDDEN_CARD, ' ' } unless show_cards
  puts ''
  puts "Money:#{player.money}, Points: #{player.points}" if show_cards
  puts ''
end

dealer_turn = proc do |dealer|
  dealer.add_card if dealer.points < 12 && dealer.points < 19
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

# 1 init values, start game
loop do # new game
  puts 'Enter your name:'
  user = Player.new(gets.chomp)
  dealer = Player.new 'Dealer'
  puts user, dealer
  loop do # next round initialize round data -10$ + 2 cards for both
    break if user.money.zero? || dealer.money.zero?
    system('clear')
    user.prepare if new_round
    dealer.prepare if new_round
    show_data.call dealer, false # change to false
    show_data.call user, true
    puts round_menu
    command = gets.chomp
    case command
    when '1' # Dealer turn
      new_round = false
      dealer_turn.call dealer
    when '2'
      user.add_card if user.cards.size < 3
      new_round = false
    when '3'
      new_round = true
      result.call user, dealer
      next
    else
      new_round = true
      break
    end
    if user.cards.size == 3 && dealer.cards.size == 3
      result.call user, dealer
      new_round = true
      next
    end
  end
  puts 'Game Over' if user.money.zero?
  puts 'Congratulations!!! VICTORY!!' if user.money > 100
  puts '=====================', 'New game - press Enter', 'Exit game - enter 0'
  break if gets.chomp == '0'
end



