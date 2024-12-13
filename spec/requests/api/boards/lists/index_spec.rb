require 'rails_helper'

RSpec.describe "get /api/boards/:board_id/lists", type: :request do
  let(:json) { JSON.parse(response.body) }

  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }

  let!(:lists) { FactoryBot.create_list(:list, 3, board:) }

  let!(:items) do
    lists.each do |list|
      FactoryBot.create_list(:item, 2, list:)
    end
  end

  before { sign_in user }

  it "succeed" do
    get api_board_lists_path(board)

    expect(response).to have_http_status(:success)
    expect(json.dig("data").count).to eq(3)
    json.dig("data").each do |list_data|
      expect(list_data.dig("attributes", "items", "data").count).to eq(2)
    end
  end
end
