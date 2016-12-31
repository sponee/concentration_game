module GamesHelper
  def present_guess(card)
    if card.matched? || card.revealed?
      return card.content
    else    
      return card.id
    end
  end

  def present_card(card)
    if card.matched?
      return card.content
    else    
      return card.id
    end
  end
end
