# создаем колоду, перемешиваем
require_relative 'card'

class Deck
  attr_reader :cards
  def initialize
    @cards = init_cards
  end

  def init_cards
    cards = []
    suites = %w[♠ ♣ ♥ ♦]
    values = ['A', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
    suites.each do |suit|
      values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle!
  end
end

