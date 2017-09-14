require_relative 'player'

show_data = proc do |player, show_cards|
  puts "#{player.name}:"
  player.cards.each { |card| print card, ' ' } if show_cards
  player.cards.each { print Player::HIDDEN_CARD, ' ' } unless show_cards
  puts ''
  puts "Money:#{player.money}, Points: #{player.points}"
  puts ''
end

# 1 init values, start game
loop do # new game
  puts 'Enter your name:'
  user = Player.new(gets.chomp)
  dealer = Player.new 'Dealer'
  loop do # next round initialize round data -10$ + 2 cards for both
    user.prepare # if new round
    dealer.prepare # if new round
    show_data.call dealer, false #show data
    show_data.call user, true

    # round end user.money = 0, user asked to open cards, user and dealer have 3 cards
    break
  end
  puts '1 - New game', '0 - Exit game'
  break if gets.chomp == '0'
end



