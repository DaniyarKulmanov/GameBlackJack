require_relative 'player'

# 1 init values, start game
loop do # new game
  puts 'Enter your name:'
  user = Player.new(gets.chomp)
  dealer = Player.new 'Dealer'
  loop do # next round initialize round data -10$ + 2 cards for both
    user.prepare
    dealer.prepare
    p user, dealer


    # round end if
    # user.money = 0, user asked to open cards, user and dealer have 3 cards
    break
  end
  puts '1 - New game', '0 - Exit game'
  break if gets.chomp == '0'
end



