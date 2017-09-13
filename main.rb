require_relative 'game'


puts 'Enter your name:'
name = gets.chomp

game = Game.new(name)

system('clear')
puts "#{name} welcome to BlackJack game! Collect 21 points to win"
puts "#{game.dealer.name}'s cards:"
puts "#{Player::HIDDEN_CARD} #{Player::HIDDEN_CARD}"

puts 'Your cards:'
game.user.cards.each { |card| print card, ' ' }
puts ''
puts "Cash:#{game.user.money}$"
puts "Points:#{game.user.points}"
puts '============================================================'
puts 'Make turn:',
     '0 - End game',
     '1 - Pass turn',
     '2 - Add card',
     '3 - Open cards'