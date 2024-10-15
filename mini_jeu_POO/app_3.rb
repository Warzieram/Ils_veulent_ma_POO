require_relative "lib/game.rb"

message_de_bienvenue = 
"

 _______  __   __  _______    _______  ______   __   __  _______  __    _  _______  __   __  ______    _______ 
|       ||  | |  ||       |  |   _   ||      | |  | |  ||       ||  |  | ||       ||  | |  ||    _ |  |       |
|_     _||  |_|  ||    _  |  |  |_|  ||  _    ||  |_|  ||    ___||   |_| ||_     _||  | |  ||   | ||  |    ___|
  |   |  |       ||   |_| |  |       || | |   ||       ||   |___ |       |  |   |  |  |_|  ||   |_||_ |   |___ 
  |   |  |       ||    ___|  |       || |_|   ||       ||    ___||  _    |  |   |  |       ||    __  ||    ___|
  |   |  |   _   ||   |      |   _   ||       | |     | |   |___ | | |   |  |   |  |       ||   |  | ||   |___ 
  |___|  |__| |__||___|      |__| |__||______|   |___|  |_______||_|  |__|  |___|  |_______||___|  |_||_______|

(copyright)
"




puts message_de_bienvenue
puts "Veuillez entrer votre prénom: "
print "> "

name = gets.chomp

puts "Veuillez entrer le nombre d'ennemis souhaité: "
print "> "

number_of_ennemies = gets.chomp.to_i



game = Game.new(name, number_of_ennemies)


while game.is_still_going? do
  

  game.new_players_in_sight
  game.show_players
  user_choice = game.menu
  game.menu_choice(user_choice)
  if game.is_still_going? 
    game.ennemies_attack
  end
end

game.end_game

