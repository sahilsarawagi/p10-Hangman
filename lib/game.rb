require './lib/game_play'
class Game
  def initialize
    intial_screen
  end

  def intial_screen
    puts "--------------HANGMAN--------------
    Choose any of the following
    1) Start a new game
    2) Load game "
    input = gets.chomp
    input = validate_input(input)
    input_response(input)
  
  end

  def validate_input(input)
    until input=='1' || input=='2'
      puts "Invalid input"
      puts "Please choose 1 for new game and 2 for Load game"
      input = gets.chomp
    end
    input
  end

  def input_response(input)
    if input=='1'
      new_game = GamePlay.new
    # else
      # Has to complete this
      # load_game = 
    end

  end



end

game = Game.new
