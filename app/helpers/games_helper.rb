module GamesHelper
  def present_guess(card)
    if card.matched? || card.revealed?
      return card.content
    else    
      return image_tag('pokeball.png')
    end
  end

  def present_card(card)
    if card.matched?
      return card.content
    else    
      return image_tag('pokeball.png')
    end
  end
end
