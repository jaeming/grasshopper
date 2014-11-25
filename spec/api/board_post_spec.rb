require 'rails_helper'

describe "Board API POST" do
  it "creates a board" do
    board_params = {"title"=>"this is a test", "text"=>"this is the text of the test", "board"=>{"title"=>"this is a test", "text"=>"this is the text of the test"}}.to_json
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }

    post "/boards", board_params, request_headers

    expect(response.status).to eq 201
    expect(Board.first.title).to eq "this is a test"
  end
end
