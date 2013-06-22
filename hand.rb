class Hand
  include Comparable

  attr_accessor :cards

  COMBINATIONS = [:straight_flush, :four_of_a_kind, :full_house, :flush,
    :straight, :three_of_a_kind, :two_pairs, :pair, :high_card]

  def initialize(cards)
    @cards = cards.split(" ").map do |name|
      Card.new(name)
    end
  end

  def <=>(other)
    if self.highest_combination_rank != other.highest_combination_rank
      return self.highest_combination_rank <=> other.highest_combination_rank
    end

    return self.send(:"compare_#{self.highest_combination}", @cards, other.cards)
  end

  def highest_combination
    COMBINATIONS.each do |combination|
      return combination unless self.send(combination).nil?
    end
  end

  def highest_combination_rank
    COMBINATIONS.reverse.index(self.highest_combination)
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
    nil
  end

  def compare_high_card(items, other_items)
    loop do
      my_high_card = high_card_from_array(items)
      other_high_card = high_card_from_array(other_items)
      if my_high_card != other_high_card
        return my_high_card <=> other_high_card
      else
        return compare_high_card(items - [my_high_card], other_items - [other_high_card])
      end
    end
  end
end
