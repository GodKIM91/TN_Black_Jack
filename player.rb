require_relative 'card'

class Player
  attr_reader :name, :hand_cards, :money

  START_BALANCE = 100
  BET = 10

  def initialize(name)
    @name = name
    @hand_cards = []
    @money = START_BALANCE
  end
  
  # подсчет очков карт
  def score
    points = 0
    hand_cards.each do |card|
    points += 
      if card.ace?
        11
      elsif card.mens?
        10
      else
        card.value
      end
    end
    hand_cards.select { |card| card.ace?}.size.times do
      points -= 10 if points > 21
    end
    points
  end
  
  # делаем ставку
  def bet
    @money -= BET
  end
  
  #берем карту на руку
  def take_card(deck)
    @hand_cards << deck.cards.pop
    show_cards
  end
  
  # метод отобажения карт игрока
  def show_cards
    puts "#{self.name}: "
    @hand_cards.each { |card| puts "#{card}" }
  end

end

