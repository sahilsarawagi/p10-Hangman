# This will open up the word text file and selects the random word to guess

class GamePlay
  def initialize
    @word=""
    @word_length = @word.length
    @number_of_turns = 12
    @guessed_word=[]
    @correct_guess=[]
    select_random_word
    start_game
  end
  def select_random_word
    while !(@word_length>5 && @word_length<12)
      random_number = rand(10001)
      @word = File.readlines('words.txt')[random_number].downcase.strip!
      @word_length=@word.length
      puts @word
    end
    @correct_guess.push(*["-"]*@word_length)
  end

  def display_wrong_guess
    puts "you have guessed these words: #{@guessed_word.join(", ")}"
  end

  def updating_answer(gussed_word_index,character)
    for index in gussed_word_index
      @correct_guess[index] = character
    end
    
  end
  def start_game
    puts "Hello, Welcome to the Game"
    puts @correct_guess.join(' ')
    while @number_of_turns>0 
      if !@correct_guess.include?("-")
        break
      end
      puts "guess any letter"
      current_gussed_word = gets.chomp.downcase
      if @word.include?(current_gussed_word)
        puts "Correct Guess"
        current_gussed_word_index = (0 ... @word_length).find_all { |i| @word[i,1] == current_gussed_word}
        updating_answer(current_gussed_word_index,current_gussed_word)
        @guessed_word.push(current_gussed_word);
        @word.gsub!(current_gussed_word," ")
        @word_length = @word.length
      elsif @guessed_word.include?(current_gussed_word)  
        puts "You have already guessed this word, guees new word, please"
      else 
        puts "Wrong Guess"
        @guessed_word.push(current_gussed_word)
      end
      display_wrong_guess
      puts @correct_guess.join(' ')
      @number_of_turns-=1
      puts "number of turns left #{@number_of_turns}"
    end
  end
  # has to add game_over function
  
  #Make it more readable
end

game = GamePlay.new
