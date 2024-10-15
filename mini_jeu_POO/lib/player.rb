class Player
  def initialize(name)
    @name = name
    @hp = 10
  end

  def name
    @name
  end

  def life_points
    @hp
  end

  def show_state
    puts "\n#{@name} a #{@hp} points de vie"
  end

  def gets_damage(n)
    @hp -= n
    if (@hp <= 0)
      puts "\nLe joueur #{@name} a été tué !"
    end
  end

  def attacks(player)
    damage = compute_damage
    puts "\n#{@name} attaque le joueur #{player.name}"
    puts "il lui inflige #{damage} points de dommages\n\n"
    player.gets_damage(damage)
    

  end

  def compute_damage
    return rand (1..6)
  end
end

class HumanPlayer < Player
  def initialize(name)
    super name
    @weapon_level = 1
    @hp = 100
  end

  def show_state
    puts "#{@name} a #{@hp} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    return super * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "\nTu as trouvé une arme de niveau #{new_weapon_level}"

    if new_weapon_level > @weapon_level
      puts "Youhou ! elle est meilleure que ton arme actuelle: tu la prends."
      @weapon_level = new_weapon_level

    else
      puts "Rooooh flute de zut vraiment ça c'est pas de chance, elle n'est pas mieux que ton arme actuelle."
    end
  end

  def search_health_pack
    dice = rand(1..6)
    if(dice == 1)
      puts "Tu n'as rien trouvé..."
    elsif dice >= 2 || dice <= 5
      puts "Bravo ! Tu as trouvé un pack de 50 points de vie !"
      @hp += 50
    elsif dice == 6
      puts "Bravo ! Tu as trouvé un pack de 80 points de vie !"
      @hp += 80
    end

    @hp = @hp > 100 ? 100 : @hp
  end
end