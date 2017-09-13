require_relative 'user'
require_relative 'dialer'
# ask name
puts 'Enter your name:'
name = gets.chomp

# initialize user and ai
user = User.new(name)
ai = Dialer.new

puts "#{user.name} welcome to BlackJack game!"
puts '----------Game Begins GOOD LUCK!!----------'

puts 'Dialer:', Cards::HIDDEN_CARD, Cards::HIDDEN_CARD, "Money = #{ai.money}$"
puts '---------Player----------'
puts 'Your Cards:', user.cards, "Money = #{user.money}$"

puts 'Choose your move:', '1 - pass move', '2 - add card', '3 - open cards'
# move = gets.chomp
# 100$ user and 100$ dialer = 200$ bank
# 2 random cards user 2 random cards dialer
# -10$ user and -10 $dialer = 20$ bank