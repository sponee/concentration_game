require 'rails_helper'

RSpec.describe Matcher do
  before do
    @user = create(:user)
    @game = @user.games.create(player_one_id: @user.id, player_two_id: 2)
  end
  it "#compare checks the content of two matchables" do 
    c1, c2 = @game.cards.where(content: "Pikachu")
    expect(c1.matched?).to eq(false)
    expect(c2.matched?).to eq(false)
    Matcher.compare(c1, c2)
    expect(c1.matched?).to eq(true)
    expect(c1.matched?).to eq(true)
  end

  it "#reveal_cards calls #reveal! on its arguments" do
    c1 = @game.cards.first
    c2 = @game.cards.second
    expect(c1).to receive(:reveal!)
    expect(c2).to receive(:reveal!)

    Matcher.reveal_cards([c1,c2])
  end
end
