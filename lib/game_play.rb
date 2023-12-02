require './lib/save_game'
class GamePlay

  def initialize
    @word=""
    @word_length = @word.length
    @number_of_turns = 12
    @guessed_word=[]
    @correct_guess=[]
    @word_copy = ""
    select_random_word
    start_game
  end

  private

  # This function selects any random word between length 5 to 12 from the words.txt file  
  def select_random_word
    while !(@word_length>5 && @word_length<12)
      random_number = rand(10001)
      @word = File.readlines('words.txt')[random_number].downcase.strip!
      @word_length=@word.length
      puts @word
    end
    @correct_guess.push(*["-"]*@word_length)
    @word_copy=@word.clone
  end

  # This function display all guesses you have made
  def display_guesses
    unless @guessed_word.empty?
      puts "You have guessed these words: #{@guessed_word.join(", ")}"
    end
  end

  # This checks the position of your guessed word and filled it into your answer acording to letter position
  def filing_the_answer(current_gussed_word)
    current_gussed_word_index = (0 ... @word_length).find_all { |i| @word[i,1] == current_gussed_word}
    current_gussed_word_index.each { |index| @correct_guess[index] = current_gussed_word } 
  end

  # This removes the letter from the word that you have correctly guessed
  def updating_word(current_gussed_word)
    @word.gsub!(current_gussed_word,' ')
    @word_length = @word.length
  end

  # This game logic handles the logic of the game based on, if your input is correct or not
  def game_logic(current_gussed_word)
    if @word.include?(current_gussed_word)
      puts "Correct Guess"
      filing_the_answer(current_gussed_word)
      @guessed_word.push(current_gussed_word)
      updating_word(current_gussed_word)
    elsif @guessed_word.include?(current_gussed_word)  
      puts "You have already guessed this word, guees new word, please"
    else 
      puts "Wrong Guess"
      @guessed_word.push(current_gussed_word)
    end
  end

  # This checks if your input is valid or not
  def validate_input(input)
    until input.length==1 && ('a'..'z').include?(input)
      puts "Invalid Input"
      puts "guess any letter"
      input = gets.chomp.downcase
    end
    input
  end

  def check_for_game_save(input)
    if input=='save'
      save = Save.new(self)
      exit 1
    end
  end

  # this starts the game
  def start_game
    puts "Hello, Welcome to the Game"
    puts @correct_guess.join(' ')

    while @number_of_turns>0 
      break unless @correct_guess.include?('-')

      puts "guess any letter"
      current_gussed_word = gets.chomp.downcase
      check_for_game_save(current_gussed_word)
      current_gussed_word = validate_input(current_gussed_word)
      game_logic(current_gussed_word)
      display_guesses
      puts @correct_guess.join(' ')
      @number_of_turns-=1
      puts "number of turns left #{@number_of_turns}"
      end
    game_over
  end

  # this shows the gameover message
  def game_over
    if !@correct_guess.include?("-")
      puts("You Won")
      puts("Congratulations, you correctly guessed the word")
    else
      puts("You Lose")
      puts("The Answer is #{@word_copy}")
    end
  end

end

# game = GamePlay.new
