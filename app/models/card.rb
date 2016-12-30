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

  def reveal!
    self.update_attributes!(revealed: true)
  end

  def hide!
    self.update_attributes!(revealed: false)
  end

  def revealed?
    self.revealed
  end
end
