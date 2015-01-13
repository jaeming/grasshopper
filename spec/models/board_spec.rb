require 'rails_helper'

RSpec.describe Board, :type => :model do
  it "is invalid without a title" do
    @board1 = build(:board, title: nil)
    expect(@board1).not_to be_valid
  end

  it "requires text of over 5 characters" do
    @board2 = build(:board, text: "yeah")
    expect(@board2).not_to be_valid
  end
end
