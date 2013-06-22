require "spec_helper"

describe Card do
  describe ".new" do
    let(:suit) { "C" }
    let(:value) { "7" }
    let(:name) { "#{value}#{suit}" }
    let(:card) { Card.new(name) }

    it "creates a new card" do
      card.should be_a Card
    end

    it "sets the name" do
      card.name.should == name
    end

    it "sets the value" do
      card.value.should == value
    end

    it "sets the suit" do
      card.suit.should == suit
    end
  end

  describe "#<=>" do
    let(:suits) { %w{C D H S} }
    let(:values) { %w{2 3 4 5 6 7 8 9 T J Q K A} }
    let(:cards) do
      result = {}
      suits.each do |suit|
        values.each do |value|
          name = "#{value}#{suit}"
          result[name] = Card.new(name)
        end
      end
      result
    end

    context "2 number cards" do
      it "2C < 9S" do
        cards["2C"].should be < cards["9S"]
      end

      it "6C == 6D" do
        cards["6C"].should be == cards["6D"]
      end
    end
  end
end
