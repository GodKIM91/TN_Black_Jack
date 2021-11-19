require_relative 'deck'
require_relative 'player'
require_relative 'bank'
require_relative 'user'
require_relative 'dealer'

# puts 'Как Вас зовут?'
# name = gets.chomp
# p1 = Player.new(name)
# del = Player.new('kek')

# d = Deck.new
# p1.hand_cards << d.cards.pop
# del.hand_cards << d.cards.pop

# p1.show_cards
# del.show_cards
# puts p1.score
# puts del.score

class Game
  attr_reader :bank, :deck, :dealer, :player

  def initialize
    @bank = Bank.new
    @deck = Deck.new
    @dealer = Dealer.new('Dealer Bob')
  end

  def user_input
    gets.chomp
  end

  def start_game
    puts 'Enter your name:'
    @player = Player.new(user_input)
    2.times { player.take_card(deck) }
    2.times { dealer.take_card(deck) }
    dealer.bet
    player.bet
    bank.value += 20
    binding.irb
  end

end

Game.new.start_game






