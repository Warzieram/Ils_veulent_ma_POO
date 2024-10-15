require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'


player1 = Player.new("Josianne")
player2 = Player.new("José")

puts "Voici l'état des joueurs: "
player1.show_state
player2.show_state

print "\n"
puts "Passons à la phase d'attaque:"

while (player1.life_points > 0 || player2.life_points > 0) do
  player1.attacks(player2)
  if(player2.life_points <= 0)
    break
  end
  player2.attacks(player1)
end

#binding.pry