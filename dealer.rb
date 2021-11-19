class Dealer < Player
  def show_cards
    puts "#{self.name}: "
    puts "*" * @hand_cards.size
  end

  def open_cards
    puts "#{self.name}: "
    @hand_cards.each { |card| puts "#{card}" }
  end
end