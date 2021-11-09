module Armorable
  def attach_armor
  end

  def remove_armor
  end
end

module Castable
  def cast_spell(spell)
  end
end

class Player
  attr_reader :strength, :intelligence
  attr_accessor :name, :health

  def initialize(name, strength = roll_dice, intelligence = roll_dice)
    @name = name
    @health = 100
    @strength = strength
    @intelligence = intelligence
  end

  def heal(n)
    self.health = health + n
  end

  def hurt(n)
    self.health = health - n
  end

  def to_s
    <<~STS
    Name: #{name}
    Class: #{self.class}
    Health: #{health}
    Strength: #{strength}
    Intelligence: #{intelligence}
    STS
  end

  private

  def roll_dice
    (2..12).to_a.sample
  end
end

class Warrior < Player
  include Armorable

  def initialize(name, strength = (roll_dice + 2), intelligence = roll_dice)
    super
  end

end

class Paladin < Player
  include Armorable
  include Castable
end

class Magician < Player
  include Castable
  def initialize(name, strength = roll_dice, intelligence = (roll_dice + 2))
    super
  end
end

class Bard < Magician
  def create_potion
  end
end