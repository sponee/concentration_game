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
end
