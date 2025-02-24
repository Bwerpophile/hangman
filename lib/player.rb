require 'json'

class Player
  attr_accessor :nbr_of_guess_left, :name

  def initialize(nbr_of_guess_left = 0, name = 'Joris')
    @nbr_of_guess_left = nbr_of_guess_left
    @name = name
  end

  def user_input
    puts 'Enter a letter'
    gets.chomp.upcase
  end

  def nbr_of_guess
    @nbr_of_guess_left += 1
  end

  def to_json(*_args)
    puts "Serializing Player to JSON: #{@nbr_of_guess_left}, #{@name}"
    {
      nbr_of_guess_left: @nbr_of_guess_left,
      name: @name
    }.to_json
  end

  def self.from_json(string)
    puts "Deserializing Player from JSON: #{string}"
    data = JSON.parse(string) || {}
    puts "Deserialized Player data: #{data}"

    nbr_of_guess_left = data['nbr_of_guess_left'].to_i # Convertir en Integer
    name = data['name'] || 'Joris'

    new(nbr_of_guess_left, name)
  end
end
