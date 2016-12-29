class Card < ApplicationRecord
  belongs_to :game

  CARD_CONTENT = [
    'Pikachu',
    'Bulbasaur',
    'Charmander',
    'Squirtle',
    'Eevee',
    'Chikorita',
    'Cyndaquil',
    'Totodile',
    'Marill'
  ]

  def matched?
    self.matched
  end

  def match!
    self.update_attributes!(matched: true)
  end
end
