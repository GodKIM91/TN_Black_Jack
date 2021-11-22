class Dealer < Player
  # переопределяю метод показа карт для дилера в виде **
  def show_cards
    puts "#{self.name} cards: "
    puts "*" * hand_cards.size
  end

  def open_cards
    puts "#{self.name} cards: "
    hand_cards.each { |card| print "#{card}|" }
    puts "\nScore: #{self.score}"
  end
end