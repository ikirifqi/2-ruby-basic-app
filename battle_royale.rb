# Player class
class Player
  attr_accessor :name, :manna, :blood

  def initialize(name)
    @name = name
    @manna = 40
    @blood = 100
  end
end

# Game class
class BattleRoyale
  def initialize
    @players = Array.new
  end

  def run
    print_welcome_and_description
    puts '# Current Player:                                   #'
    if @players.count.zero?
      puts '#     -                                             #'
    else
      @players.each do |player|
        puts "#     #{player.name}"
      end
    end
    puts '# *max player 2                                     #'
    puts '#---------------------------------------------------#'
    print 'Command: '
    wait_for_command
  end

  private
    def new_character
      print_welcome_and_description

      puts '# Current Player:                                   #'
      if @players.count.zero?
        puts '#     -                                             #'
      else
        @players.each do |player|
          puts "#     #{player.name}"
        end
      end

      if @players.count > 1
        puts 'Maximal player adalah 2 player'
        press_any_key_and_continue
        gets.chomp
      else
        print 'Masukan nama player: '
        player = Player.new(gets.chomp)
        @players << player
      end

      run
    end

    def start_game
      if @players.count < 2
        puts 'Belum ada player, silakan buat player terlebih dahulu'
        press_any_key_and_continue
        run
      end

      game_running = true
      attack = nil
      defend = nil
      battle_num = 1

      print_welcome

      while game_running do
        puts "Battle #{battle_num} Start"

        print 'siapa yang akan menyerang: '
        attack = find_player_by_name(gets.chomp)
        print 'siapa yang diserang: ' unless attack.nil?
        defend = find_player_by_name(gets.chomp)

        unless defend.nil? || attack.nil?
          game_running = do_battle(attack, defend)
          battle_num += 1
        end
      end
    end

    def do_battle(attacker, defender)
      attacker.manna -= 5
      defender.blood -= 20

      puts 'Description:'
      puts "#{attacker.name}: manna = #{attacker.manna} blood = #{attacker.blood}"
      puts "#{defender.name}: manna = #{defender.manna} blood = #{defender.blood}"

      press_any_key_and_continue

      # Check if is the game over?
      if attacker.manna <= 0 || attacker.blood <= 0
        print_game_over(defender.name)
        false
      elsif defender.manna <= 0 || defender.blood <= 0
        print_game_over(attacker.name)
        false
      else
        puts '#---------------------------------------------------#'
        true
      end
    end

    def find_player_by_name(name)
      @players.each do |player|
        return player if player.name == name
      end

      puts 'Player tidak ditemukan, coba lagi.'
      press_any_key_and_continue
      nil
    end

    def wait_for_command
      case gets.chomp
        when 'exit'
          puts 'Goodbye...'
          exit
        when 'new'
          new_character
        when 'start'
          start_game
        else
          run
      end
    end

    def clear_screen
      system "clear" or system "cls"
    end

    def print_game_over(winner_name)
      puts ''
      puts '#---------------------------------------------------#'
      puts '#                     Game Over                     #'
      puts '#---------------------------------------------------#'
      puts "Selamat! Pemenangnya adalah: #{winner_name}"
    end

    def print_welcome_and_description
      clear_screen
      print_welcome
      puts '# Description:                                      #'
      puts '# 1. Ketik "new" untuk membuat karakter             #'
      puts '# 2. Ketik "start" untuk memulai pertarungan        #'
      puts '#---------------------------------------------------#'
    end

    def print_welcome
      clear_screen
      puts '#===================================================#'
      puts '#              Welcome to Battle Arena              #'
      puts '#---------------------------------------------------#'
    end

    def press_any_key_and_continue
      print 'Tekan enter untuk melanjutkan...'
      gets.chomp
    end
end

game = BattleRoyale.new
game.run
