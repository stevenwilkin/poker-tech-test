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

    context "high cards" do
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
