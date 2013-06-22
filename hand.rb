class Hand
  include Comparable

  attr_accessor :cards

  def initialize(cards)
    @cards = cards.split(" ").map do |name|
      Card.new(name)
    end
  end

  def <=>(other)
    my_cards = @cards.dup
    other_cards = other.cards.dup
    loop do
      my_high_card = high_card_from_array(my_cards)
      other_high_card = high_card_from_array(other_cards)
      if my_high_card != other_high_card
        return my_high_card <=> other_high_card
      end
      my_cards = my_cards - [my_high_card]
      other_cards = other_cards - [other_high_card]
    end
  end

  def high_card
    high_card_from_array(@cards)
  end

  def pair
    pair_from_array(cards)
  end

  def two_pairs
    first_pair = pair_from_array(cards)
    return nil unless first_pair
    second_pair = pair_from_array(cards - first_pair)
    if second_pair
      [first_pair, second_pair]
    end
  end

  def three_of_a_kind
    the_pair = pair_from_array(@cards)
    return nil unless the_pair
    remainder = @cards - the_pair
    remainder.each do |card|
      return ([card] + the_pair) if the_pair.member? card
    end
  end

  private

  def high_card_from_array(items)
    items.sort.last
  end

  def pair_from_array(items)
    items.each do |card|
      (items.dup - [card]).each do |other|
        return [card, other] if card == other
      end
    end
    nil
  end
end
