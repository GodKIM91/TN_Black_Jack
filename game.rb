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
  attr_accessor :current_player, :steps

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

  def welcome_message
    puts "Welcome to TN casino!"
  end

  def make_choise(menu = nil)
    puts menu if menu
  end

  def starter_bet
    players.each { |el| el.bet }
  end

  def replenish_bank
    bank.value += 20
  end

  def switch_player
    if current_player.eql?(player)
      @current_player = dealer
    else
      @current_player = player
    end
  end

  def check
    # инкрементируем переменную @steps, определяя, сколько было сделано переходов хода
    if @steps < 1
      switch_player
      @steps += 1
    else 
      raise RuntimeError, "You cant check your step, choose 2 or 3"
    end
  end

  def take2cards
    players.each { |el| 2.times {el.take_card(deck.cards.pop)} }
  end

  def start_game
    @deck = Deck.new
    @steps = 0
    take2cards
    starter_bet
    replenish_bank
    @current_player = player
    welcome_message
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
      @steps += 1
      switch_player
    else
      raise RuntimeError, "You cant take card. Choose 1 or 3"
    end
  end

  def dealer_step
    if current_player.score < 17 && current_player.less_three?
      add_card
    elsif current_player.score >= 17 && steps < 2
      switch_player
    elsif current_player.score >= 17 && steps > 2
      lets_open
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
      puts "Winner is #{player.name}!!!"
      player.money += bank.value
    elsif dealer_win
      puts "Winner is #{dealer.name}!!!"
      dealer.money += bank.value
    end
    show_balance
    restart
  end
  
  def show_balance
    puts "Баланс игроков:\n#{player.name} - #{player.money}$\n#{dealer.name} - #{dealer.money}$"
  end

  def lose
    # проверка, есть ли проигравшие все деньги игроки
    players.map { |el| el.no_money }.include?(true)
  end

  def game_over
    abort "Game over with result #{player.name}: #{player.money}$, #{dealer.name}: #{dealer.money}$"
  end

  def restart
    puts 'Try again? [y/n]'
    if %w[y Y].include?(user_input) && !lose
      players.each { |el| el.hand_cards = [] }
      bank.value = 0
      start_game
    elsif lose
      lose_player = players.select { |el| el.money.zero? }
      puts "#{lose_player.first.name} cant continue game, not enough money!"
      game_over
    else
      game_over
    end
  end
end

Game.new.start_game







