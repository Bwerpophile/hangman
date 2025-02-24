require_relative 'player'
require_relative 'dictionnary'
require_relative 'guess'

class Game
  def initialize
    @player = Player.new
    @dictionnary = Dictionnary.new
    @guess = Guess.new
    @guess_arr = []
    @incorrect_letters = []
  end

  def start
    new_word = @dictionnary.chose_word.upcase
    word_length = new_word.length
    @guess_arr = (['_'] * word_length)
    letters = new_word.chars
    p letters

    loop do
      user_input = @player.user_input
      compare(user_input, letters)
      puts "Wrong letters : #{@incorrect_letters}"

      if letters == @guess_arr
        puts 'You win'
        break
      elsif @player.nbr_of_guess_left > 6
        puts 'Time over'
        break
      end
    end
  end

  def compare(user_input, letters)
    if letters.include?(user_input)
      letters.each_with_index do |letter, index|
        next unless letter == user_input

        @guess_arr[index] = user_input
        puts 'GUESS ARR'
        p @guess_arr
      end

    else
      @incorrect_letters << user_input
      guess_remain = @player.nbr_of_guess

      puts 'WRONG ANSWER'
      puts "Guess remaining #{guess_remain}/6"
    end
  end
end

game = Game.new
game.start
