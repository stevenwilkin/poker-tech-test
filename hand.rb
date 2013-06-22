class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards.split(" ").map do |name|
      Card.new(name)
    end
  end

  def high_card
    @cards.sort.last
  end

  def has_a_pair?
    @cards.uniq { |card| card.value }.count == 4
  end
end
