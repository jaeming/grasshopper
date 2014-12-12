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

  it "searches for text in Boards and Messages" do
    board1 = create(:board, title: "xander")
    board2 = create(:board, title: "hello")

    results = Board.search("xander")
binding.pry
    expect(results).to include(board1)
    expect(results).not_to include(board2)
  end
end
