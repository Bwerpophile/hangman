class Player
  attr_reader :nbr_of_guess_left, :name
  attr_accessor :user_input

  def initialize
    @nbr_of_guess_left = 0
    @name = 'Joris'
  end

  # def valid_input?
  # empecher l'utilisateur de pouvoir rentrer plusieurs lettres.
  # end

  def user_input
    puts 'Enter a letter'
    gets.chomp.upcase
  end

  def nbr_of_guess
    @nbr_of_guess_left += 1
  end
end
