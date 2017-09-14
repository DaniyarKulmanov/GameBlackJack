require_relative 'player'

# 1 init values, start game
loop do
  puts 'Enter your name:'
  user = Player.new(gets.chomp)
  dealer = Player.new 'Dealer'
  # 2 initialize round data -10$ + 2 cards for both


  puts '1 - New game', '0 - Exit game'
  break if gets.chomp == '0'
  p user, dealer
end



