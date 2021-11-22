require_relative 'player'

class User < Player
  def initialize(name = gets.chomp)
    super(name)
  end

  # метод отобажения карт игрока
  def show_cards
    puts "#{self.name} cards: "
    hand_cards.each { |card| print "#{card}|" }
    puts "\nScore: #{self.score}"
  end
end
