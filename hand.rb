class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = Array.new(5)
  end
end
