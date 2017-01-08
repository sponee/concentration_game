require 'rails_helper'

RSpec.describe Matcher do
  it "#compare checks the content of two matchables" do 
    user = create(:user)
    game = user.games.create(player_one_id: user.id, player_two_id: 2)
    c1, c2 = game.cards.where(content: "Pikachu")
    expect(c1.matched?).to eq(false)
    expect(c2.matched?).to eq(false)
    Matcher.compare(c1, c2)
    expect(c1.matched?).to eq(true)
    expect(c1.matched?).to eq(true)
  end
end
