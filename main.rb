require_relative 'player'

new_round = true
round_menu = 'Choose your action:', '1 - skip', '2 - add card', '3 - open cards'

show_data = proc do |player, show_cards|
  puts "#{player.name}:"
  player.cards.each { |card| print card, ' ' } if show_cards
  player.cards.each { print Player::HIDDEN_CARD, ' ' } unless show_cards
  puts ''
  puts "Money:#{player.money}, Points: #{player.points}" if show_cards
  puts ''
end

dealer_turn = proc do |dealer|
  dealer.add_card if dealer.points < 10 && dealer.points < 19
end

# 1 init values, start game
loop do # new game
  puts 'Enter your name:'
  user = Player.new(gets.chomp)
  dealer = Player.new 'Dealer'
  puts user, dealer
  loop do # next round initialize round data -10$ + 2 cards for both
    system('clear')
    user.prepare if new_round
    dealer.prepare if new_round
    show_data.call dealer, true #change to false
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
      break if command == '3'
    else
      new_round = false
      next
    end
    # round end user.money = 0, user asked to open cards, user and dealer have 3 cards
  end
  puts 'Game Over' if user.money.zero?
  puts 'Congratulations!!! VICTORY!!' if user.money > 100
  puts '=====================', 'New game - press Enter', 'Exit game - enter 0'
  break if gets.chomp == '0'
end



