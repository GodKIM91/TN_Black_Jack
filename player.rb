require_relative 'card'

class Player
  attr_reader :name
  attr_accessor :money, :hand_cards

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

  # проверяем число карт на руках
  def less_three?
    hand_cards.size < 3
  end

  def take_card(card)
    hand_cards << card
  end

  def busted?
    score > 21
  end

  def normal_score
    score <= 21
  end

  #проверяем банкрот ли игрок
  def no_money
    money == 0
  end
end

