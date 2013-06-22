require "spec_helper"

describe Hand do
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

  describe ".<=>" do
    context "high cards of differing values" do
      let(:highcard_AS) { Hand.new("2S 2S 8S TS AS") }
      let(:highcard_QC) { Hand.new("2C 2C 8C TC QC") }

      it "AS > QS" do
        highcard_AS.should be > highcard_QC
      end
    end

    context "high cards with same value" do
      let(:highcard_8S) { Hand.new("2S 2S 8S TS AS") }
      let(:highcard_7C) { Hand.new("2C 2C 7C TC AC") }

      it "8S > 7C" do
        highcard_8S.should be > highcard_7C
      end
    end
  end
end
