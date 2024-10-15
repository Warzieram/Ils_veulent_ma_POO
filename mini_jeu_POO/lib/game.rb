require_relative './player'

class Game
  def initialize(name, n_ennemies)
    @human_player = HumanPlayer.new(name)
    @ennemies_in_sight = []
    @players_left = n_ennemies
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
    menu = 
    "
     ﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
    |                                   |
    |Quelle action veux-tu effectuer ?  |
    |a - Chercher une meilleure arme    |
    |s - Chercher à se soigner          |
    |                                   |
    |Attaquer un joueur en vue :        |\n"     
  
  
  
    for i in 0..@ennemies_in_sight.length-1 do
      ennemy = @ennemies_in_sight[i]
      str = "    | #{i} - #{ennemy.name} a #{ennemy.life_points} points de vie"
      menu +=  str + " " * (40 - str.length) + "|\n"
    end
  
    menu += "    ﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋ \n"
    menu += "\n> "
    return menu
  end

  def press_enter_to_continue
    print "Appuyez sur entrée pour continuer. . ."
    gets.chomp
    print "\n"
  end

  def menu_choice(user_choice)
    
    valid_choice = false

    while !valid_choice

      case user_choice
      when "a"
        @human_player.search_weapon
        valid_choice = true
        press_enter_to_continue
      when "s"
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

    if @human_player.life_points > 0
      puts "BRAVO TU AS GAGNÉ !!"
    else
      puts "DOMMAGE TU AS PERDU ! (git gud)"
    
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
