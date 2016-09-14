require './bowling.rb'
require './helper/helper.rb'

if __FILE__ == $0
  bowling = Bowling.new
  helper = Helper.new
  puts '======= Welcome to Terminal Bowling Game!! ======='
  puts 'Please enter pins know in each frames: (type \'quit\' to stop)'

  @input = gets.chomp
  while(@input != 'quit')
    @input = helper.format_input(@input)

    unless @input.nil?
      bowling.display_score if bowling.frames_attr_writer(@input)
    end

    puts 'Please enter scores in each frame: (type \'quit\' to stop)'
    @input = gets.chomp
  end
  puts '======= Thank you for playing!! ======='
end
