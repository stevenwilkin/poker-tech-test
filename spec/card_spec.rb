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
end
