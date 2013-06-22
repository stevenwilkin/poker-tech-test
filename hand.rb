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

  def pair
    @cards.each do |card|
      (@cards.dup - [card]).each do |other|
        return [card, other] if card == other
      end
    end
    nil
  end
end
