module Matcher
  def self.compare(matchable_one, matchable_two)
    Matcher.reveal_matchables([matchable_one,matchable_two])
    if matchable_one.content == matchable_two.content
      matchable_one.match!
      matchable_two.match!
      return true
    else 
      return false
    end
  end

  def self.reveal_matchables(cards)
    cards.each { |c| c.reveal! }
  end

  def self.hide_matchables(cards)
    cards.each { |c| c.hide! }
  end
end