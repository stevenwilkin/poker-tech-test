require "spec_helper"

describe Hand do
  let(:straight_flush) { Hand.new("2S 3S 4S 5S 6S") }
  let(:four_of_a_kind) { Hand.new("2S 2D 2C 2H 6S") }
  let(:full_house) { Hand.new("2S 2D 2C 5H 5S") }
  let(:flush) { Hand.new("2S 4S 8S TS AS") }
  let(:straight) { Hand.new("2S 3D 4C 5H 6S") }
  let(:three_of_a_kind) { Hand.new("2S 2D 2C TH AS") }
  let(:two_pairs) { Hand.new("2S 2D 8C AH AS") }
  let(:pair) { Hand.new("2S 2D 8C TH AS") }
  let(:high_card) { Hand.new("2S 4D 8C AS TH") }

  describe "#new" do
    let(:cards) { "2S 4D 8C TH AS" }
    let(:hand) { Hand.new(cards) }

    it "creates a new hand" do
      hand.should be_a Hand
    end

    it "has 5 cards" do
      hand.cards.should have(5).cards
    end

    context "first card" do
      let(:card) { hand.cards.first }

      it "is the 2S" do
        card.should == Card.new("2S")
      end
    end

    context "last card" do
      let(:card) { hand.cards.last }

      it "is the AS" do
        card.should == Card.new("AS")
      end
    end
  end

  describe ".high_card" do
    let(:cards) { "2S 4D 8C AS TH" }
    let(:hand) { Hand.new(cards) }

    it "is the AS" do
      hand.high_card.should == Card.new("AS")
    end
  end

  describe ".pair" do
    context "without a pair" do
      let(:hand) { Hand.new("2S 4D 8C TH AS") }

      it "is nil" do
        hand.pair.should be_nil
      end
    end

    context "with a pair" do
      let(:hand) { Hand.new("2S 2D 8C TH AS") }

      it "returns the pair" do
        hand.pair.sort.should == [Card.new("2S"), Card.new("2D")].sort
      end
    end
  end

  describe "two_pairs" do
    context "without 2 pairs" do
      let(:hand) { Hand.new("2S 4D 8C TH AS") }

      it "is nil" do
        hand.two_pairs.should be_nil
      end
    end

    context "with 2 pairs" do
      let(:hand) { Hand.new("2S 2D 8C AH AS") }

      it "returns 2 pairs" do
        hand.two_pairs.should have(2).items
      end

      it "returns the first pair" do
        hand.two_pairs.first.should == [Card.new("2D"), Card.new("2S")]
      end

      it "returns the second pair" do
        hand.two_pairs.last.should == [Card.new("AH"), Card.new("AS")]
      end
    end
  end

  describe "three of a kind" do
    context "with a pair" do
      let(:hand) { Hand.new("2S 2D 8C TH AS") }

      it "is nil" do
        hand.three_of_a_kind.should be_nil
      end
    end

    context "with three of a kind" do
      let(:hand) { Hand.new("2S 2D 2C TH AS") }

      it "returns 3 cards" do
        hand.three_of_a_kind.sort.should == make_cards("2S 2D 2C").sort
      end
    end
  end

  describe ".straight" do
    context "without a straight" do
      let(:hand) { Hand.new("2S 4D 8C TH AS") }

      it "is nil" do
        hand.straight.should be_nil
      end
    end

    context "with a straight" do
      let(:hand) { Hand.new("2S 3D 4C 5H 6S") }

      it "returns the straight" do
        hand.straight.sort.should == hand.cards.sort
      end
    end
  end

  describe ".flush" do
    context "without a flush" do
      let(:hand) { Hand.new("2S 3D 4C 5H 6S") }

      it "is nil" do
        hand.flush.should be_nil
      end
    end

    context "with a flush" do
      let(:hand) { Hand.new("2S 3S 5S TS AS") }

      it "returns the flush" do
        hand.flush.sort.should == hand.cards.sort
      end
    end
  end

  describe ".full_house" do
    context "without a full_house" do
      let(:hand) { Hand.new("2S 2D 2C 5H 6S") }

      it "is nil" do
        hand.full_house.should be_nil
      end
    end

    context "with a full_house" do
      let(:hand) { Hand.new("2S 2D 2C 5H 5S") }

      it "returns the full_house" do
        hand.full_house.sort.should == hand.cards.sort
      end
    end
  end

  describe ".four_of_a_kind" do
    context "without a four_of_a_kind" do
      let(:hand) { Hand.new("2S 2D 2C 5H 6S") }

      it "is nil" do
        hand.four_of_a_kind.should be_nil
      end
    end

    context "with a four_of_a_kind" do
      let(:hand) { Hand.new("2S 2D 2C 2H 6S") }

      it "returns the four_of_a_kind" do
        hand.four_of_a_kind.sort.should == make_cards("2S 2D 2C 2H").sort
      end
    end
  end

  describe ".straight_flush" do
    context "with a straight" do
      let(:hand) { Hand.new("2S 3D 4C 5H 6S") }

      it "is nil" do
        hand.straight_flush.should be_nil
      end
    end

    context "with a flush" do
      let(:hand) { Hand.new("2S 4S 8S TS AS") }

      it "is nil" do
        hand.straight_flush.should be_nil
      end
    end

    context "with a straight flush" do
      let(:hand) { Hand.new("2S 3S 4S 5S 6S") }

      it "returns the straight flush" do
        hand.straight_flush.sort.should == hand.cards.sort
      end
    end
  end

  describe ".highest_combination" do
    it "returns the highest combination of cards in the hand" do
      straight_flush.highest_combination.should == :straight_flush
      four_of_a_kind.highest_combination.should == :four_of_a_kind
      full_house.highest_combination.should == :full_house
      flush.highest_combination.should == :flush
      three_of_a_kind.highest_combination.should == :three_of_a_kind
      two_pairs.highest_combination.should == :two_pairs
      pair.highest_combination.should == :pair
      high_card.highest_combination.should == :high_card
    end
  end

  describe ".<=>" do
    it "straight flush wins against four of a kind" do
      straight_flush.should be > four_of_a_kind
    end

    it "four of a kind wins against a full house" do
      four_of_a_kind.should be > full_house
    end

    it "full house wins against a flush" do
      full_house.should be > flush
    end

    it "flush wins against a straight" do
      straight.should be > three_of_a_kind
    end

    it "straight wins against three of a kind" do
      straight.should be > three_of_a_kind
    end

    it "three of a kind wins against two pairs" do
      three_of_a_kind.should be > two_pairs
    end

    it "two pairs wins against a pair" do
      two_pairs.should be > pair
    end

    it "pair wins against a high card" do
      pair.should be > high_card
    end

    context "two straight flushes" do
      let(:straight_flush_1) { Hand.new("2S 3S 4S 5S 6S") }
      let(:straight_flush_2) { Hand.new("3S 4S 5S 6S 7S") }

      it "wins by high card" do
        straight_flush_2.should be > straight_flush_1
      end
    end

    context "two four of a kinds" do
      let(:four_of_a_kind_1) { Hand.new("3S 3D 3C 3H 6S") }
      let(:four_of_a_kind_2) { Hand.new("2S 2D 2C 2H 6S") }

      it "wins by the value of the 4 cards" do
        four_of_a_kind_1.should be > four_of_a_kind_2
      end
    end

    context "two full houses" do
      let(:full_house_1) { Hand.new("2S 2D 2C 5H 5S") }
      let(:full_house_2) { Hand.new("3S 3D 3C 5H 5S") }

      it "wins by the value of the 3 cards" do
        full_house_2.should be > full_house_1
      end
    end

    context "two flushes" do
      let(:flush_1) { Hand.new("2S 4S 8S TS QS") }
      let(:flush_2) { Hand.new("2S 4S 8S TS AS") }

      it "wins by high card" do
        flush_2.should be > flush_1
      end
    end

    context "two straights" do
      let(:straight_1) { Hand.new("2S 3D 4C 5H 6S") }
      let(:straight_2) { Hand.new("3D 4C 5H 6S 7S") }

      it "wins by high card" do
        straight_2.should be > straight_1
      end
    end

    context "two three of a kinds" do
      let(:three_of_a_kind_1) { Hand.new("2S 2D 2C TH AS") }
      let(:three_of_a_kind_2) { Hand.new("3S 3D 3C TH AS") }

      it "wins by high card" do
        three_of_a_kind_2.should be > three_of_a_kind_1
      end
    end

    context "two two pairs" do
      context "different highest pair" do
        let(:two_pairs_1) { Hand.new("2S 2D 8C KH KS") }
        let(:two_pairs_2) { Hand.new("3S 3D AC QH QS") }

        it "wins by highest pair" do
          two_pairs_1.should be > two_pairs_2
        end
      end

      context "same highest pair but different other pair" do
        let(:two_pairs_1) { Hand.new("2H 2S AC KH KS") }
        let(:two_pairs_2) { Hand.new("3H 3S 8C KD KC") }

        it "wins by second highest pair" do
          two_pairs_2.should be > two_pairs_1
        end
      end

      context "equal highest pairs" do
        let(:two_pairs_1) { Hand.new("5H 5S 6C KH KS") }
        let(:two_pairs_2) { Hand.new("5S 5D 8C KH KS") }

        it "wins by the remaining card" do
          two_pairs_2.should be > two_pairs_1
        end
      end
    end

    context "two pairs" do
      context "different pairs" do
        let(:pair_1) { Hand.new("2S 2D 8C TH AS") }
        let(:pair_2) { Hand.new("3S 3D 8C TH AS") }

        it "wins by the highest pair" do
          pair_2.should be > pair_1
        end
      end

      context "same pairs" do
        let(:pair_1) { Hand.new("2S 2D 8C TH AS") }
        let(:pair_2) { Hand.new("2S 2D 8C TH QS") }

        it "wins by the highest value in the remaining cards" do
          pair_1.should be > pair_2
        end
      end
    end

    context "two high cards" do
      context "with differing values" do
        let(:highcard_AS) { Hand.new("2D 3S 8S TS AS") }
        let(:highcard_QC) { Hand.new("2S 3C 8C TC QC") }

        it "AS > QS" do
          highcard_AS.should be > highcard_QC
        end
      end

      context "with the same value" do
        let(:highcard_8S) { Hand.new("2D 3S 8S TS AS") }
        let(:highcard_7C) { Hand.new("2S 3C 7C TC AC") }

        it "8S > 7C" do
          highcard_8S.should be > highcard_7C
        end
      end
    end
  end
end
