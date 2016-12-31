module Matcher
  def self.compare(matchable_one, matchable_two)
    Matcher.reveal_cards([matchable_one,matchable_two])
    if matchable_one.content == matchable_two.content
      matchable_one.match!
      matchable_two.match!
      return true
    else 
      return false
    end
  end

  def self.reveal_cards(cards)
    cards.each { |c| c.reveal! }
  end

  def self.hide_cards(cards)
    cards.each { |c| c.hide! }
  end
end