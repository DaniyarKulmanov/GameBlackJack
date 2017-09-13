require_relative 'game'


puts 'Enter your name:'
name = gets.chomp

game = Game.new(name)

