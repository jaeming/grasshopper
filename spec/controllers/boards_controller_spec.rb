require 'rails_helper'
describe BoardsController, type: :controller do

  it "returns all boards" do
    create(:board, title: "Hello World!")
    get :index, {}, { "Accept" => "application/json" }

    body = JSON.parse(response.body)
    board_title = body.map { |m| m["title"] }

    expect(response.status).to eq 200
    expect(board_title).to include("Hello World!")
  end

  it "creates a board" do
    login
    board_params = {"title"=>"this is a test", "text"=>"this is the text of the test", "format" => "json"}

    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }

    post :create, board_params, request_headers

    expect(response.status).to eq 201
    expect(assigns(:board).title).to eq "this is a test"
  end
end