module GamesHelper
  def present_guess(card)
    if card.matched? || card.revealed?
      return image_tag(card.image_url)
    else    
      return image_tag('pokeball.png')
    end
  end

  def present_card(card)
    if card.matched?
      return image_tag(card.image_url)
    else    
      return image_tag('pokeball.png')
    end
  end
end
