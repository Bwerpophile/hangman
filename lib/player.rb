require 'json'

class Player
  attr_accessor :name

  def initialize(name = 'Joris')
    @name = name
  end

  def user_input
    puts 'Enter a letter'
    gets.chomp.upcase
  end

  def to_json(*_args)
    puts "Serializing Player to JSON: #{@name}"
    {
      name: @name
    }.to_json
  end

  def self.from_json(string)
    puts "Deserializing Player from JSON: #{string}"
    data = JSON.parse(string) || {}
    puts "Deserialized Player data: #{data}"

    name = data['name'] || 'Joris'

    new(name)
  end
end
