require_relative './player'
require "tty-prompt"


class Game

  attr_accessor :human_player, :ennemies_in_sight, :players_left
  def initialize(name, n_ennemies)
    @human_player = HumanPlayer.new(name)
    @ennemies_in_sight = []
    @players_left = n_ennemies
    @prompt = TTY::Prompt.new
  end

  def ennemies
    return @ennemies_in_sight
  end

  def kill_player(player)
    @ennemies_in_sight.delete(player)
    @players_left -= 1
  end

  def is_still_going?
    return @human_player.life_points > 0 && @players_left != 0
  end

  def show_players
    print "\n"
    @human_player.show_state
    puts "Il reste #{@ennemies_in_sight.length} ennemis en vue"
    puts "Il reste #{@players_left} ennemis au total"
  end

  def menu
    if @ennemies_in_sight.length > 0
      options = {"Effectuer une action": 1, "Effectuer une attaque": 2}
    else
      options = {"Effectuer une action": 1}
    end
    menu = @prompt.select("\nQue veux-tu faire ?", options)

    case menu
    when 1
      options = {"Checher une arme": -1, "Chercher à se soigner": -2}
      choix = @prompt.select("Quelle action ?", options)
    when 2
      options = @ennemies_in_sight.each_with_index.to_h {|element, index| [element.name, index]}
      choix = @prompt.select("Quel ennemi ?", options).to_s
      
    end
    return choix
  end

  def press_enter_to_continue
    @prompt.keypress("Appuyer sur entrée pour continuer", keys: [:return])
    print "\n"
  end

  def menu_choice(user_choice)
    
    valid_choice = false

    while !valid_choice

      case user_choice
      when -1
        @human_player.search_weapon
        valid_choice = true
        press_enter_to_continue
      when -2
        @human_player.search_health_pack
        valid_choice = true
        press_enter_to_continue
      when /([0-#{@ennemies_in_sight.length}])/
        chosen_ennemy = ennemies[user_choice.to_i]
        @human_player.attacks(chosen_ennemy)
        if(chosen_ennemy.life_points <= 0)
          kill_player(chosen_ennemy)
        end
        valid_choice = true
        press_enter_to_continue
      
      
      else
        puts "Veuillez entrer une option valide !"
        print "> "
        user_choice = gets.chomp
      end
    end
    
  end

  def ennemies_attack
    puts "Les ennemis t'attaquent !\n"
    @ennemies_in_sight.each do |ennemy| 
      if ennemy.life_points > 0
        ennemy.attacks(@human_player)
        press_enter_to_continue
      end
    end
  end

  def end_game
    print "\n"
    puts "La partie est finie !"

    winner_message = "
    

 _     _  ___   __    _  __    _  _______  ______   
| | _ | ||   | |  |  | ||  |  | ||       ||    _ |  
| || || ||   | |   |_| ||   |_| ||    ___||   | ||  
|       ||   | |       ||       ||   |___ |   |_||_ 
|       ||   | |  _    ||  _    ||    ___||    __  |
|   _   ||   | | | |   || | |   ||   |___ |   |  | |
|__| |__||___| |_|  |__||_|  |__||_______||___|  |_|

"

    loser_message = "


 ___      _______  _______  _______  ______   
 |   |    |       ||       ||       ||    _ |  
 |   |    |   _   ||  _____||    ___||   | ||  
 |   |    |  | |  || |_____ |   |___ |   |_||_ 
 |   |___ |  |_|  ||_____  ||    ___||    __  |
 |       ||       | _____| ||   |___ |   |  | |
 |_______||_______||_______||_______||___|  |_|
 
 
    "

    if @human_player.life_points > 0
      puts "BRAVO TU AS GAGNÉ !!"
      print winner_message
    else
      puts "DOMMAGE TU AS PERDU ! (git gud)"
      print loser_message
    
    end
  end

  def new_players_in_sight
    if @ennemies_in_sight.length == @players_left
      print "\n"
      puts "Tous les joueurs sont déjà en vue"
      print "\n"
    else
      dice = rand(1..6)
      case dice
      when 1
        puts "Aucun ennemi supplémentaire n'arrive..."
      when 2..4
        id = rand(0..9999)
        new_player = Player.new("Joueur_#{id}")
        puts "Le joueur #{new_player.name} entre dans l'arène !"
        @ennemies_in_sight << new_player
      when 5..6
        for i in 0..1 do 
          id = rand(0..9999)
          new_player = Player.new("Joueur_#{id}")
          puts "Le joueur #{new_player.name} entre dans l'arène !"
          @ennemies_in_sight << new_player
        end
      end
    end
  end
end
