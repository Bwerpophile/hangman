require_relative 'player'
require_relative 'dictionnary'
require 'json'

class Game
  attr_accessor :player, :dictionnary, :guess_arr, :incorrect_letters

  def initialize(player = Player.new, dictionnary = Dictionnary.new, guess_arr = [], incorrect_letters = [],
                 guess_remain = 6)
    @player = player
    @dictionnary = dictionnary
    @guess_arr = guess_arr
    @incorrect_letters = incorrect_letters
    @guess_remain = guess_remain
  end

  def start
    new_word = @dictionnary.chose_word.upcase
    word_length = new_word.length
    @guess_arr.empty? ? @guess_arr = (p ['_'] * word_length) : (puts "Guess array already initialized: #{@guess_arr}")
    puts "Guess remaining #{@guess_remain}/6"
    puts "Wrong letters : #{@incorrect_letters}"
    letters = new_word.chars

    loop do
      break if user_save

      user_input = @player.user_input
      compare(user_input, letters)
      puts "Guess remaining #{@guess_remain}/6"
      puts "Wrong letters : #{@incorrect_letters}"

      if @guess_arr.join == new_word
        puts 'You win'
        break
      elsif  @guess_remain == 0
        puts 'Time over'
        p letters
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
      @guess_remain -= 1

      puts 'WRONG ANSWER'
    end
  end

  def user_save
    puts 'Do you want to save the game? (Y/N)'
    user_input = gets.chomp.upcase

    if user_input == 'Y'
      save_game('data.json')
      # Vérifier le contenu du fichier pour confirmer la sauvegarde
      if File.exist?('data.json')
        saved_data = JSON.parse(File.read('data.json'))
        puts "Saved data: #{saved_data}"
      else
        puts 'Failed to save the game.'
      end
      puts 'Game saved. Exiting...'
      true
    elsif user_input == 'N'
      puts 'Game not saved. Continuing...'
      false
    else
      puts "Invalid input. Please enter 'Y' or 'N'."
      user_save # Rappeler la méthode pour une nouvelle entrée
    end
  end

  def save_game(file_path)
    File.write(file_path, to_json)
  end

  def to_json(*_args)
    {
      player: @player.to_json,
      dictionnary: @dictionnary.to_json,
      guess_arr: @guess_arr,
      incorrect_letters: @incorrect_letters,
      guess_remain: @guess_remain
    }.to_json
  end

  def self.from_json(string)
    puts "Deserializing from JSON: #{string}"

    data = begin
      JSON.parse(string)
    rescue StandardError
      nil
    end # Ajoute une protection contre les erreurs de parsing
    return nil if data.nil? # Vérifie que les données sont bien présentes

    puts "Deserialized data: #{data}"

    # Vérifier que les données essentielles existent
    return nil if data['player'].nil? || data['dictionnary'].nil?

    new(
      Player.from_json(data['player'].to_json),
      Dictionnary.from_json(data['dictionnary'].to_json),
      data['guess_arr'] || [],
      data['incorrect_letters'] || [],
      data['guess_remain'] || []
    )
  end

  def self.restart_game(file_path)
    if File.exist?(file_path) && !File.empty?(file_path)
      puts 'Do you want to reload the game ? (Y/N)'
      user_input = gets.chomp.upcase
      if user_input == 'Y'
        json_data = File.read(file_path)
        Game.from_json(json_data)
      else
        user_input == 'N'
        Game.new
      end
    else
      Game.new
    end
  end
end

# Exemple d'utilisation
game = Game.restart_game('data.json')
game.start
game.save_game('data.json')
