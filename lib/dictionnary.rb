require 'csv'
require 'json'

class Dictionnary
  def initialize
    @content = File.read('lib/google-10000-english-no-swears.txt')
    @computer_words = ''
  end

  def load_file
    @content
  end

  def chose_word
    @content = @content.split("\n")
    loop do
      random_number = rand(0..9894)
      word = @content[random_number]

      # Vérifier si la longueur du mot est entre 5 et 12 caractères
      return word if word.length >= 5 && word.length <= 12
    end
  end
end
