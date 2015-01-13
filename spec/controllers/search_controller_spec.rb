require 'rails_helper'

RSpec.describe SearchController, :type => :controller do

  it "searches for text in Board titles" do
    board1 = create(:board, title: "zebulon")
    board2 = create(:board, title: "hello")

    results1 = Board.search("zebulon").map { |r| r._source }
    title = JsonPath.on(results1, '$..title')

    expect(title).to include("zebulon")
    expect(title).not_to include("hello")
  end

  it "searches for text in Board text" do
    board3 = create(:board, text: "lots of butter")
    board4 = create(:board, text: "We also have lots of butter")
    board5 = create(:board, text: "just margin")

    results2 = Board.search("lots of butter").map { |r| r._source }
    text = JsonPath.on(results2, '$..text')

    expect(text).to include("lots of butter")
    expect(text).not_to include("just margin")
  end
end
