class Player
  def initialize
    @nbr_of_guess_left = 0
    @name = 'Joris'
  end

  # def valid_input?
  # empecher l'utilisateur de pouvoir rentrer plusieurs lettres.
  # end

  def user_input
    puts 'Enter a letter'
    user_input = gets.chomp.upcase
    puts user_input
  end
end

player = Player.new
player.user_input
