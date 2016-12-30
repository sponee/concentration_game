module Matcher
  def self.compare(matchable_one, matchable_two)
    if matchable_one.content == matchable_two.content
      matchable_one.match!
      matchable_two.match!
    end
  end

  def self.flip_cards(cards)
    cards.each do {|c| c.flip! }
  end
end