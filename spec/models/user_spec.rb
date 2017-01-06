require_relative '../spec_helper'

RSpec.describe User do 
 
  before do
    @user = create(:user)
  end

  it "requires an email address" do
    email = @user.email
    @user.email = nil
    expect(@user.valid?).to eq(false)
    expect(@user.errors[:email]).to include("can't be blank")

    @user.email = email
    expect(@user.valid?).to eq(true)
  end

  it "requires a username" do
    username = @user.username
    @user.username = nil
    expect(@user.valid?).to eq(false)
    expect(@user.errors[:username]).to include("can't be blank")

    @user.username = username
    expect(@user.valid?).to eq(true)
  end
end