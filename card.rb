class Card
  include Comparable

  attr_accessor :name, :value, :suit

  VALUES = %w{2 3 4 5 6 7 8 9 T J Q K A}

  def initialize(name)
    @name = name
    @value = name[0]
    @suit = name[1]
  end

  def rank
    VALUES.index(@value)
  end

  def <=>(other)
    self.rank <=> other.rank
  end
end
