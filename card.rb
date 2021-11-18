class Card
  attr_reader :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  # пригодится для определения очков за туза при подсчете
  def ace?
    value == 'A'
  end
end