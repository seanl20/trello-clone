require 'rails_helper'

RSpec.describe "get /api/boards/:board_id/lists", type: :request do
  let(:json) { JSON.parse(response.body) }

  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, user:) }

  let!(:list_1) { FactoryBot.create(:list, board:) }
  let!(:list_2) { FactoryBot.create(:list, board:) }
  let!(:list_3) { FactoryBot.create(:list, board:) }

  before { sign_in user }

  it "succeed" do
    get api_board_lists_path(board)

    expect(response).to have_http_status(:success)
    expect(json["data"].count).to eq(3)
  end
end
