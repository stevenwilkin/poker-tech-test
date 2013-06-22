Dir[File.join(File.dirname(__FILE__), "..", "*.rb")].each { |file| require file }

# hacky
def make_cards(cards)
  Hand.new(cards).cards
end
