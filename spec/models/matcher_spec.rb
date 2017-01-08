require 'rails_helper'

RSpec.describe Matcher do
  before do
    @user = create(:user)
    @game = @user.games.create(player_one_id: @user.id, player_two_id: 2)
    @c1 = @game.cards.first
    @c2 = @game.cards.second
  end

  it "#compare calls #reveal_matchables on its arguments" do
    expect(Matcher).to receive(:reveal_matchables).with([@c1,@c2])

    Matcher.compare(@c1,@c2)
  end

  it "#reveal_matchables calls #reveal! on its arguments" do
    @c1 = @game.cards.first
    @c2 = @game.cards.second
    expect(@c1).to receive(:reveal!)
    expect(@c2).to receive(:reveal!)

    Matcher.reveal_matchables([@c1,@c2])
  end

  it "#hide_matchables calls hide! on its arguments" do
    @c1 = @game.cards.first
    @c2 = @game.cards.second
    expect(@c1).to receive(:hide!)
    expect(@c2).to receive(:hide!)

    Matcher.hide_matchables([@c1,@c2])
  end
end
