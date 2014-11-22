require 'rails_helper'

describe "Board API GET" do
  it "returns all boards" do
    create(:board, title: "Hello World!")
    get "/boards", {}, { "Accept" => "application/json" }

    expect(response.status).to eq 200

    body = JSON.parse(response.body)
    board_title = body.map { |m| m["title"] }

    expect(board_title).to include("Hello World!")
  end
end
