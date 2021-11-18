require_relative 'card'

class Player
  attr_reader :name, :cards, :money

  START_BALANCE = 100
  BET = 10

  def initialize(name)
    @name = name
    @cards = []
    @money = START_BALANCE
  end
  
  # подсчет очков
  def score
  end
  
  # делается ставка
  def bet
    @money - BET
  end
  
  # метод отобажения карт игрока
  def show_cards
    puts "\n"
    @cards.each { |card| print "#{card.name}#{card.suit} "}
  end

  # ??? получение карт
  def get_card(card)
    @cards << card
  end

end

