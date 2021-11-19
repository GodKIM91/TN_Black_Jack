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

  # определяем, что карта дает 10 очков
  def mens?
    %w[J Q K].include?(value)
  end

  def to_s
    "#{value}-#{suit}"
  end

end