require 'csv'
require 'json'

class Dictionnary
  attr_accessor :content

  def initialize(content = '')
    @content = content.nil? || content.empty? ? File.read('lib/google-10000-english-no-swears.txt') : content
  end

  def load_file
    @content
  end

  def chose_word
    @content = @content.is_a?(String) ? @content.split("\n") : @content

    loop do
      random_number = rand(0..9894)
      word = @content[random_number]
      next if word.nil?

      # Vérifier si la longueur du mot est entre 5 et 12 caractères
      return word if word.length >= 5 && word.length <= 12
    end
  end

  def to_json(*_args)
    puts "Serializing Dictionnary to JSON: #{@content}"
    {
      content: @content
    }.to_json
  end

  def self.from_json(string)
    data = JSON.parse(string) || {} # Assure que data est un hash et non nil
    content = data['content'] || File.read('lib/google-10000-english-no-swears.txt')
    new(content)
  end
end
