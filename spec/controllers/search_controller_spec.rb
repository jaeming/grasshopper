require 'rails_helper'
RSpec.describe SearchController, :type => :controller do

  it "searches for text in models" do
    board = create(:board, title: "Hello World!")
    Board.import force: true, refresh: true

    get :index, {:q => "Hello"}, { "Accept" => "application/json" }
    title = JsonPath.on(response.body, '$..title')

    expect(title).to include("Hello World!")
  end
end
