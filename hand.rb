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
    three_of_a_kind_from_array(@cards)
  end

  def straight
    for i in 0..(@cards.length - 2)
      return unless @cards[i].rank == @cards[i + 1].rank - 1
    end
    @cards
  end

  def flush
    return unless @cards.map(&:suit).uniq.count == 1
    @cards
  end

  def full_house
    triple = three_of_a_kind
    return unless triple
    return unless pair_from_array(@cards - triple)
    @cards
  end

  def four_of_a_kind
    return unless two_pairs
    return unless two_pairs.first.first == two_pairs.last.last
    two_pairs.flatten
  end

  def straight_flush
    return @cards if straight and flush
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

  def three_of_a_kind_from_array(items)
    the_pair = pair_from_array(items)
    return nil unless the_pair
    remainder = items - the_pair
    remainder.each do |card|
      return ([card] + the_pair) if the_pair.member? card
    end
  end
end
