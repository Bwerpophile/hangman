require_relative 'player'
require_relative 'dictionnary'
require_relative 'guess'

class Game
  def initialize
    @player = Player.new
    @dictionnary = Dictionnary.new
    @guess = Guess.new
  end

  def start
    new_word = @dictionnary.chose_word
    puts new_word
  end
end

game = Game.new
game.start
