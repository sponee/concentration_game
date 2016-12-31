class Card < ApplicationRecord
  belongs_to :game

  Card = Struct.new(:content, :image_url)

  CARDS = [
    Card.new('Pikachu', 'pikachu.png'),
    Card.new('Bulbasaur', 'bulbasaur.png'),
    Card.new('Charmander', 'charmander.png'),
    Card.new('Squirtle', 'squirtle.png'),
    Card.new('Eevee', 'eevee.png'),
    Card.new('Chikorita', 'chikorita.png'),
    Card.new('Cyndaquil', 'cyndaquil.png'),
    Card.new('Totodile', 'totodile.png'),
    Card.new('Marill', 'marrill.png')
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
