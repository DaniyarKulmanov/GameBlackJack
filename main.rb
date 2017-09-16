require_relative 'player'
require_relative 'desk'
require_relative 'game'

loop do
  # system('clear')
  puts 'Введите Ваше имя:'
  name = gets.chomp
  puts 'Игра: имя не должно быть пустым' if name.strip.empty?
  next if name.strip.empty?
  game = Game.new(name)
  game.start
  command = nil
  loop do
    # system('clear')
    game.final_result
    puts "#{name}: введите N или Q" unless (%w[N Q].include? command) || command.nil?
    puts 'N - Новая игра', 'Q - Выйти'
    command = gets.chomp.upcase
    break if %w[N Q].include?(command)
  end
  break if command == 'Q'
end
