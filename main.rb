require_relative 'game'

loop do
  puts 'Введите Ваше имя:'
  name = gets.chomp
  puts 'Игра: имя не должно быть пустым' if name.strip.empty?
  next if name.strip.empty?
  system('clear')
  game = Game.new(name)
  game.start
  command = nil
  loop do
    game.final_result
    puts "#{name}: введите N или Q" unless (%w[N Q].include? command) || command.nil?
    puts 'N - Новая игра', 'Q - Выйти'
    command = gets.chomp.upcase
    break if %w[N Q].include?(command)
  end
  break if command == 'Q'
end
