require 'bundler'



require_relative "lib/game"
require_relative "lib/player"

message_de_bienvenue = 
"

 _______  __   __  _______    _______  ______   __   __  _______  __    _  _______  __   __  ______    _______ 
|       ||  | |  ||       |  |   _   ||      | |  | |  ||       ||  |  | ||       ||  | |  ||    _ |  |       |
|_     _||  |_|  ||    _  |  |  |_|  ||  _    ||  |_|  ||    ___||   |_| ||_     _||  | |  ||   | ||  |    ___|
  |   |  |       ||   |_| |  |       || | |   ||       ||   |___ |       |  |   |  |  |_|  ||   |_||_ |   |___ 
  |   |  |       ||    ___|  |       || |_|   ||       ||    ___||  _    |  |   |  |       ||    __  ||    ___|
  |   |  |   _   ||   |      |   _   ||       | |     | |   |___ | | |   |  |   |  |       ||   |  | ||   |___ 
  |___|  |__| |__||___|      |__| |__||______|   |___|  |_______||_|  |__|  |___|  |_______||___|  |_||_______|

"



puts message_de_bienvenue
puts "Veuillez entrer votre prénom: "
print "> "

name = gets.chomp

player = HumanPlayer.new(name)
bot1 = Player.new("Josiane")
bot2 = Player.new("José")
ennemies = [bot1, bot2]

def make_menu(ennemies_array)
  menu = 
  "
   ﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
  |                                   |
  |Quelle action veux-tu effectuer ?  |
  |a - Chercher une meilleure arme    |
  |s - Chercher à se soigner          |
  |                                   |
  |Attaquer un joueur en vue :        |\n"     



  for i in 0..ennemies_array.length-1 do
    ennemy = ennemies_array[i]
    str = "  | #{i} - #{ennemy.name} a #{ennemy.life_points} points de vie"
    menu +=  str + " " * (38 - str.length) + "|\n"
  end

  menu += "   ﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋﹋\n"
  menu += "\n> "
  return menu
end

def press_enter_to_continue
  print "Appuyez sur entrée pour continuer. . ."
  gets.chomp
  print "\n"
end



while player.life_points > 0 && (bot1.life_points > 0 || bot2.life_points > 0)
  player.show_state

  
  print make_menu(ennemies)

  user_choice = gets.chomp
  case user_choice
  when "a"
    player.search_weapon
    press_enter_to_continue
  when "s"
    player.search_health_pack
    press_enter_to_continue
  when /([0-9])/
    player.attacks(ennemies[user_choice.to_i])
    press_enter_to_continue

  puts "Les ennemis t'attaquent !\n"
  else
    puts "Entrée invalide ! Votre tour a été passé !"
    press_enter_to_continue
  end
  ennemies.each do |ennemy| 
    if ennemy.life_points > 0
      ennemy.attacks(player)
      press_enter_to_continue
    end
  end

end

print "\n"
puts "La partie est finie !"

if player.life_points > 0
  puts "BRAVO TU AS GAGNÉ !!"
else
  puts "DOMMAGE TU AS PERDU ! (Deviens meilleur)"

end
