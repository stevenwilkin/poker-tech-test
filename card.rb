class Card
  include Comparable

  attr_accessor :name, :value, :suit

  def initialize(name)
    @name = name
    @value = name[0]
    @suit = name[1]
  end

  def <=>(other)
    @value <=> other.value
  end
end
