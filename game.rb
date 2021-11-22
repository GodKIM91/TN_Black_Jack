require_relative 'deck'
require_relative 'player'
require_relative 'bank'
require_relative 'user'
require_relative 'dealer'

MENU = <<~MENU
  Choose action:
  1 - Check
  2 - Add card
  3 - Lets open!
MENU

class Game
  attr_reader :bank, :deck, :dealer, :player, :players
  attr_accessor :current_player

  def initialize
    @bank = Bank.new
    @dealer = Dealer.new('Dealer Bob')
    puts 'Enter you name:'
    @player = User.new(user_input)
    @players = []
    @players.push(dealer, player)
  end

  def user_input
    gets.chomp
  end

  def selected_option
    gets.chomp.to_i
  end

  def make_choise(menu = nil)
    puts menu if menu
  end

  def switch_player
    if current_player.eql?(player)
      @current_player = dealer
    else
      @current_player = player
    end
  end

  def check
    switch_player
  end

  def take2cards
    players.each { |el| 2.times {el.take_card(deck.cards.pop)} }
  end

  def start_game
    @deck = Deck.new
    take2cards
    players.each { |el| el.bet }
    bank.value += 20
    @current_player = player
    puts "Welcome to TN casino!"
    black_jack
  end

  def black_jack
    loop do
      players.each { |el| el.show_cards }
      dealer_step if current_player.eql?(dealer)
      lets_open if time_to_open?
      make_choise(MENU)
      case selected_option
      when 1 then check
      when 2 then add_card
      when 3 then lets_open
      when 4 then binding.irb
      else
        raise RuntimeError, 'Wrong command. Try 1-3'
      end
    end
  rescue RuntimeError => e
    p "#{e.message}"
    retry
  end

  def time_to_open?
    dealer.hand_cards.size > 2 && player.hand_cards.size > 2
  end


  def add_card
    if current_player.less_three?
      current_player.take_card(deck.cards.pop)
      switch_player
    else
      raise RuntimeError, "You cant take card. Choose 1 or 3"
    end
  end

  def dealer_step
    if current_player.score < 17 && current_player.less_three?
      add_card
    elsif current_player.score >= 17
      switch_player
    end
  end

  def lets_open
    puts "***" * 10
    player.show_cards
    dealer.open_cards
    who_winner
  end

  def draw
    (dealer.score == player.score) || (dealer.busted? && player.busted?)
  end

  def player_win
    (dealer.busted? && player.normal_score) || ((player.score > dealer.score) && (player.normal_score))
  end

  def dealer_win
    (player.busted? && dealer.normal_score) || ((dealer.score > player.score) && (dealer.normal_score))
  end

  def who_winner
    if draw
      puts "Draw!"
      players.each {|el| el.money += bank.value/2}
    elsif player_win
      puts "Winner #{player.name}!!!"
      player.money += bank.value
    elsif dealer_win
      puts "Winner #{dealer.name}!!!"
      dealer.money += bank.value
    end
    restart
  end

  def lose
    # проверка, есть ли проигравшие все деньги игроки
    players.map { |el| el.no_money }.include?(true)
  end

  def restart
    puts 'Try again? [y/n]'
    if %w[y Y].include?(user_input) && !lose
      players.each { |el| el.hand_cards = [] }
      bank.value = 0
      start_game
    else
      puts "Game over with result #{player.name}: #{player.money}, #{dealer.name}: #{dealer.money}"
      abort "No money for playing!"
    end
  end
end

Game.new.start_game







